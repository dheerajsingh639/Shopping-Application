const express = require("express");
const bodyParser = require("body-parser");
const path = require("path");
const Db = require("./Db");
const Router = require("./router");
const PORT = 3000;
const app = express();

// Initialize database and user schema
Db();

app.use('/uploads', express.static('uploads'));

// Set up view engine and views directory
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Serve static files from the "public" directory
app.use(express.static(path.join(__dirname, 'public')));

// Middleware
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

// Use the router for all routes
app.use('/', Router);


// Server Initialization
app.listen(PORT, () => {
  console.log(`Server running on --> http://localhost:${PORT}/home`);
});
