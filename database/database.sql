CREATE DATABASE tienda_virtual;

create table
    usuarios (
        id serial primary key,
        nombre varchar(255) not null,
        email varchar(255) not null unique,
        apellido varchar,
        document_type varchar,
        document varchar,
        phone_number varchar
    );

CREATE TABLE
    productos (
        id INT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL,
        descripcion TEXT,
        precio NUMERIC(10, 2),
        categoria VARCHAR(100),
        disponibilidad BOOLEAN,
        calificacion FLOAT,
        numero_resenas INT,
        url_imagen TEXT
    );

CREATE TABLE
    carritos (
        id SERIAL PRIMARY KEY,
        usuario_id INT REFERENCES usuarios (id) ON DELETE CASCADE,
        creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE
    carrito_items (
        id SERIAL PRIMARY KEY,
        carrito_id INT REFERENCES carritos (id) ON DELETE CASCADE,
        producto_id INT REFERENCES productos (id),
        cantidad INT DEFAULT 1,
        UNIQUE (carrito_id, producto_id)
    );

CREATE TABLE
    pedidos (
        id SERIAL PRIMARY KEY,
        usuario_id INT REFERENCES usuarios (id),
        fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        total NUMERIC(10, 2)
    );

CREATE TABLE
    detalle_pedidos (
        id SERIAL PRIMARY KEY,
        pedido_id INT REFERENCES pedidos (id),
        producto_id INT REFERENCES productos (id),
        cantidad INT,
        precio NUMERIC(10, 2)
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        1,
        'Botas de montaña azules',
        'Comodidad y estilo para cualquier ocasión.',
        104.71,
        'Infantiles',
        true,
        3.7,
        168,
        'https://img.freepik.com/free-photo/young-couple-love-posing-old-town-cropped-feet_285396-3218.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        2,
        'Mocasines de ante rojos',
        'Disponibles en varios colores y tallas.',
        61.78,
        'Fiesta',
        true,
        4.7,
        299,
        'https://img.freepik.com/free-vector/random-female-shoes-flat-illustrations-set-summer-autumn-winter-foot-wear-women-moccasins-boots-trainers-heels-isolated-white_74855-20699.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        3,
        'Botas de montaña verdes',
        'Hechos a mano por artesanos locales.',
        52.62,
        'Infantiles',
        false,
        4.1,
        291,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-169.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        4,
        'Botines de tacón verdes',
        'Fabricados con materiales reciclados y sostenibles.',
        77.17,
        'Casuales',
        true,
        4.4,
        260,
        'https://img.freepik.com/free-photo/brown-leather-shoes_1203-8174.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        5,
        'Botines de tacón dorados',
        'Fabricados con materiales reciclados y sostenibles.',
        92.85,
        'Trabajo',
        true,
        4.7,
        271,
        'https://img.freepik.com/free-photo/brown-leather-shoes_1203-8174.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        6,
        'Zapatillas ecológicas azules',
        'Hechos a mano por artesanos locales.',
        64.19,
        'Casuales',
        false,
        3.7,
        216,
        'https://img.freepik.com/free-vector/hand-drawn-shoe-outline-illustration_23-2150969937.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        7,
        'Zapatos de tacón beige',
        'Fabricados con materiales reciclados y sostenibles.',
        34.47,
        'Infantiles',
        true,
        3.7,
        80,
        'https://img.freepik.com/free-photo/sitting-female-legs-boots-with-flowers-inside_23-2148098451.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        8,
        'Zapatos de cuero rojos',
        'Diseño ergonómico para máxima comodidad.',
        138.47,
        'Trabajo',
        true,
        4.7,
        148,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-640.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        9,
        'Zapatos sin cordones rojos',
        'Comodidad y estilo para cualquier ocasión.',
        68.0,
        'Botas',
        false,
        3.9,
        223,
        'https://img.freepik.com/free-photo/male-foot-with-brown-leather-shoes-jeans_1150-6001.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        10,
        'Zapatos Derby beige',
        'Diseño ergonómico para máxima comodidad.',
        93.06,
        'Tacones',
        true,
        3.7,
        217,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-161.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        11,
        'Botines de tacón dorados',
        'Ideales para caminar, correr o actividades al aire libre.',
        128.12,
        'Sandalias',
        true,
        4.9,
        296,
        'https://img.freepik.com/free-vector/high-heels-icon-collection_1346-50.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        12,
        'Sandalias planas blancos',
        'Fabricados con materiales reciclados y sostenibles.',
        72.86,
        'Infantiles',
        false,
        4.3,
        49,
        'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        13,
        'Botines Chelsea negros',
        'Ligereza, flexibilidad y buena ventilación.',
        88.44,
        'Formales',
        true,
        3.8,
        253,
        'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        14,
        'Botines Chelsea negros',
        'Disponibles en varios colores y tallas.',
        81.46,
        'Sostenibles',
        true,
        4.1,
        49,
        'https://img.freepik.com/premium-photo/sneakers_1056055-722.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        15,
        'Sandalias artesanales verdes',
        'Diseño ergonómico para máxima comodidad.',
        51.86,
        'Trabajo',
        false,
        4.4,
        258,
        'https://img.freepik.com/free-photo/sport-running-shoes_1203-3414.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        16,
        'Botas militares verdes',
        'Comodidad y estilo para cualquier ocasión.',
        39.53,
        'Tacones',
        true,
        4.6,
        273,
        'https://img.freepik.com/free-photo/leather-shoes-wooden-background_1203-7617.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        17,
        'Botines Chelsea azules',
        'Diseño ergonómico para máxima comodidad.',
        38.47,
        'Mocasines',
        true,
        4.3,
        142,
        'https://img.freepik.com/premium-photo/shoes-girls_1056055-572.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        18,
        'Zapatillas urbanas negros',
        'Diseño moderno con materiales de alta calidad.',
        109.12,
        'Botas',
        true,
        3.6,
        224,
        'https://img.freepik.com/free-photo/low-section-businessman-s-hand-tying-shoelace_23-2147937473.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        19,
        'Botines de tacón negros',
        'Fabricados con materiales reciclados y sostenibles.',
        79.63,
        'Deportivas',
        true,
        4.0,
        157,
        'https://img.freepik.com/free-photo/brown-shoes-isolated-white-background_268835-1352.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        20,
        'Zapatos sin cordones negros',
        'Hechos a mano por artesanos locales.',
        134.36,
        'Tacones',
        true,
        4.3,
        117,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-169.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        21,
        'Zapatos de cuero verdes',
        'Elegancia clásica con un toque contemporáneo.',
        93.9,
        'Infantiles',
        false,
        4.0,
        243,
        'https://img.freepik.com/free-vector/front-side-view-female-shoes-vector-illustrations-set_778687-1264.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        22,
        'Zapatos sin cordones negros',
        'Disponibles en varios colores y tallas.',
        106.64,
        'Botas',
        true,
        4.1,
        215,
        'https://img.freepik.com/free-photo/composition-beautiful-mother-s-day-elements_23-2148888529.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        23,
        'Sandalias artesanales rojos',
        'Hechos a mano por artesanos locales.',
        91.68,
        'Formales',
        true,
        4.5,
        88,
        'https://img.freepik.com/free-photo/brown-leather-shoes_1203-8175.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        24,
        'Zapatillas urbanas dorados',
        'Ligereza, flexibilidad y buena ventilación.',
        77.01,
        'Botas',
        false,
        4.4,
        27,
        'https://img.freepik.com/premium-photo/shoes-girls_1056055-584.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        25,
        'Zapatillas deportivas azules',
        'Diseño ergonómico para máxima comodidad.',
        37.46,
        'Trabajo',
        false,
        4.1,
        181,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-635.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        26,
        'Zapatos de tacón beige',
        'Diseño ergonómico para máxima comodidad.',
        34.11,
        'Casuales',
        true,
        4.5,
        182,
        'https://img.freepik.com/free-photo/brown-shoes-isolated-white-background_268835-1352.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        27,
        'Zapatos de cuero azules',
        'Diseño ergonómico para máxima comodidad.',
        86.09,
        'Formales',
        true,
        4.4,
        208,
        'https://img.freepik.com/free-vector/creative-female-footwear-flat-pictures-set_74855-16838.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        28,
        'Zapatos de tacón beige',
        'Elegancia clásica con un toque contemporáneo.',
        107.42,
        'Sostenibles',
        false,
        3.9,
        113,
        'https://img.freepik.com/free-vector/creative-female-footwear-flat-pictures-set_74855-16838.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        29,
        'Zapatillas urbanas beige',
        'Diseño ergonómico para máxima comodidad.',
        132.02,
        'Botines',
        true,
        4.7,
        249,
        'https://img.freepik.com/free-psd/stylish-brown-leather-ankle-boots-mens-footwear-fashionable-design_632498-45307.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        30,
        'Alpargatas de lona negros',
        'Ligereza, flexibilidad y buena ventilación.',
        119.65,
        'Urbanas',
        false,
        4.3,
        209,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-176.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        31,
        'Botines de tacón marrones',
        'Comodidad y estilo para cualquier ocasión.',
        81.53,
        'Botas',
        true,
        4.3,
        105,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-640.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        32,
        'Botines de tacón verdes',
        'Disponibles en varios colores y tallas.',
        71.53,
        'Sostenibles',
        false,
        4.2,
        255,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-175.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        33,
        'Sandalias planas marrones',
        'Disponibles en varios colores y tallas.',
        137.23,
        'Mocasines',
        true,
        4.7,
        210,
        'https://img.freepik.com/free-psd/stylish-brown-leather-ankle-boot-men39s-footwear-fashionable-design_632498-45309.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        34,
        'Botines Chelsea rojos',
        'Diseño ergonómico para máxima comodidad.',
        92.39,
        'Infantiles',
        false,
        4.0,
        112,
        'https://img.freepik.com/free-photo/low-section-businessman-s-hand-tying-shoelace_23-2147937473.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        35,
        'Zapatos de cuero azules',
        'Fabricados con materiales reciclados y sostenibles.',
        116.81,
        'Sandalias',
        true,
        3.5,
        102,
        'https://img.freepik.com/free-psd/stylish-brown-leather-ankle-boot-men39s-footwear-fashionable-design_632498-45309.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        36,
        'Zapatillas urbanas rojos',
        'Perfectos para el uso diario o salidas especiales.',
        65.14,
        'Sandalias',
        true,
        4.1,
        235,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-189.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        37,
        'Botines Chelsea rojos',
        'Disponibles en varios colores y tallas.',
        129.53,
        'Formales',
        false,
        3.6,
        258,
        'https://img.freepik.com/free-photo/shoes_1203-8153.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        38,
        'Alpargatas de lona verdes',
        'Perfectos para el uso diario o salidas especiales.',
        98.34,
        'Urbanas',
        false,
        3.6,
        69,
        'https://img.freepik.com/free-psd/stylish-brown-leather-ankle-boot-men39s-footwear-fashionable-design_632498-45309.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        39,
        'Zapatillas deportivas verdes',
        'Fabricados con materiales reciclados y sostenibles.',
        44.55,
        'Urbanas',
        true,
        3.7,
        73,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-640.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        40,
        'Zapatillas urbanas blancos',
        'Ideales para caminar, correr o actividades al aire libre.',
        63.8,
        'Trabajo',
        false,
        3.6,
        85,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-175.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        41,
        'Zapatillas urbanas negros',
        'Perfectos para el uso diario o salidas especiales.',
        98.44,
        'Sandalias',
        true,
        4.6,
        17,
        'https://img.freepik.com/free-photo/brown-leather-shoes_1203-7562.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        42,
        'Zapatillas ecológicas negros',
        'Diseño moderno con materiales de alta calidad.',
        61.84,
        'Sandalias',
        true,
        4.8,
        286,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-640.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        43,
        'Botines de tacón verdes',
        'Comodidad y estilo para cualquier ocasión.',
        104.72,
        'Alpargatas',
        false,
        4.1,
        99,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-640.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        44,
        'Zapatos Derby beige',
        'Comodidad y estilo para cualquier ocasión.',
        38.74,
        'Casuales',
        true,
        4.3,
        29,
        'https://img.freepik.com/free-psd/stylish-brown-leather-ankle-boot-men39s-footwear-fashionable-design_632498-45309.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        45,
        'Zapatillas urbanas dorados',
        'Comodidad y estilo para cualquier ocasión.',
        118.53,
        'Alpargatas',
        true,
        4.5,
        291,
        'https://img.freepik.com/free-photo/crop-loving-couple-kissing-seafront_23-2147738350.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        46,
        'Zapatos de cuero rojos',
        'Comodidad y estilo para cualquier ocasión.',
        36.08,
        'Tacones',
        true,
        3.8,
        246,
        'https://img.freepik.com/premium-photo/sneakers_1056055-722.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        47,
        'Zapatillas de skate marrones',
        'Disponibles en varios colores y tallas.',
        49.04,
        'Deportivas',
        true,
        5.0,
        96,
        'https://img.freepik.com/free-photo/derby-shoes-men-formal-wear_53876-96609.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        48,
        'Zapatillas ecológicas negros',
        'Disponibles en varios colores y tallas.',
        45.56,
        'Formales',
        true,
        4.2,
        213,
        'https://img.freepik.com/free-psd/elegant-black-leather-oxfords-pair-polished-classic-mens-shoes_191095-86408.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        49,
        'Zapatos sin cordones marrones',
        'Diseño moderno con materiales de alta calidad.',
        125.42,
        'Alpargatas',
        true,
        3.7,
        20,
        'https://img.freepik.com/free-photo/brown-shoes-isolated-white-background-studio_268835-1354.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        50,
        'Sandalias de plataforma negros',
        'Disponibles en varios colores y tallas.',
        53.09,
        'Casuales',
        true,
        3.9,
        126,
        'https://img.freepik.com/free-photo/sport-running-shoes_1203-3414.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        51,
        'Botines de tacón dorados',
        'Disponibles en varios colores y tallas.',
        56.51,
        'Casuales',
        false,
        3.9,
        102,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-635.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        52,
        'Mocasines de ante negros',
        'Perfectos para el uso diario o salidas especiales.',
        128.61,
        'Deportivas',
        true,
        4.7,
        73,
        'https://img.freepik.com/premium-photo/sneakers_1056055-730.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        53,
        'Zapatillas de running beige',
        'Ligereza, flexibilidad y buena ventilación.',
        112.9,
        'Sostenibles',
        false,
        4.3,
        283,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-155.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        54,
        'Mocasines de ante beige',
        'Comodidad y estilo para cualquier ocasión.',
        72.76,
        'Mocasines',
        true,
        4.7,
        218,
        'https://img.freepik.com/free-vector/various-shoe-illustrations-set-footwear-sale-business-fashion-industry-clothing-shop-showcase-seasonal-sportive-elegant-apparel-sneakers-gumshoes-sandals-flip-flops-boots_575670-2237.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        55,
        'Zapatos casuales azules',
        'Diseño ergonómico para máxima comodidad.',
        92.4,
        'Mocasines',
        false,
        4.2,
        148,
        'https://img.freepik.com/free-vector/creative-female-footwear-flat-pictures-set_74855-16838.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        56,
        'Zapatos de tacón marrones',
        'Comodidad y estilo para cualquier ocasión.',
        85.02,
        'Botas',
        true,
        3.9,
        49,
        'https://img.freepik.com/premium-photo/shoes-girls-zapatos-taco-alto-mujer-calzado-sandalias_1056055-594.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        57,
        'Zapatillas ecológicas negros',
        'Diseño ergonómico para máxima comodidad.',
        87.0,
        'Fiesta',
        true,
        4.2,
        201,
        'https://img.freepik.com/premium-photo/shoes-girls_1056055-590.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        58,
        'Sandalias de plataforma dorados',
        'Ligereza, flexibilidad y buena ventilación.',
        137.9,
        'Botas',
        false,
        4.2,
        295,
        'https://img.freepik.com/free-photo/pair-brown-leather-boots_1150-6005.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        59,
        'Sandalias planas marrones',
        'Perfectos para el uso diario o salidas especiales.',
        56.75,
        'Alpargatas',
        true,
        4.7,
        147,
        'https://img.freepik.com/premium-photo/sneakers_1056055-722.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        60,
        'Botines de tacón marrones',
        'Hechos a mano por artesanos locales.',
        111.24,
        'Infantiles',
        true,
        4.5,
        230,
        'https://img.freepik.com/free-vector/various-shoe-illustrations-set-footwear-sale-business-fashion-industry-clothing-shop-showcase-seasonal-sportive-elegant-apparel-sneakers-gumshoes-sandals-flip-flops-boots_575670-2237.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        61,
        'Zapatos Oxford dorados',
        'Perfectos para el uso diario o salidas especiales.',
        118.0,
        'Botines',
        true,
        3.8,
        40,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-640.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        62,
        'Botas de montaña dorados',
        'Diseño moderno con materiales de alta calidad.',
        45.4,
        'Infantiles',
        true,
        4.1,
        130,
        'https://img.freepik.com/premium-photo/shoes-girls_1056055-605.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        63,
        'Zapatillas ecológicas blancos',
        'Elegancia clásica con un toque contemporáneo.',
        78.76,
        'Trabajo',
        true,
        4.2,
        131,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-155.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        64,
        'Zapatos de tacón verdes',
        'Perfectos para el uso diario o salidas especiales.',
        58.35,
        'Fiesta',
        true,
        3.9,
        150,
        'https://img.freepik.com/free-vector/front-side-view-female-shoes-vector-illustrations-set_778687-1264.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        65,
        'Botines de tacón marrones',
        'Fabricados con materiales reciclados y sostenibles.',
        73.94,
        'Tacones',
        true,
        3.8,
        94,
        'https://img.freepik.com/free-vector/front-side-view-female-shoes-vector-illustrations-set_778687-1264.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        66,
        'Botas militares blancos',
        'Disponibles en varios colores y tallas.',
        118.86,
        'Botas',
        true,
        3.5,
        98,
        'https://img.freepik.com/free-photo/brown-leather-shoes_1203-7562.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        67,
        'Zapatillas urbanas rojos',
        'Elegancia clásica con un toque contemporáneo.',
        44.57,
        'Sandalias',
        false,
        4.8,
        180,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-176.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        68,
        'Sandalias planas negros',
        'Fabricados con materiales reciclados y sostenibles.',
        62.56,
        'Botines',
        true,
        4.3,
        24,
        'https://img.freepik.com/free-photo/pair-brown-leather-boots_1150-6005.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        69,
        'Zapatos Oxford azules',
        'Elegancia clásica con un toque contemporáneo.',
        62.34,
        'Sandalias',
        false,
        4.3,
        93,
        'https://img.freepik.com/free-photo/derby-shoes-men-formal-wear_53876-96609.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        70,
        'Zapatos Derby beige',
        'Ligereza, flexibilidad y buena ventilación.',
        148.09,
        'Trabajo',
        false,
        3.7,
        187,
        'https://img.freepik.com/free-vector/front-side-view-female-shoes-vector-illustrations-set_778687-1264.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        71,
        'Zapatos casuales azules',
        'Hechos a mano por artesanos locales.',
        88.94,
        'Alpargatas',
        true,
        4.9,
        217,
        'https://img.freepik.com/premium-photo/shoes-girls_1056055-590.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        72,
        'Zapatos Oxford blancos',
        'Ligereza, flexibilidad y buena ventilación.',
        32.98,
        'Deportivas',
        false,
        3.5,
        143,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-157.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        73,
        'Zapatos de cuero marrones',
        'Diseño ergonómico para máxima comodidad.',
        117.7,
        'Sostenibles',
        true,
        4.4,
        69,
        'https://img.freepik.com/premium-photo/sneakers_1056055-730.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        74,
        'Zapatos de tacón rojos',
        'Hechos a mano por artesanos locales.',
        92.47,
        'Botines',
        true,
        3.8,
        279,
        'https://img.freepik.com/free-photo/crop-loving-couple-kissing-seafront_23-2147738350.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        75,
        'Sandalias planas blancos',
        'Ideales para caminar, correr o actividades al aire libre.',
        105.3,
        'Trabajo',
        false,
        4.0,
        151,
        'https://img.freepik.com/free-psd/stylish-brown-leather-ankle-boots-mens-footwear-fashionable-design_632498-45307.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        76,
        'Zapatos sin cordones dorados',
        'Diseño ergonómico para máxima comodidad.',
        116.31,
        'Fiesta',
        true,
        4.1,
        162,
        'https://img.freepik.com/free-photo/brown-leather-shoes_1203-8175.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        77,
        'Sandalias de plataforma blancos',
        'Ideales para caminar, correr o actividades al aire libre.',
        146.56,
        'Sostenibles',
        false,
        4.7,
        290,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-157.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        78,
        'Zapatos casuales marrones',
        'Perfectos para el uso diario o salidas especiales.',
        78.17,
        'Alpargatas',
        true,
        4.4,
        79,
        'https://img.freepik.com/free-photo/brown-leather-shoes_1203-7562.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        79,
        'Alpargatas de lona rojos',
        'Ideales para caminar, correr o actividades al aire libre.',
        63.86,
        'Fiesta',
        true,
        4.9,
        198,
        'https://img.freepik.com/premium-photo/shoes-girls_1056055-579.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        80,
        'Zapatos Oxford rojos',
        'Perfectos para el uso diario o salidas especiales.',
        114.01,
        'Sandalias',
        true,
        5.0,
        268,
        'https://img.freepik.com/premium-photo/shoes-girls_1056055-579.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        81,
        'Mocasines de ante negros',
        'Comodidad y estilo para cualquier ocasión.',
        111.2,
        'Botas',
        true,
        5.0,
        129,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-155.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        82,
        'Sandalias artesanales blancos',
        'Perfectos para el uso diario o salidas especiales.',
        132.34,
        'Botines',
        true,
        3.6,
        152,
        'https://img.freepik.com/free-photo/pair-brown-leather-boots_1150-6005.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        83,
        'Zapatillas de running negros',
        'Ideales para caminar, correr o actividades al aire libre.',
        91.02,
        'Alpargatas',
        true,
        4.3,
        101,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-635.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        84,
        'Zapatillas de running negros',
        'Hechos a mano por artesanos locales.',
        93.88,
        'Tacones',
        true,
        3.8,
        201,
        'https://img.freepik.com/free-photo/leather-shoes-wooden-background_1203-7617.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        85,
        'Mocasines de ante rojos',
        'Disponibles en varios colores y tallas.',
        33.64,
        'Botas',
        true,
        4.2,
        107,
        'https://img.freepik.com/free-vector/hand-drawn-shoe-outline-illustration_23-2150969937.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        86,
        'Sandalias planas verdes',
        'Perfectos para el uso diario o salidas especiales.',
        41.53,
        'Tacones',
        true,
        3.6,
        248,
        'https://img.freepik.com/premium-photo/shoes-girls_1056055-584.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        87,
        'Zapatos casuales dorados',
        'Perfectos para el uso diario o salidas especiales.',
        132.5,
        'Botas',
        true,
        4.9,
        21,
        'https://img.freepik.com/free-photo/brown-leather-shoes_1203-8174.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        88,
        'Zapatillas deportivas dorados',
        'Disponibles en varios colores y tallas.',
        108.23,
        'Sostenibles',
        true,
        4.1,
        71,
        'https://img.freepik.com/free-photo/leather-shoes-wooden-background_1203-7617.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        89,
        'Zapatillas urbanas marrones',
        'Hechos a mano por artesanos locales.',
        82.82,
        'Sandalias',
        true,
        3.9,
        77,
        'https://img.freepik.com/free-photo/shot-elegant-beautiful-leather-heels-isolated-white_181624-32574.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        90,
        'Zapatos Derby beige',
        'Disponibles en varios colores y tallas.',
        137.25,
        'Casuales',
        true,
        4.8,
        256,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-640.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        91,
        'Sandalias planas marrones',
        'Diseño moderno con materiales de alta calidad.',
        41.05,
        'Formales',
        false,
        3.6,
        134,
        'https://img.freepik.com/free-psd/elegant-black-leather-oxfords-pair-polished-classic-mens-shoes_191095-86408.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        92,
        'Zapatos Oxford beige',
        'Fabricados con materiales reciclados y sostenibles.',
        120.22,
        'Fiesta',
        true,
        3.7,
        276,
        'https://img.freepik.com/free-photo/male-foot-with-brown-leather-shoes-jeans_1150-6001.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        93,
        'Zapatos Oxford marrones',
        'Diseño ergonómico para máxima comodidad.',
        146.39,
        'Botines',
        true,
        3.8,
        20,
        'https://img.freepik.com/free-vector/various-shoe-illustrations-set-footwear-sale-business-fashion-industry-clothing-shop-showcase-seasonal-sportive-elegant-apparel-sneakers-gumshoes-sandals-flip-flops-boots_575670-2237.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        94,
        'Alpargatas de lona rojos',
        'Diseño ergonómico para máxima comodidad.',
        106.9,
        'Botines',
        true,
        4.3,
        70,
        'https://img.freepik.com/free-vector/various-shoe-illustrations-set-footwear-sale-business-fashion-industry-clothing-shop-showcase-seasonal-sportive-elegant-apparel-sneakers-gumshoes-sandals-flip-flops-boots_575670-2237.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        95,
        'Zapatos casuales azules',
        'Fabricados con materiales reciclados y sostenibles.',
        38.26,
        'Tacones',
        true,
        4.4,
        192,
        'https://img.freepik.com/free-vector/various-shoe-illustrations-set-footwear-sale-business-fashion-industry-clothing-shop-showcase-seasonal-sportive-elegant-apparel-sneakers-gumshoes-sandals-flip-flops-boots_575670-2237.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        96,
        'Botines Chelsea marrones',
        'Disponibles en varios colores y tallas.',
        125.98,
        'Alpargatas',
        false,
        4.2,
        228,
        'https://img.freepik.com/premium-photo/botas-zapatos-de-cuero-mujer-con-suela-de-goma_167021-180.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        97,
        'Zapatos sin cordones negros',
        'Elegancia clásica con un toque contemporáneo.',
        33.32,
        'Trabajo',
        true,
        4.0,
        258,
        'https://img.freepik.com/premium-photo/shoes-zapatos-calzado-mujer-botas-tacones_1056055-635.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        98,
        'Zapatos de cuero verdes',
        'Fabricados con materiales reciclados y sostenibles.',
        105.29,
        'Alpargatas',
        false,
        4.9,
        177,
        'https://img.freepik.com/premium-photo/shoes-girls_1056055-572.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        99,
        'Zapatos sin cordones negros',
        'Elegancia clásica con un toque contemporáneo.',
        141.1,
        'Infantiles',
        true,
        4.3,
        195,
        'https://img.freepik.com/free-photo/brown-leather-shoes_1203-8174.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );

INSERT INTO
    productos (
        id,
        nombre,
        descripcion,
        precio,
        categoria,
        disponibilidad,
        calificacion,
        numero_resenas,
        url_imagen
    )
VALUES
    (
        100,
        'Botas militares marrones',
        'Diseño moderno con materiales de alta calidad.',
        47.33,
        'Sostenibles',
        false,
        4.0,
        232,
        'https://img.freepik.com/free-vector/hand-drawn-shoe-outline-illustration_23-2150969937.jpg?ga=GA1.1.1863152657.1743402212&semt=ais_hybrid'
    );