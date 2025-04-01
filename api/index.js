const express = require("express");
const cors = require("cors");
const app = express();
const stripe = require("stripe")(
  "sk_test_51R7MoyFVZtoK32uMo4r0GBfzVL1PYjsjJVrLJTXuERMo8nld5P1OgV1m8L3ijwdQdCMjslpoRhYSxo18HLmoolb000Zyg3BkYe"
);
const pool = require("./src/db");

// Configurar CORS
app.use(cors());
app.use(express.static("public"));
app.use(express.json());

app.post("/create-checkout-session", async (req, res) => {
  const { usuario_id, productos } = req.body;

  if (!usuario_id || !productos || typeof productos !== "object") {
    return res.status(400).json({ error: "Datos inválidos" });
  }

  try {
    const productIds = Object.keys(productos).map(id => parseInt(id));
    const placeholders = productIds.map(() => '?').join(',');
    const query = `SELECT id, nombre, descripcion, precio FROM productos WHERE id IN (${placeholders})`;
    const [rows] = await pool.query(query, productIds);

    if (rows.length === 0) {
      return res.status(404).json({ error: "No se encontraron productos" });
    }

    let total = 0;
    const line_items = rows.map(producto => {
      const quantity = productos[producto.id]?.quantity || 1;
      const price = parseFloat(producto.precio);
      total += price * quantity;
      return {
        price_data: {
          currency: "usd",
          product_data: {
            name: producto.nombre,
            description: producto.descripcion,
          },
          unit_amount: Math.round(price * 100),
        },
        quantity,
      };
    });

    const session = await stripe.checkout.sessions.create({
      payment_method_types: ["card"],
      line_items,
      mode: "payment",
      metadata: {
        usuario_id: String(usuario_id),
      },
      success_url: `http://localhost:8000/success.html?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `http://localhost:8000/failed.html?session_id={CHECKOUT_SESSION_ID}`,
    });

    // ✅ Guardar pedido con la nueva columna: payment_session_id
    const insertPedidoQuery = `
      INSERT INTO pedidos (usuario_id, total, estado, payment_session_id)
      VALUES (?, ?, 'pendiente', ?)
    `;
    const [pedidoResult] = await pool.query(insertPedidoQuery, [
      usuario_id,
      total.toFixed(2),
      session.id,
    ]);
    const pedido_id = pedidoResult.insertId;

    const insertDetalleQuery = `
      INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio)
      VALUES ?
    `;
    const detalleValues = rows.map(producto => {
      const quantity = productos[producto.id]?.quantity || 1;
      const price = parseFloat(producto.precio);
      return [pedido_id, producto.id, quantity, price];
    });
    await pool.query(insertDetalleQuery, [detalleValues]);

    res.json({ id: session.id });
  } catch (error) {
    console.error("Error al crear sesión de pago:", error);
    res.status(500).json({ error: "Error al crear sesión de pago" });
  }
});

app.post("/update-order-status", async (req, res) => {
  const { session_id, estado } = req.body;

  if (!session_id || !estado) {
    return res.status(400).json({ error: "Datos inválidos" });
  }

  const estadosValidos = ["pendiente", "completado", "cancelado"];
  if (!estadosValidos.includes(estado)) {
    return res.status(400).json({ error: "Estado inválido" });
  }

  try {
    // Si quieren marcarlo como 'completado', verificar que Stripe lo confirme
    if (estado === "completado") {
      const session = await stripe.checkout.sessions.retrieve(session_id);

      if (session.payment_status !== "paid") {
        return res.status(400).json({ error: "El pago aún no ha sido confirmado como exitoso por Stripe." });
      }
    }

    const updateQuery = `
      UPDATE pedidos
      SET estado = ?
      WHERE payment_session_id = ?
    `;
    const [result] = await pool.query(updateQuery, [estado, session_id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Pedido no encontrado" });
    }

    res.json({ message: "Estado actualizado correctamente" });
  } catch (error) {
    console.error("Error al actualizar el estado del pedido:", error);
    res.status(500).json({ error: "Error al actualizar el estado del pedido" });
  }
});


app.post("/registrar_usuario", async (req, res) => {
  const { nombre, apellido, email, document_type, document, phone_number } =
    req.body;

  if (!nombre || !email) {
    return res.status(400).json({ error: "Nombre y email son obligatorios" });
  }

  try {
    const [result] = await pool.query(
      `
      INSERT INTO usuarios (nombre, apellido, email, document_type, document, phone_number)
      VALUES (?, ?, ?, ?, ?, ?)
    `,
      [nombre, apellido, email, document_type, document, phone_number]
    );

    res.json({ id: result.insertId });
  } catch (error) {
    console.error("Error al insertar usuario:", error);
    res.status(500).json({ error: "Error al insertar usuario" });
  }
});

app.get("/productos", async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM productos");

    const productos = rows.map((producto) => ({
      id: producto.id,
      nombre: producto.nombre,
      descripcion: producto.descripcion,
      precio: parseFloat(producto.precio),
      categoria: producto.categoria,
      disponibilidad: producto.disponibilidad,
      calificacion: parseFloat(producto.calificacion),
      numero_resenas: producto.numero_resenas,
      url_imagen: producto.url_imagen,
    }));

    res.json(productos);
  } catch (error) {
    console.error("Error al obtener productos:", error);
    res.status(500).json({ error: "Error al obtener productos" });
  }
});

