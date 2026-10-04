fetch('http://localhost:3000/api/events')
    .then(response => response.json())
    .then(events => {

        const eventList = document.getElementById('event-list');

        events.forEach(event => {

            if (event.status === 'suspended') {
                return;
            }

            const today = new Date();
            const eventDate = new Date(event.event_date);

            let eventStatus;

            if (eventDate < today) {
                eventStatus = 'Ended';
            } else {
                eventStatus = 'Upcoming';
            }

            const eventCard = document.createElement('div');

            eventCard.innerHTML = `
                <h3>${event.name}</h3>
                <p><strong>Category:</strong> ${event.category_name}</p>
                <p><strong>Date:</strong> ${event.event_date}</p>
                <p><strong>Location:</strong> ${event.location}</p>
                <p><strong>Status:</strong> ${eventStatus}</p>

                <a href="event.html?id=${event.event_id}">
                    View Details
                </a>
            `;

            eventList.appendChild(eventCard);
        });

    })
    .catch(error => {
        console.error('Failed to load events:', error);

        const eventList = document.getElementById('event-list');

        eventList.textContent = 'Unable to load events.';
    });