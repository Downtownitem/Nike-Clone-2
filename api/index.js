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

const productos = require("./productos_zapatos.json");

app.post("/create-checkout-session", async (req, res) => {
  const { usuario_id, productos } = req.body;

  if (!usuario_id || !productos || typeof productos !== "object") {
    return res.status(400).json({ error: "Datos inválidos" });
  }

  try {
    const productIds = Object.keys(productos).map((id) => parseInt(id));
    const query = `
      SELECT id, nombre, descripcion, precio
      FROM productos
      WHERE id = ANY($1)
    `;
    const result = await pool.query(query, [productIds]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "No se encontraron productos" });
    }

    const line_items = result.rows.map((producto) => {
      const quantity = productos[producto.id]?.quantity || 1;
      return {
        price_data: {
          currency: "usd",
          product_data: {
            name: producto.nombre,
            description: producto.descripcion,
          },
          unit_amount: Math.round(parseFloat(producto.precio) * 100), // Stripe usa centavos
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

    res.json({ id: session.id });
  } catch (error) {
    console.error("Error al crear sesión de pago:", error);
    res.status(500).json({ error: "Error al crear sesión de pago" });
  }
});

app.post("/registrar_usuario", async (req, res) => {
  const { nombre, apellido, email, document_type, document, phone_number } =
    req.body;

  if (!nombre || !email) {
    return res.status(400).json({ error: "Nombre y email son obligatorios" });
  }

  try {
    const result = await pool.query(
      `
      INSERT INTO usuarios (nombre, apellido, email, document_type, document, phone_number)
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING id
      `,
      [nombre, apellido, email, document_type, document, phone_number]
    );

    res.json({ id: result.rows[0].id });
  } catch (error) {
    console.error("Error al insertar usuario:", error);

    // Evita exponer errores de base de datos al cliente en producción
    res.status(500).json({ error: "Error al insertar usuario" });
  }
});

app.get("/productos", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM productos");

    const productos = result.rows.map((producto) => ({
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
    const result = await pool.query("SELECT * FROM productos WHERE id = $1", [
      id,
    ]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Producto no encontrado" });
    }

    const producto = result.rows[0];

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

app.use("/api/cart", require("./src/routers/cartRouter"));
app.use("/api/auth", require("./src/routers/authRouter"));

app.listen(8001, "0.0.0.0", () =>
  console.log("Servidor escuchando en http://0.0.0.0:8001")
);
