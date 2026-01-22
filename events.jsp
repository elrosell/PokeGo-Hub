<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Eventos | PokéGO Hub</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header class="header">
    <h1>📅 Calendario de Eventos</h1>
    <p>Eventos próximos con tips rápidos para aprovecharlos al máximo.</p>
  </header>

  <nav class="nav">
    <a href="index.html">Inicio</a>
    <a href="iv-calculator.jsp">Calculadora IV</a>
    <a href="raid-counters.jsp">Counters</a>
    <a class="active" href="events.jsp">Eventos</a>
    <a href="stardust-planner.jsp">Stardust</a>
    <a href="evolutions.jsp">Evoluciones</a>
    <a href="admin.jsp">Admin Panel</a>
  </nav>

  <main class="container">
    <section class="card">
      <h2>GET /events</h2>
      <div class="form">
        <div>
          <label for="eventFilter">Filtrar por tipo</label>
          <select id="eventFilter">
            <option value="all">Todos</option>
            <option value="Community Day">Community Day</option>
            <option value="Raid">Raid</option>
            <option value="Spotlight">Spotlight</option>
            <option value="Research">Research</option>
          </select>
        </div>
      </div>
    </section>

    <section class="card" style="margin-top: 24px;">
      <h3>Próximos eventos</h3>
      <div id="eventList" class="list"></div>
    </section>
  </main>

  <footer class="footer">Desarrollado por Delgado Cerros Rodrigo Daniel · PokéGO Hub</footer>

  <script>
    const baseEvents = [
      {
        title: 'Community Day: Beldum',
        type: 'Community Day',
        startDate: '2024-08-14',
        endDate: '2024-08-14',
        description: 'Bonus de Polvo Estelar x3 y movimiento especial.',
        tips: 'Guarda caramelos XL y usa Mega Metagross para más candy.'
      },
      {
        title: 'Raid Weekend: Rayquaza',
        type: 'Raid',
        startDate: '2024-08-20',
        endDate: '2024-08-21',
        description: 'Rayquaza regresa con posibilidad de shiny.',
        tips: 'Coordina equipos de hielo y revisa los counters top 5.'
      },
      {
        title: 'Spotlight Hour: Spritzee',
        type: 'Spotlight',
        startDate: '2024-08-25',
        endDate: '2024-08-25',
        description: 'Hora destacada con bonus de doble XP.',
        tips: 'Activa huevo suerte y busca IVs altos para evoluciones.'
      }
    ];

    const storedEvents = JSON.parse(localStorage.getItem('pokegoEvents') || '[]');
    const eventList = document.getElementById('eventList');
    const eventFilter = document.getElementById('eventFilter');

    function renderEvents() {
      const filter = eventFilter.value;
      const events = baseEvents.concat(storedEvents);
      const filtered = filter === 'all' ? events : events.filter((event) => event.type === filter);

      eventList.innerHTML = '';

      filtered.forEach((event) => {
        const item = document.createElement('div');
        item.className = 'list-item';
        item.innerHTML = `
          <div class="badge">${event.type}</div>
          <h4 style="margin-top: 8px;">${event.title}</h4>
          <p><strong>Fecha:</strong> ${event.startDate} - ${event.endDate}</p>
          <p>${event.description}</p>
          <p class="highlight">Tip: ${event.tips}</p>
        `;
        eventList.appendChild(item);
      });

      if (!filtered.length) {
        eventList.innerHTML = '<p class="notice">No hay eventos con ese filtro.</p>';
      }
    }

    eventFilter.addEventListener('change', renderEvents);
    renderEvents();
  </script>
</body>
</html>
