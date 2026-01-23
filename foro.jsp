<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foro - Pokémon GO Hub</title>
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
        <section>
            <h2>Foro de la comunidad</h2>
            <p>Comparte consejos, coordina incursiones y conoce a más entrenadores.</p>
        </section>

        <section class="forum-form">
            <h3>Nuevo mensaje</h3>
            <form action="/foro" method="post">
                <label for="nombre">Nombre</label>
                <input type="text" id="nombre" name="nombre" placeholder="Tu nombre" required>

                <label for="mensaje">Mensaje</label>
                <textarea id="mensaje" name="mensaje" rows="4" placeholder="Escribe tu mensaje" required></textarea>

                <button type="submit">Publicar</button>
            </form>
        </section>

        <section class="forum-posts">
            <h3>Publicaciones recientes</h3>
            <article class="post">
                <h4>TrainerLuna</h4>
                <p>¿Alguien se une a la incursión en Plaza Satélite a las 19:00?</p>
            </article>
            <article class="post">
                <h4>PokeMasterMX</h4>
                <p>Consejo: usa tipo hielo contra Rayquaza, es súper efectivo.</p>
            </article>
        </section>
    </main>

    <footer>
        <p>Los mensajes se gestionan con Servlets y se actualizan en tiempo real.</p>
    </footer>

    <script src="assets/js/app.js"></script>
</body>
</html>
