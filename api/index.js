const express = require("express");
const cors = require("cors");
const app = express();
const stripe = require("stripe")(
  "sk_test_51R7MoyFVZtoK32uMo4r0GBfzVL1PYjsjJVrLJTXuERMo8nld5P1OgV1m8L3ijwdQdCMjslpoRhYSxo18HLmoolb000Zyg3BkYe"
);

// Configurar CORS
app.use(cors());
app.use(express.static("public"));
app.use(express.json());

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
    success_url: "http://localhost:5500/success.html?product_id=123456789",
    cancel_url: "http://localhost:5500/cancel.html",
  });

  res.json({ id: session.id });
});

app.get("/productos", (req, res) => {
  res.json(productos);
});

app.get("/producto/:id", (req, res) => {
  const id = parseInt(req.params.id);
  const producto = productos.find((p) => p.id === id);

  if (!producto) {
    return res.status(404).json({ error: "Producto no encontrado" });
  }

  res.json(producto);
});

app.listen(8001, "0.0.0.0", () =>
  console.log("Servidor escuchando en http://0.0.0.0:8001")
);
