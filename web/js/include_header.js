// header.js
(function () {
  const headerHTML = `
      <div class="top-header">
        <a href="#">Eventos</a>
        <a href="#">Ayuda</a>
        <a href="#">Regístrate</a>
        <a href="#">Buscar tienda</a>
      </div>
  
      <header class="main-header" style="position: relative">
        <div class="logo">
          <img src="./static/logo.png" alt="Nike Logo" style="width: 60px; height: 60px" />
        </div>
  
        <nav>
          <ul class="nav-menu">
            <li><a href="#">Novedades</a></li>
            <li><a href="#">Hombre</a></li>
            <li><a href="#">Mujer</a></li>
            <li><a href="#">Niños</a></li>
            <li><a href="#">Accesorios</a></li>
            <li><a href="#">Descuentos</a></li>
          </ul>
        </nav>
  
        <div class="nav-right">
          <div class="search-bar">
            <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="11" cy="11" r="8"></circle>
              <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
            <input type="text" placeholder="Buscar" />
          </div>
          <a href="/cart.html" class="cart">
            <svg class="cart-icon" viewBox="0 0 24 24" stroke="black" stroke-width="2" stroke-linecap="round"
              stroke-linejoin="round">
              <circle cx="9" cy="21" r="1"></circle>
              <circle cx="20" cy="21" r="1"></circle>
              <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
            </svg>
          </a>
        </div>
      </header>
    `;

  const style = document.createElement("link");
  style.rel = "stylesheet";
  style.href = "./css/shop-header.css";
  document.head.appendChild(style);

  const container = document.getElementById("header");
  if (container) {
    container.innerHTML = headerHTML;
  }
})();
