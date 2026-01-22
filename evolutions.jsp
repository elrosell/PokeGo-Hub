<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Guía de Evoluciones | PokéGO Hub</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header class="header">
    <h1>🧬 Guía de Evoluciones</h1>
    <p>Busca un Pokémon y revisa su línea evolutiva y requisitos.</p>
  </header>

  <nav class="nav">
    <a href="index.html">Inicio</a>
    <a href="iv-calculator.jsp">Calculadora IV</a>
    <a href="raid-counters.jsp">Counters</a>
    <a href="events.jsp">Eventos</a>
    <a href="stardust-planner.jsp">Stardust</a>
    <a class="active" href="evolutions.jsp">Evoluciones</a>
    <a href="admin.jsp">Admin Panel</a>
  </nav>

  <main class="container">
    <section class="card">
      <h2>Buscador de Pokémon</h2>
      <div class="form">
        <div>
          <label for="search">Nombre del Pokémon</label>
          <input id="search" placeholder="Ej. Eevee, Magikarp">
        </div>
      </div>
    </section>

    <section class="card" style="margin-top: 24px;">
      <h3>Resultados</h3>
      <div id="evolutionList" class="list"></div>
    </section>
  </main>

  <footer class="footer">Desarrollado por Delgado Cerros Rodrigo Daniel · PokéGO Hub</footer>

  <script>
    const evolutions = [
      {
        name: 'Eevee',
        evolvesTo: 'Vaporeon / Jolteon / Flareon / Espeon / Umbreon / Leafeon / Glaceon / Sylveon',
        requirements: '25 caramelos + método de evolución (caminar, señuelo, etc.)',
        warning: 'Espera eventos con movimientos exclusivos.'
      },
      {
        name: 'Magikarp',
        evolvesTo: 'Gyarados',
        requirements: '400 caramelos',
        warning: 'Aprovecha bonus de caramelos o eventos de agua.'
      },
      {
        name: 'Togetic',
        evolvesTo: 'Togekiss',
        requirements: '100 caramelos + Piedra Sinnoh',
        warning: 'Ideal con ataque de hada antes de evolucionar.'
      },
      {
        name: 'Larvitar',
        evolvesTo: 'Pupitar → Tyranitar',
        requirements: '125 caramelos',
        warning: 'Mejor esperar evento con movimiento legado.'
      }
    ];

    const list = document.getElementById('evolutionList');
    const search = document.getElementById('search');

    function renderList(term = '') {
      list.innerHTML = '';
      const filtered = evolutions.filter((pokemon) => pokemon.name.toLowerCase().includes(term.toLowerCase()));

      filtered.forEach((pokemon) => {
        const item = document.createElement('div');
        item.className = 'list-item';
        item.innerHTML = `
          <strong>${pokemon.name}</strong><br>
          <span class="badge">Evoluciona a: ${pokemon.evolvesTo}</span>
          <p><strong>Requisitos:</strong> ${pokemon.requirements}</p>
          <p class="highlight">Advertencia: ${pokemon.warning}</p>
        `;
        list.appendChild(item);
      });

      if (!filtered.length) {
        list.innerHTML = '<p class="notice">No se encontraron coincidencias.</p>';
      }
    }

    search.addEventListener('input', (event) => renderList(event.target.value));
    renderList();
  </script>
</body>
</html>
