<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Panel | PokéGO Hub</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header class="header">
    <h1>🛠️ Admin Panel</h1>
    <p>Carga eventos y counters para simular el flujo completo.</p>
  </header>

  <nav class="nav">
    <a href="index.html">Inicio</a>
    <a href="iv-calculator.jsp">Calculadora IV</a>
    <a href="raid-counters.jsp">Counters</a>
    <a href="events.jsp">Eventos</a>
    <a href="stardust-planner.jsp">Stardust</a>
    <a href="evolutions.jsp">Evoluciones</a>
    <a class="active" href="admin.jsp">Admin Panel</a>
  </nav>

  <main class="container">
    <section class="card">
      <h2>Eventos</h2>
      <form class="form" id="eventForm">
        <div>
          <label for="eventTitle">Título</label>
          <input id="eventTitle" required>
        </div>
        <div>
          <label for="eventType">Tipo</label>
          <select id="eventType">
            <option>Community Day</option>
            <option>Raid</option>
            <option>Spotlight</option>
            <option>Research</option>
          </select>
        </div>
        <div>
          <label for="eventStart">Fecha inicio</label>
          <input id="eventStart" type="date" required>
        </div>
        <div>
          <label for="eventEnd">Fecha fin</label>
          <input id="eventEnd" type="date" required>
        </div>
        <div>
          <label for="eventDescription">Descripción</label>
          <textarea id="eventDescription" required></textarea>
        </div>
        <div>
          <label for="eventTips">Tips</label>
          <textarea id="eventTips" required></textarea>
        </div>
        <button class="button primary" type="submit">Guardar evento</button>
      </form>
    </section>

    <section class="card" style="margin-top: 24px;">
      <h2>Counters</h2>
      <form class="form" id="counterForm">
        <div>
          <label for="bossName">Pokémon jefe</label>
          <input id="bossName" required>
        </div>
        <div>
          <label for="counterName">Counter recomendado</label>
          <input id="counterName" required>
        </div>
        <div>
          <label for="counterDps">Daño/DPS</label>
          <input id="counterDps" type="number" step="0.1" required>
        </div>
        <div>
          <label for="counterNote">Recomendación</label>
          <input id="counterNote" placeholder="Ej. Ataque rápido + cargado" required>
        </div>
        <div>
          <label>
            <input id="counterLegendary" type="checkbox">
            Es legendario
          </label>
        </div>
        <button class="button secondary" type="submit">Guardar counter</button>
      </form>
    </section>

    <section class="card" style="margin-top: 24px;">
      <h3>Resumen local</h3>
      <div id="adminSummary" class="list"></div>
      <button class="button" id="clearStorage">Limpiar almacenamiento local</button>
    </section>
  </main>

  <footer class="footer">Desarrollado por Delgado Cerros Rodrigo Daniel · PokéGO Hub</footer>

  <script>
    const eventForm = document.getElementById('eventForm');
    const counterForm = document.getElementById('counterForm');
    const summary = document.getElementById('adminSummary');
    const clearButton = document.getElementById('clearStorage');

    function loadStorage(key) {
      return JSON.parse(localStorage.getItem(key) || '[]');
    }

    function saveStorage(key, data) {
      localStorage.setItem(key, JSON.stringify(data));
    }

    function renderSummary() {
      summary.innerHTML = '';
      const events = loadStorage('pokegoEvents');
      const counters = loadStorage('pokegoCounters');

      const eventItem = document.createElement('div');
      eventItem.className = 'list-item';
      eventItem.innerHTML = `<strong>Eventos guardados:</strong> ${events.length}`;
      summary.appendChild(eventItem);

      const counterItem = document.createElement('div');
      counterItem.className = 'list-item';
      counterItem.innerHTML = `<strong>Counters guardados:</strong> ${counters.length}`;
      summary.appendChild(counterItem);
    }

    eventForm.addEventListener('submit', (event) => {
      event.preventDefault();
      const events = loadStorage('pokegoEvents');
      events.push({
        title: document.getElementById('eventTitle').value,
        type: document.getElementById('eventType').value,
        startDate: document.getElementById('eventStart').value,
        endDate: document.getElementById('eventEnd').value,
        description: document.getElementById('eventDescription').value,
        tips: document.getElementById('eventTips').value
      });
      saveStorage('pokegoEvents', events);
      eventForm.reset();
      renderSummary();
    });

    counterForm.addEventListener('submit', (event) => {
      event.preventDefault();
      const counters = loadStorage('pokegoCounters');
      counters.push({
        bossName: document.getElementById('bossName').value,
        name: document.getElementById('counterName').value,
        dps: document.getElementById('counterDps').value,
        note: document.getElementById('counterNote').value,
        legendary: document.getElementById('counterLegendary').checked
      });
      saveStorage('pokegoCounters', counters);
      counterForm.reset();
      renderSummary();
    });

    clearButton.addEventListener('click', () => {
      localStorage.removeItem('pokegoEvents');
      localStorage.removeItem('pokegoCounters');
      renderSummary();
    });

    renderSummary();
  </script>
</body>
</html>
