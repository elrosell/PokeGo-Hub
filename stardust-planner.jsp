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
    const pokemonPool = [
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

    pokemonPool.forEach((pokemon) => {
      const option = document.createElement('option');
      option.value = pokemon.name;
      option.textContent = `${pokemon.name} (costo ${pokemon.cost})`;
      teamSelect.appendChild(option);
    });

    form.addEventListener('submit', (event) => {
      event.preventDefault();
      const dustAvailable = Number(document.getElementById('dustAvailable').value);
      const goal = document.getElementById('goal').value;
      const selected = Array.from(teamSelect.selectedOptions).map((option) => option.value);

      const choices = pokemonPool.filter((pokemon) => selected.includes(pokemon.name));
      const ranked = choices
        .map((pokemon) => {
          const score = goal === 'pvp' ? pokemon.pvp : pokemon.pve;
          const affordability = dustAvailable >= pokemon.cost ? 1 : 0.7;
          return { ...pokemon, score: score * affordability };
        })
        .sort((a, b) => b.score - a.score);

      list.innerHTML = '';

      ranked.forEach((pokemon, index) => {
        const item = document.createElement('div');
        item.className = 'list-item';
        item.innerHTML = `
          <strong>#${index + 1} ${pokemon.name}</strong><br>
          Score ${Math.round(pokemon.score)} · Costo ${pokemon.cost} stardust
        `;
        list.appendChild(item);
      });

      if (!ranked.length) {
        list.innerHTML = '<p class="notice">Selecciona al menos un Pokémon para generar el ranking.</p>';
      }
    });
  </script>
</body>
</html>
