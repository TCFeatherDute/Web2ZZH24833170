# Charity Events Website

## Project Structure

api/
clientside/
charityevents_db.sql

## Database Setup

1. Import charityevents_db.sql into MySQL.
2. Create api/.env based on api/.env.example.
3. Enter your local MySQL username and password.

## API Setup

cd api
npm install
node app.js

API runs on:
http://localhost:3000

## Client Setup

cd clientside
python -m http.server 5500

Client runs on:
http://localhost:5500

## Main Pages

Home:
http://localhost:5500/index.html

Search:
http://localhost:5500/search.html

Event Details:
http://localhost:5500/event.html?id=1