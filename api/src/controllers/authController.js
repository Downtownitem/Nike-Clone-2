const db = require("../db");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

exports.login = async (req, res) => {
  const { email, password } = req.body;

  const [rows] = await db.query("SELECT * FROM usuarios WHERE email = ?", [
    email,
  ]);
  if (rows.length === 0)
    return res.status(400).json({ message: "Usuario no encontrado" });

  const user = rows[0];
  const match = await bcrypt.compare(password, user.password);
  if (!match) return res.status(400).json({ message: "Contraseña incorrecta" });

  const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, {
    expiresIn: "1h",
  });
  res.json({ token });
};
