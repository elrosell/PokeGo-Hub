<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Calculadora de IVs | PokéGO Hub</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header class="header">
    <h1>🧮 Calculadora de IVs</h1>
    <p>Calcula un score rápido y recibe recomendaciones PvP/PvE.</p>
  </header>

  <nav class="nav">
    <a href="index.html">Inicio</a>
    <a class="active" href="iv-calculator.jsp">Calculadora IV</a>
    <a href="raid-counters.jsp">Counters</a>
    <a href="events.jsp">Eventos</a>
    <a href="stardust-planner.jsp">Stardust</a>
    <a href="evolutions.jsp">Evoluciones</a>
    <a href="admin.jsp">Admin Panel</a>
  </nav>

  <main class="container">
    <section class="card">
      <h2>Formulario de IV (POST /iv)</h2>
      <p class="notice">MVP modo A: score heurístico basado en CP/PS/stardust.</p>
      <form class="form" id="ivForm">
        <div>
          <label for="pokemon">Pokémon</label>
          <input id="pokemon" name="pokemon" placeholder="Ej. Azumarill" list="pokemonList" required>
          <datalist id="pokemonList"></datalist>
        </div>
        <div>
          <label for="cp">PC (CP)</label>
          <input id="cp" name="cp" type="number" min="10" required>
        </div>
        <div>
          <label for="hp">PS (HP)</label>
          <input id="hp" name="hp" type="number" min="10" required>
        </div>
        <div>
          <label for="stardust">Stardust requerido para subir</label>
          <input id="stardust" name="stardust" type="number" min="0" required>
        </div>
        <div>
          <label for="level">Nivel (opcional)</label>
          <input id="level" name="level" type="number" min="1" max="50" placeholder="Ej. 23">
        </div>
        <button class="button primary" type="submit">Calcular IV</button>
      </form>

      <div class="results" id="ivResult" hidden>
        <h4>Resultado</h4>
        <p><strong>Pokémon:</strong> <span id="resultPokemon"></span></p>
        <p><strong>% IV:</strong> <span id="resultIv"></span></p>
        <p><strong>Recomendación:</strong> <span id="resultRecommendation"></span></p>
        <p id="resultMessage"></p>
        <div class="stat-grid" id="statGrid"></div>
      </div>

      <div class="alert">
        Nota: el cálculo exacto de IV requiere tablas y datos adicionales. Este MVP entrega
        una estimación útil y rápida para tomar decisiones inmediatas.
      </div>
    </section>
  </main>

  <footer class="footer">Desarrollado por Delgado Cerros Rodrigo Daniel · PokéGO Hub</footer>

  <script>
    const form = document.getElementById('ivForm');
    const resultBox = document.getElementById('ivResult');
    const statGrid = document.getElementById('statGrid');
    const pokemonList = document.getElementById('pokemonList');

    async function loadPokemonList() {
      try {
        const response = await fetch('https://pokeapi.co/api/v2/pokemon?limit=151');
        const data = await response.json();
        data.results.forEach((pokemon) => {
          const option = document.createElement('option');
          option.value = pokemon.name;
          pokemonList.appendChild(option);
        });
      } catch (error) {
        console.warn('No se pudo cargar la lista de Pokémon.', error);
      }
    }

    function renderStats(stats) {
      statGrid.innerHTML = '';
      if (!stats) {
        return;
      }
      Object.entries(stats).forEach(([label, value]) => {
        const card = document.createElement('div');
        card.className = 'stat-card';
        card.innerHTML = `<strong>${value}</strong><span>${label}</span>`;
        statGrid.appendChild(card);
      });
    }

    form.addEventListener('submit', async (event) => {
      event.preventDefault();

      const pokemon = document.getElementById('pokemon').value.trim();
      const cp = Number(document.getElementById('cp').value);
      const hp = Number(document.getElementById('hp').value);
      const stardust = Number(document.getElementById('stardust').value);
      const level = Number(document.getElementById('level').value);

      let apiStats = null;
      try {
        const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${pokemon.toLowerCase()}`);
        if (response.ok) {
          const data = await response.json();
          apiStats = {
            Ataque: data.stats.find((stat) => stat.stat.name === 'attack')?.base_stat || 0,
            Defensa: data.stats.find((stat) => stat.stat.name === 'defense')?.base_stat || 0,
            Aguante: data.stats.find((stat) => stat.stat.name === 'hp')?.base_stat || 0
          };
        }
      } catch (error) {
        console.warn('No se pudo cargar stats desde la API.', error);
      }

      const statsBonus = apiStats
        ? (apiStats.Ataque * 0.3 + apiStats.Defensa * 0.2 + apiStats.Aguante * 0.2)
        : 0;
      const baseScore = ((cp * 1.15) + (hp * 2.2) + statsBonus) / Math.max(stardust, 10) * 120;
      const levelBonus = level ? Math.min(level, 50) * 0.4 : 0;
      const rawScore = Math.min(100, Math.max(10, baseScore + levelBonus));

      const variance = level ? 0 : 8;
      const minScore = Math.max(10, Math.round(rawScore - variance));
      const maxScore = Math.min(100, Math.round(rawScore + variance));

      let recommendation = 'No conviene';
      let message = '❌ Mejor esperar otro ejemplar o evento con boost.';

      if (rawScore >= 82) {
        recommendation = 'PvP competitivo';
        message = '✅ Excelente para Liga Super o Ultra si el CP es adecuado.';
      } else if (rawScore >= 70) {
        recommendation = 'PvE sólido';
        message = '✅ Buena opción para raids y gimnasios.';
      } else if (rawScore >= 55) {
        recommendation = 'Situacional';
        message = '⚠️ Úsalo si necesitas el tipo hoy, pero no inviertas de más.';
      }

      document.getElementById('resultPokemon').textContent = pokemon || 'Desconocido';
      document.getElementById('resultIv').textContent = variance
        ? `${minScore}% - ${maxScore}% (estimado)`
        : `${Math.round(rawScore)}%`;
      document.getElementById('resultRecommendation').textContent = recommendation;
      document.getElementById('resultMessage').textContent = message;
      renderStats(apiStats);

      resultBox.hidden = false;
    });

    loadPokemonList();
  </script>
</body>
</html>
