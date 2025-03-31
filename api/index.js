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
  const session = await stripe.checkout.sessions.create({
    payment_method_types: ["card"],
    line_items: [
      {
        price_data: {
          currency: "usd",
          product_data: {
            name: "Producto de ejemplo",
          },
          unit_amount: 2000,
        },
        quantity: 1,
      },
    ],
    mode: "payment",
    success_url: "http://localhost:8000/success.html?product_id=123456789",
    cancel_url:
      "http://localhost:8000/failed.html?product_id=123456789&error_code=processing_error",
  });

  res.json({ id: session.id });
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
