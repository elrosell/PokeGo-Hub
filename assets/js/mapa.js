const map = L.map('map').setView([19.4326, -99.1332], 13);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors',
}).addTo(map);

function agregarMarcador(lat, lon, pokemon) {
    L.marker([lat, lon])
        .addTo(map)
        .bindPopup(`<b>${pokemon.name}</b><br>${pokemon.description || ''}`);
}

agregarMarcador(19.4326, -99.1332, {
    name: 'Pikachu',
    description: 'Aparición frecuente en zonas urbanas.',
});

agregarMarcador(19.437, -99.143, {
    name: 'Bulbasaur',
    description: 'Cerca de parques y áreas verdes.',
});

agregarMarcador(19.427, -99.126, {
    name: 'Charmander',
    description: 'Activos cerca de gimnasios.',
});
