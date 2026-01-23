<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pokémon GO Hub</title>
    <link rel="stylesheet" href="assets/css/styles.css">
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
        <section class="hero">
            <h2>Bienvenido a tu centro de entrenadores</h2>
            <p>
                Pokémon GO Hub reúne eventos, comunidades y mapas interactivos para que planifiques
                tus aventuras y nunca pierdas una incursión importante.
            </p>
        </section>

        <section class="events">
            <h2>Eventos actuales</h2>
            <ul class="event-list">
                <li>Semana de aventura: bonus de caramelos y eclosiones rápidas.</li>
                <li>Hora destacada: aparición masiva de Eevee (martes 18:00).</li>
                <li>Incursiones de nivel 5: Rayquaza hasta el domingo.</li>
            </ul>
        </section>

        <section class="news">
            <h2>Noticias</h2>
            <p>
                Revisa las novedades semanales, actualizaciones de la comunidad y consejos para
                optimizar tu progreso.
            </p>
        </section>
    </main>

    <footer>
        <p>© 2024 Pokémon GO Hub. Comunidad de entrenadores.</p>
    </footer>

    <script src="assets/js/app.js"></script>
</body>
</html>
