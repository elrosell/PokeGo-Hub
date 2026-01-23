<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contacto - Pokémon GO Hub</title>
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
            <h2>Contacto y soporte</h2>
            <p>¿Necesitas ayuda? Escríbenos y nuestro equipo responderá pronto.</p>
        </section>

        <section class="contact-form">
            <form action="/contacto" method="post">
                <label for="correo">Correo</label>
                <input type="email" id="correo" name="correo" placeholder="tu@correo.com" required>

                <label for="asunto">Asunto</label>
                <input type="text" id="asunto" name="asunto" placeholder="Tema" required>

                <label for="detalle">Detalle</label>
                <textarea id="detalle" name="detalle" rows="4" placeholder="Describe tu solicitud" required></textarea>

                <button type="submit">Enviar</button>
            </form>
        </section>
    </main>

    <footer>
        <p>Soporte disponible de lunes a domingo, 09:00 a 21:00.</p>
    </footer>

    <script src="assets/js/app.js"></script>
</body>
</html>
