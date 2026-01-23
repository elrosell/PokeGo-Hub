document.addEventListener('DOMContentLoaded', () => {
    console.log('Pokémon GO Hub listo.');

    const timestamp = new Date().toLocaleTimeString('es-MX', {
        hour: '2-digit',
        minute: '2-digit',
    });

    const eventLists = document.querySelectorAll('.event-list');
    eventLists.forEach((list) => {
        const update = document.createElement('li');
        update.textContent = `Actualización automática simulada (${timestamp}).`;
        list.appendChild(update);
    });
});
