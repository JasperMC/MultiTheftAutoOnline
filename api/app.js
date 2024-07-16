const express = require('express');
const app = express();
const bodyParser = require("body-parser");
const port = 3000;
//const router = app.Router;
const mysql = require('mysql');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const statusRoute = require('./routes/status');
const userRoute = require('./routes/user');
const characterRoute = require('./routes/character')
app.use(bodyParser.json())
app.use('/status, ', statusRoute);
app.use('/user', userRoute);
app.use('/character', characterRoute)

// Status
app.get("/", (req, res) => {
    res.status(200).json({"status": "online"})
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
