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
          <input id="search" placeholder="Ej. Eevee, Magikarp" list="pokemonList">
          <datalist id="pokemonList"></datalist>
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
    const fallbackEvolutions = [
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

    function parseEvolutionChain(chain, list = []) {
      list.push(chain.species.name);
      chain.evolves_to.forEach((next) => parseEvolutionChain(next, list));
      return list;
    }

    async function renderFromApi(term) {
      if (!term) {
        return false;
      }
      try {
        const response = await fetch(`https://pokeapi.co/api/v2/pokemon-species/${term.toLowerCase()}`);
        if (!response.ok) {
          return false;
        }
        const species = await response.json();
        const chainResponse = await fetch(species.evolution_chain.url);
        const chainData = await chainResponse.json();
        const chainList = parseEvolutionChain(chainData.chain);
        list.innerHTML = `
          <div class="list-item">
            <strong>${species.name}</strong><br>
            <span class="badge">Evoluciona a: ${chainList.join(' → ')}</span>
            <p><strong>Requisitos:</strong> Revisa caramelos/items específicos en el juego.</p>
            <p class="highlight">Advertencia: espera eventos con movimientos exclusivos.</p>
          </div>
        `;
        return true;
      } catch (error) {
        console.warn('No se pudo cargar la evolución desde la API.', error);
        return false;
      }
    }

    function renderFallback(term = '') {
      list.innerHTML = '';
      const filtered = fallbackEvolutions.filter((pokemon) => pokemon.name.toLowerCase().includes(term.toLowerCase()));

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

    search.addEventListener('input', async (event) => {
      const term = event.target.value;
      const rendered = await renderFromApi(term);
      if (!rendered) {
        renderFallback(term);
      }
    });

    renderFallback();
    loadPokemonList();
  </script>
</body>
</html>
