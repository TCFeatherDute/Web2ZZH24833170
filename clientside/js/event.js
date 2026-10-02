const params = new URLSearchParams(window.location.search);
const eventId = params.get('id');

const detailsContainer = document.getElementById('event-details');
const messageContainer = document.getElementById('message');

if (!eventId) {
    messageContainer.textContent = 'No event selected.';
}

if (eventId) {
    fetch(`http://localhost:3000/api/events/${eventId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Event not found');
            }
            return response.json();
        })
        .then(event => {
            detailsContainer.innerHTML = `
                <h3>${event.name}</h3>
                <p><strong>Charity:</strong> ${event.charity_name}</p>
                <p><strong>Category:</strong> ${event.category_name}</p>
                <p><strong>Date:</strong> ${event.event_date}</p>
                <p><strong>Location:</strong> ${event.location}</p>
                <p><strong>Purpose:</strong> ${event.purpose}</p>
                <p><strong>Description:</strong> ${event.description}</p>
                <p><strong>Ticket Price:</strong> ${
                    Number(event.ticket_price) === 0
                        ? 'Free'
                        : '$' + event.ticket_price
                }</p>
                <p><strong>Fundraising Goal:</strong> $${event.goal_amount}</p>
                <p><strong>Amount Raised:</strong> $${event.current_amount}</p>
                <button id="register-button">Register</button>
            `;

            const registerButton = document.getElementById('register-button');
            registerButton.addEventListener('click', () => {
                alert('This feature is currently under construction.');
            });
        })
        .catch(error => {
            console.error('Failed to load event:', error);
            messageContainer.textContent = 'Unable to load event details.';
        });
}
