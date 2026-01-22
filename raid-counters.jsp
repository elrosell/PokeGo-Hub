<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Raid Counters | PokéGO Hub</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header class="header">
    <h1>⚔️ Counters para Raids</h1>
    <p>Selecciona un jefe y descubre los mejores atacantes disponibles.</p>
  </header>

  <nav class="nav">
    <a href="index.html">Inicio</a>
    <a href="iv-calculator.jsp">Calculadora IV</a>
    <a class="active" href="raid-counters.jsp">Counters</a>
    <a href="events.jsp">Eventos</a>
    <a href="stardust-planner.jsp">Stardust</a>
    <a href="evolutions.jsp">Evoluciones</a>
    <a href="admin.jsp">Admin Panel</a>
  </nav>

  <main class="container">
    <section class="card">
      <h2>GET /counters?bossId=...</h2>
      <p class="notice">Base de datos mínima: pokemon, pokemon_type, raid_boss, counters.</p>
      <div class="form">
        <div>
          <label for="bossSearch">Buscar jefe</label>
          <input id="bossSearch" placeholder="Ej. Dragonite, Rayquaza">
        </div>
        <div>
          <label for="bossSelect">Selecciona Pokémon jefe</label>
          <select id="bossSelect"></select>
        </div>
      </div>
    </section>

    <section class="card" style="margin-top: 24px;">
      <h3>Top 5 Counters</h3>
      <div id="counterList" class="list"></div>
      <h3 style="margin-top: 18px;">Alternativas (sin legendarios)</h3>
      <div id="altList" class="list"></div>
    </section>
  </main>

  <footer class="footer">Desarrollado por Delgado Cerros Rodrigo Daniel · PokéGO Hub</footer>

  <script>
    const defaultCounters = {
      rayquaza: {
        name: 'Rayquaza',
        top: [
          { name: 'Mamoswine', dps: 19.8, note: 'Avalancha + Nieve Polvo' },
          { name: 'Weavile', dps: 18.4, note: 'Canto Helado + Alud' },
          { name: 'Glaceon', dps: 17.9, note: 'Aliento + Avalancha' },
          { name: 'Galarian Darmanitan', dps: 18.1, note: 'Colmillo Hielo + Alud' },
          { name: 'Mamoswine (Sombra)', dps: 22.0, note: 'Opcional con XL' }
        ],
        alternatives: [
          { name: 'Glaceon', note: 'Accesible sin legendarios' },
          { name: 'Mamoswine', note: 'Buen balance de resistencia' },
          { name: 'Weavile', note: 'Alta DPS, baja defensa' }
        ]
      },
      mewtwo: {
        name: 'Mewtwo',
        top: [
          { name: 'Gengar (Sombra)', dps: 20.5, note: 'Bola Sombra' },
          { name: 'Tyranitar', dps: 16.4, note: 'Mordisco + Triturar' },
          { name: 'Darkrai', dps: 18.9, note: 'Pulso Umbrío' },
          { name: 'Chandelure', dps: 17.6, note: 'Infortunio + Bola Sombra' },
          { name: 'Hydreigon', dps: 17.2, note: 'Mordisco + Giro Vil' }
        ],
        alternatives: [
          { name: 'Tyranitar', note: 'No legendario, estable' },
          { name: 'Chandelure', note: 'Disponible en eventos' },
          { name: 'Hydreigon', note: 'Gran DPS sin legendarios' }
        ]
      },
      dragonite: {
        name: 'Dragonite',
        top: [
          { name: 'Togekiss', dps: 16.2, note: 'Encanto + Brillo Mágico' },
          { name: 'Sylveon', dps: 15.9, note: 'Encanto + Fuerza Lunar' },
          { name: 'Mamoswine', dps: 18.1, note: 'Colmillo Hielo + Alud' },
          { name: 'Gardevoir', dps: 15.2, note: 'Encanto + Brillo Mágico' },
          { name: 'Weavile', dps: 17.4, note: 'Canto Helado + Alud' }
        ],
        alternatives: [
          { name: 'Togekiss', note: 'Muy resistente' },
          { name: 'Sylveon', note: 'Fácil de conseguir con amistad' },
          { name: 'Gardevoir', note: 'Gran pick de hada' }
        ]
      }
    };

    const storedCounters = JSON.parse(localStorage.getItem('pokegoCounters') || '[]');

    const bossSelect = document.getElementById('bossSelect');
    const bossSearch = document.getElementById('bossSearch');
    const counterList = document.getElementById('counterList');
    const altList = document.getElementById('altList');

    function buildBossList() {
      const bossOptions = new Map();
      Object.values(defaultCounters).forEach((boss) => bossOptions.set(boss.name, boss.name));
      storedCounters.forEach((entry) => bossOptions.set(entry.bossName, entry.bossName));

      bossSelect.innerHTML = '';
      bossOptions.forEach((value) => {
        const option = document.createElement('option');
        option.value = value;
        option.textContent = value;
        bossSelect.appendChild(option);
      });
    }

    function renderCounters(bossName) {
      counterList.innerHTML = '';
      altList.innerHTML = '';

      const key = bossName?.toLowerCase();
      const defaultData = Object.values(defaultCounters).find((boss) => boss.name.toLowerCase() === key);
      const customData = storedCounters.filter((entry) => entry.bossName.toLowerCase() === key);

      const topCounters = defaultData ? defaultData.top : [];
      const alternatives = defaultData ? defaultData.alternatives : [];

      topCounters.concat(customData.filter((entry) => entry.legendary === false)).slice(0, 5).forEach((counter) => {
        const item = document.createElement('div');
        item.className = 'list-item';
        item.innerHTML = `<strong>${counter.name}</strong> · DPS ${counter.dps || '—'}<br><span class="badge">${counter.note || 'Recomendado'}</span>`;
        counterList.appendChild(item);
      });

      const altPool = alternatives.concat(customData.filter((entry) => entry.legendary === false).map((entry) => ({
        name: entry.name,
        note: entry.note || 'Alternativa sin legendarios'
      })));

      altPool.slice(0, 5).forEach((counter) => {
        const item = document.createElement('div');
        item.className = 'list-item';
        item.innerHTML = `<strong>${counter.name}</strong><br><span class="badge">${counter.note}</span>`;
        altList.appendChild(item);
      });

      if (counterList.children.length === 0) {
        counterList.innerHTML = '<p class="notice">No hay counters cargados para este jefe.</p>';
      }
      if (altList.children.length === 0) {
        altList.innerHTML = '<p class="notice">Sin alternativas por ahora.</p>';
      }
    }

    bossSelect.addEventListener('change', () => renderCounters(bossSelect.value));
    bossSearch.addEventListener('input', (event) => {
      const term = event.target.value.toLowerCase();
      const options = Array.from(bossSelect.options);
      const match = options.find((option) => option.value.toLowerCase().includes(term));
      if (match) {
        bossSelect.value = match.value;
        renderCounters(match.value);
      }
    });

    buildBossList();
    renderCounters(bossSelect.value);
  </script>
</body>
</html>
