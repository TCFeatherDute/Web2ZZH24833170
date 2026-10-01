const express = require('express');
const cors = require('cors');
const db = require('./event_db');

const app = express();

app.use(cors());
app.use(express.json());

app.get('/api/events', (req, res) => {

    const { date, location, category } = req.query;

    let sql = `
    SELECT
        event.event_id,
        event.name,
        event.description,
        DATE_FORMAT(event.event_date, '%Y-%m-%d') AS event_date,
        event.location,
        event.purpose,
        event.ticket_price,
        event.goal_amount,
        event.current_amount,
        event.status,
        event.image,
        charity.name AS charity_name,
        category.name AS category_name
    FROM event
    JOIN charity
        ON event.charity_id = charity.charity_id
    JOIN category
        ON event.category_id = category.category_id
`;

    const conditions = [];
    const values = [];

    if (location) {
        conditions.push('event.location = ?');
        values.push(location);
    }

    if (date) {
        conditions.push('event.event_date = ?');
        values.push(date);
    }

    if (category) {
        conditions.push('event.category_id = ?');
        values.push(category);
    }

    if (conditions.length > 0) {
        sql += ' WHERE ' + conditions.join(' AND ');
    }

    sql += ' ORDER BY event.event_id ASC';

    db.query(sql, values, (err, results) => {

        if (err) {
            console.error(err);

            res.status(500).json({
                error: 'Failed to retrieve events'
            });

            return;
        }

        res.json(results);
    });
});

app.get('/api/categories', (req, res) => {

    const sql = 'SELECT * FROM category ORDER BY category_id ASC';

    db.query(sql, (err, results) => {

        if (err) {
            console.error(err);

            res.status(500).json({
                error: 'Failed to retrieve categories'
            });

            return;
        }

        res.json(results);
    });
});

app.get('/api/events/:id', (req, res) => {

    const eventId = req.params.id;

    const sql = `
        SELECT
            event.event_id,
            event.name,
            event.description,
            DATE_FORMAT(event.event_date, '%Y-%m-%d') AS event_date,
            event.location,
            event.purpose,
            event.ticket_price,
            event.goal_amount,
            event.current_amount,
            event.status,
            event.image,
            charity.name AS charity_name,
            category.name AS category_name
        FROM event
        JOIN charity
            ON event.charity_id = charity.charity_id
        JOIN category
            ON event.category_id = category.category_id
        WHERE event.event_id = ?
    `;

    db.query(sql, [eventId], (err, results) => {

        if (err) {
            console.error(err);

            res.status(500).json({
                error: 'Failed to retrieve event'
            });

            return;
        }

        if (results.length === 0) {
            res.status(404).json({
                error: 'Event not found'
            });

            return;
        }

        res.json(results[0]);
    });
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});