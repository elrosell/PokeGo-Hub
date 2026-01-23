<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Incursiones - Pokémon GO Hub</title>
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
            <h2>Incursiones activas</h2>
            <p>Organiza tu equipo y únete a las incursiones disponibles.</p>
        </section>

        <section class="raid-list">
            <article class="raid-card">
                <h3>Rayquaza (Nivel 5)</h3>
                <p>Finaliza: 19:30 hrs</p>
                <p>Gimnasio: Alameda Central</p>
            </article>

            <article class="raid-card">
                <h3>Mega Gardevoir</h3>
                <p>Finaliza: 20:15 hrs</p>
                <p>Gimnasio: Museo Soumaya</p>
            </article>

            <article class="raid-card">
                <h3>Regice (Nivel 3)</h3>
                <p>Finaliza: 18:45 hrs</p>
                <p>Gimnasio: Chapultepec</p>
            </article>
        </section>
    </main>

    <footer>
        <p>Recuerda llevar pases remotos y coordinar con tu grupo local.</p>
    </footer>

    <script src="assets/js/app.js"></script>
</body>
</html>
