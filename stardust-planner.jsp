<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Optimizador Stardust | PokéGO Hub</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header class="header">
    <h1>💸 Optimizador de Stardust</h1>
    <p>Prioriza tu inversión para PvP o PvE con tu stardust disponible.</p>
  </header>

  <nav class="nav">
    <a href="index.html">Inicio</a>
    <a href="iv-calculator.jsp">Calculadora IV</a>
    <a href="raid-counters.jsp">Counters</a>
    <a href="events.jsp">Eventos</a>
    <a class="active" href="stardust-planner.jsp">Stardust</a>
    <a href="evolutions.jsp">Evoluciones</a>
    <a href="admin.jsp">Admin Panel</a>
  </nav>

  <main class="container">
    <section class="card">
      <h2>POST /stardust</h2>
      <form class="form" id="stardustForm">
        <div>
          <label for="dustAvailable">Stardust disponible</label>
          <input id="dustAvailable" type="number" min="0" required>
        </div>
        <div>
          <label for="goal">Objetivo</label>
          <select id="goal">
            <option value="pvp">PvP</option>
            <option value="pve">PvE</option>
          </select>
        </div>
        <div>
          <label for="team">Selecciona Pokémon a considerar</label>
          <select id="team" multiple size="6"></select>
        </div>
        <button class="button primary" type="submit">Generar prioridades</button>
      </form>
    </section>

    <section class="card" style="margin-top: 24px;">
      <h3>Ranking de prioridad</h3>
      <div id="priorityList" class="list"></div>
    </section>
  </main>

  <footer class="footer">Desarrollado por Delgado Cerros Rodrigo Daniel · PokéGO Hub</footer>

  <script>
    const fallbackPool = [
      { name: 'Azumarill', pvp: 95, pve: 40, cost: 75000 },
      { name: 'Dragonite', pvp: 70, pve: 90, cost: 90000 },
      { name: 'Talonflame', pvp: 88, pve: 55, cost: 65000 },
      { name: 'Tyranitar', pvp: 60, pve: 92, cost: 80000 },
      { name: 'Swampert', pvp: 92, pve: 80, cost: 70000 },
      { name: 'Lucario', pvp: 75, pve: 95, cost: 100000 }
    ];

    const teamSelect = document.getElementById('team');
    const form = document.getElementById('stardustForm');
    const list = document.getElementById('priorityList');

    let apiPokemonList = [];

    async function loadPokemonList() {
      try {
        const response = await fetch('https://pokeapi.co/api/v2/pokemon?limit=151');
        const data = await response.json();
        apiPokemonList = data.results.map((pokemon) => pokemon.name);
      } catch (error) {
        console.warn('No se pudo cargar la lista de Pokémon.', error);
        apiPokemonList = fallbackPool.map((pokemon) => pokemon.name);
      }

      teamSelect.innerHTML = '';
      apiPokemonList.forEach((pokemon) => {
        const option = document.createElement('option');
        option.value = pokemon;
        option.textContent = pokemon;
        teamSelect.appendChild(option);
      });
    }

    async function fetchStats(name) {
      try {
        const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${name.toLowerCase()}`);
        if (!response.ok) {
          throw new Error('No encontrado');
        }
        const data = await response.json();
        const stats = {
          ataque: data.stats.find((stat) => stat.stat.name === 'attack')?.base_stat || 0,
          defensa: data.stats.find((stat) => stat.stat.name === 'defense')?.base_stat || 0,
          aguante: data.stats.find((stat) => stat.stat.name === 'hp')?.base_stat || 0
        };
        return stats;
      } catch (error) {
        const fallback = fallbackPool.find((pokemon) => pokemon.name.toLowerCase() === name.toLowerCase());
        if (fallback) {
          return { ataque: fallback.pve, defensa: fallback.pvp, aguante: 60 };
        }
        return null;
      }
    }

    form.addEventListener('submit', async (event) => {
      event.preventDefault();
      const dustAvailable = Number(document.getElementById('dustAvailable').value);
      const goal = document.getElementById('goal').value;
      const selected = Array.from(teamSelect.selectedOptions).map((option) => option.value);

      const statsList = await Promise.all(selected.map((name) => fetchStats(name)));
      const ranked = selected
        .map((name, index) => {
          const stats = statsList[index];
          if (!stats) {
            return null;
          }
          const base = stats.ataque + stats.defensa + stats.aguante;
          const score = goal === 'pvp'
            ? (stats.defensa * 0.4 + stats.aguante * 0.4 + stats.ataque * 0.2)
            : (stats.ataque * 0.5 + stats.defensa * 0.3 + stats.aguante * 0.2);
          const cost = Math.round(base * 120);
          const affordability = dustAvailable >= cost ? 1 : 0.7;
          return { name, score: score * affordability, cost, stats };
        })
        .filter(Boolean)
        .sort((a, b) => b.score - a.score);

      list.innerHTML = '';

      ranked.forEach((pokemon, index) => {
        const item = document.createElement('div');
        item.className = 'list-item';
        item.innerHTML = `
          <strong>#${index + 1} ${pokemon.name}</strong><br>
          Score ${Math.round(pokemon.score)} · Costo ${pokemon.cost} stardust<br>
          <span class="badge">Ataque ${pokemon.stats.ataque} · Defensa ${pokemon.stats.defensa} · Aguante ${pokemon.stats.aguante}</span>
        `;
        list.appendChild(item);
      });

      if (!ranked.length) {
        list.innerHTML = '<p class="notice">Selecciona al menos un Pokémon para generar el ranking.</p>';
      }
    });

    loadPokemonList();
  </script>
</body>
</html>
