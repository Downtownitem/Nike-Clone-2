const express = require("express");
const router = express.Router();
const auth = require("../auth");
const cart = require("../controllers/cartController");

router.get("/", auth, cart.getCart);
router.post("/add", auth, cart.addToCart);
router.get("/init", auth, cart.getOrCreateCart);

module.exports = router;
