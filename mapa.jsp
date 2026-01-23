<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mapa interactivo - Pokémon GO Hub</title>
    <link rel="stylesheet" href="assets/css/styles.css">
    <link
        rel="stylesheet"
        href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
        integrity="sha256-o9N1j7k2k3Q2hKp9u7E1o2RzQp0JdLMhHf5xZ7ro7AQ="
        crossorigin=""
    >
</head>
<body>
    <header class="site-header">
        <h1>Pokémon GO Hub</h1>
        <nav class="site-nav">
            <ul>
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="mapa.jsp">Mapa</a></li>
                <li><a href="incursiones.jsp">Incursiones</a></li>
                <li><a href="foro.jsp">Foro</a></li>
                <li><a href="contacto.jsp">Contacto</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section>
            <h2>Mapa interactivo</h2>
            <p>Explora Pokémon cercanos, gimnasios y PokéStops simulados en tu zona.</p>
        </section>

        <section class="map-section">
            <div id="map" class="map-container"></div>
        </section>

        <section>
            <h2>Puntos de interés</h2>
            <ul class="poi-list">
                <li>Gimnasio Alameda Central</li>
                <li>PokéStop Monumento a la Revolución</li>
                <li>Zona de spawn Parque México</li>
            </ul>
        </section>
    </main>

    <footer>
        <p>Consulta las rutas recomendadas por la comunidad.</p>
    </footer>

    <script
        src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
        integrity="sha256-o8UIt0d7xy0JrG3Z1u2n3n8g4n2J6kzT2aY1kP4ZJ3g="
        crossorigin=""
    ></script>
    <script src="assets/js/mapa.js"></script>
    <script src="assets/js/app.js"></script>
</body>
</html>
