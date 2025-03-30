// Inicializa Stripe con tu clave pública
const stripe = Stripe("pk_test_51R7MoyFVZtoK32uMs8OXRk1yLWEmLYxhn0fQ7vWT7rclJvnZveo6e1c924rkghttvZJygkwtsbBuljgC0HhYCMKg006sOppzdr");

document.getElementById("checkout-button").addEventListener("click", () => {
  fetch("http://localhost:8001/create-checkout-session", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((res) => res.json())
    .then((session) => {
      return stripe.redirectToCheckout({ sessionId: session.id });
    })
    .then((result) => {
      if (result.error) {
        alert(result.error.message);
      }
    })
    .catch((error) => {
      console.error("Error:", error);
    });
});
