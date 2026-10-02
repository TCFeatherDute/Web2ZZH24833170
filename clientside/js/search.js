const categorySelect = document.getElementById('category');
const searchForm = document.getElementById('search-form');
const clearButton = document.getElementById('clear-filters');
const resultsContainer = document.getElementById('search-results');
const messageContainer = document.getElementById('message');

fetch('http://localhost:3000/api/categories')
    .then(response => response.json())
    .then(categories => {

        categories.forEach(category => {

            const option = document.createElement('option');

            option.value = category.category_id;
            option.textContent = category.name;

            categorySelect.appendChild(option);
        });

    })
    .catch(error => {

        console.error('Failed to load categories:', error);

        messageContainer.textContent = 'Unable to load event categories.';
    });

searchForm.addEventListener('submit', (event) => {

    event.preventDefault();

    const date = document.getElementById('date').value;
    const location = document.getElementById('location').value;
    const category = document.getElementById('category').value;

    const params = new URLSearchParams();

    if (date) {
        params.append('date', date);
    }

    if (location) {
        params.append('location', location);
    }

    if (category) {
        params.append('category', category);
    }

    const url = `http://localhost:3000/api/events?${params.toString()}`;

    fetch(url)
        .then(response => response.json())
        .then(events => {

            resultsContainer.innerHTML = '';
            messageContainer.textContent = '';

            if (events.length === 0) {
                messageContainer.textContent = 'No events found.';
                return;
            }

            events.forEach(event => {

                const eventCard = document.createElement('div');

                eventCard.innerHTML = `
                    <h3>${event.name}</h3>
                    <p><strong>Category:</strong> ${event.category_name}</p>
                    <p><strong>Date:</strong> ${event.event_date}</p>
                    <p><strong>Location:</strong> ${event.location}</p>

                    <a href="event.html?id=${event.event_id}">
                        View Details
                    </a>
                `;

                resultsContainer.appendChild(eventCard);
            });

        })
        .catch(error => {

            console.error('Search failed:', error);

            messageContainer.textContent = 'Unable to search events.';
        });
});


clearButton.addEventListener('click', () => {

    searchForm.reset();

    resultsContainer.innerHTML = '';
    messageContainer.textContent = '';
});