app.get("/producto/:id", async (req, res) => {
  const id = parseInt(req.params.id);

  try {
    const [rows] = await pool.query("SELECT * FROM productos WHERE id = ?", [id]);

    if (rows.length === 0) {
      return res.status(404).json({ error: "Producto no encontrado" });
    }

    const producto = rows[0];

    const formattedProducto = {
      id: producto.id,
      nombre: producto.nombre,
      descripcion: producto.descripcion,
      precio: parseFloat(producto.precio),
      categoria: producto.categoria,
      disponibilidad: producto.disponibilidad,
      calificacion: parseFloat(producto.calificacion),
      numero_resenas: producto.numero_resenas,
      url_imagen: producto.url_imagen,
    };

    res.json(formattedProducto);
  } catch (error) {
    console.error("Error al obtener producto:", error);
    res.status(500).json({ error: "Error al obtener producto" });
  }
});

// ==============================
// Endpoints para administración de USUARIOS
// ==============================

// Obtener todos los usuarios
app.get("/admin/usuarios", async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM usuarios");
    res.json(rows);
  } catch (error) {
    console.error("Error al obtener usuarios:", error);
    res.status(500).json({ error: "Error al obtener usuarios" });
  }
});

// Obtener un usuario en específico por ID
app.get("/admin/usuarios/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const [rows] = await pool.query("SELECT * FROM usuarios WHERE id = ?", [id]);
    if (rows.length === 0) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }
    res.json(rows[0]);
  } catch (error) {
    console.error("Error al obtener usuario:", error);
    res.status(500).json({ error: "Error al obtener usuario" });
  }
});

// Agregar un nuevo usuario
app.post("/admin/usuarios", async (req, res) => {
  const { nombre, apellido, email, document_type, document, phone_number } = req.body;
  if (!nombre || !email) {
    return res.status(400).json({ error: "Nombre y email son obligatorios" });
  }
  try {
    const [result] = await pool.query(
      "INSERT INTO usuarios (nombre, apellido, email, document_type, document, phone_number) VALUES (?, ?, ?, ?, ?, ?)",
      [nombre, apellido, email, document_type, document, phone_number]
    );
    res.json({ id: result.insertId, message: "Usuario creado exitosamente" });
  } catch (error) {
    console.error("Error al crear usuario:", error);
    res.status(500).json({ error: "Error al crear usuario" });
  }
});

// Modificar un usuario existente
app.put("/admin/usuarios/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  const { nombre, apellido, email, document_type, document, phone_number } = req.body;
  try {
    const [result] = await pool.query(
      "UPDATE usuarios SET nombre = ?, apellido = ?, email = ?, document_type = ?, document = ?, phone_number = ? WHERE id = ?",
      [nombre, apellido, email, document_type, document, phone_number, id]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }
    res.json({ message: "Usuario actualizado exitosamente" });
  } catch (error) {
    console.error("Error al actualizar usuario:", error);
    res.status(500).json({ error: "Error al actualizar usuario" });
  }
});

