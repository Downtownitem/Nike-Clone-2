const db = require("../db");

exports.getOrCreateCart = async (req, res) => {
  const userId = req.userId;

  let result = await db.query("SELECT * FROM carritos WHERE usuario_id = $1", [
    userId,
  ]);
  if (result.rows.length === 0) {
    result = await db.query(
      "INSERT INTO carritos (usuario_id) VALUES ($1) RETURNING *",
      [userId]
    );
  }

  res.json(result.rows[0]);
};

exports.addToCart = async (req, res) => {
  const userId = req.userId;
  const { producto_id, cantidad } = req.body;

  const carrito = await db.query(
    "SELECT id FROM carritos WHERE usuario_id = $1",
    [userId]
  );
  if (carrito.rows.length === 0)
    return res.status(404).json({ msg: "Carrito no encontrado" });

  const carrito_id = carrito.rows[0].id;

  await db.query(
    `
    INSERT INTO carrito_items (carrito_id, producto_id, cantidad)
    VALUES ($1, $2, $3)
    ON CONFLICT (carrito_id, producto_id) DO UPDATE SET cantidad = carrito_items.cantidad + EXCLUDED.cantidad
  `,
    [carrito_id, producto_id, cantidad]
  );

  res.json({ msg: "Producto agregado" });
};

exports.getCart = async (req, res) => {
  const userId = req.userId;

  const carrito = await db.query(
    "SELECT id FROM carritos WHERE usuario_id = $1",
    [userId]
  );
  if (carrito.rows.length === 0) return res.json({ items: [] });

  const carrito_id = carrito.rows[0].id;

  const items = await db.query(
    `
    SELECT ci.id, p.nombre, p.precio, ci.cantidad, p.url_imagen
    FROM carrito_items ci
    JOIN productos p ON p.id = ci.producto_id
    WHERE ci.carrito_id = $1
  `,
    [carrito_id]
  );

  res.json(items.rows);
};