// Eliminar un usuario
app.delete("/admin/usuarios/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const [result] = await pool.query("DELETE FROM usuarios WHERE id = ?", [id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }
    res.json({ message: "Usuario eliminado exitosamente" });
  } catch (error) {
    console.error("Error al eliminar usuario:", error);
    res.status(500).json({ error: "Error al eliminar usuario" });
  }
});

// ==============================
// Endpoints para administración de PRODUCTOS
// ==============================

// Obtener todos los productos
app.get("/admin/productos", async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM productos");
    res.json(rows);
  } catch (error) {
    console.error("Error al obtener productos:", error);
    res.status(500).json({ error: "Error al obtener productos" });
  }
});

// Obtener un producto en específico por ID
app.get("/admin/productos/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const [rows] = await pool.query("SELECT * FROM productos WHERE id = ?", [id]);
    if (rows.length === 0) {
      return res.status(404).json({ error: "Producto no encontrado" });
    }
    res.json(rows[0]);
  } catch (error) {
    console.error("Error al obtener producto:", error);
    res.status(500).json({ error: "Error al obtener producto" });
  }
});

// Agregar un nuevo producto
app.post("/admin/productos", async (req, res) => {
  const { nombre, descripcion, precio, categoria, disponibilidad, calificacion, numero_resenas, url_imagen } = req.body;
  if (!nombre || precio === undefined) {
    return res.status(400).json({ error: "Nombre y precio son obligatorios" });
  }
  try {
    const [result] = await pool.query(
      "INSERT INTO productos (nombre, descripcion, precio, categoria, disponibilidad, calificacion, numero_resenas, url_imagen) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      [nombre, descripcion, precio, categoria, disponibilidad, calificacion, numero_resenas, url_imagen]
    );
    res.json({ id: result.insertId, message: "Producto creado exitosamente" });
  } catch (error) {
    console.error("Error al crear producto:", error);
    res.status(500).json({ error: "Error al crear producto" });
  }
});

// Modificar un producto existente
app.put("/admin/productos/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  const { nombre, descripcion, precio, categoria, disponibilidad, calificacion, numero_resenas, url_imagen } = req.body;
  try {
    const [result] = await pool.query(
      "UPDATE productos SET nombre = ?, descripcion = ?, precio = ?, categoria = ?, disponibilidad = ?, calificacion = ?, numero_resenas = ?, url_imagen = ? WHERE id = ?",
      [nombre, descripcion, precio, categoria, disponibilidad, calificacion, numero_resenas, url_imagen, id]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Producto no encontrado" });
    }
    res.json({ message: "Producto actualizado exitosamente" });
  } catch (error) {
    console.error("Error al actualizar producto:", error);
    res.status(500).json({ error: "Error al actualizar producto" });
  }
});

// Eliminar un producto
app.delete("/admin/productos/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const [result] = await pool.query("DELETE FROM productos WHERE id = ?", [id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Producto no encontrado" });
    }
    res.json({ message: "Producto eliminado exitosamente" });
  } catch (error) {
    console.error("Error al eliminar producto:", error);
    res.status(500).json({ error: "Error al eliminar producto" });
  }
});

// ==============================
// Endpoint para ver los PEDIDOS de un USUARIO específico
// ==============================

// Obtener los pedidos (con detalles) de un usuario dado su ID
app.get("/admin/usuarios/:id/pedidos", async (req, res) => {
  const usuarioId = parseInt(req.params.id);
  try {
    // Obtener los pedidos realizados por el usuario
    const [orders] = await pool.query("SELECT * FROM pedidos WHERE usuario_id = ?", [usuarioId]);
    if (orders.length === 0) {
      return res.status(404).json({ error: "No se encontraron pedidos para este usuario" });
    }

    // Para cada pedido, se obtienen los detalles de los productos incluidos
    const ordersWithDetails = [];
    for (const order of orders) {
      const [details] = await pool.query("SELECT * FROM detalle_pedidos WHERE pedido_id = ?", [order.id]);
      ordersWithDetails.push({ ...order, detalles: details });
    }
    res.json(ordersWithDetails);
  } catch (error) {
    console.error("Error al obtener pedidos del usuario:", error);
    res.status(500).json({ error: "Error al obtener pedidos del usuario" });
  }
});


app.listen(8001, "0.0.0.0", () =>
  console.log("Servidor escuchando en http://0.0.0.0:8001")
);
