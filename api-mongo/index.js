

const express = require('express');
const app = express();
app.use(express.json())
const mongoose = require('mongoose');


const playerRoute = require("./routes/player");
app.use( "/player", playerRoute);

mongoose.connect('mongodb://localhost:27017/mta')
    .then( () => console.log('Connected!'));

app.listen( 9191, () => {
    console.log("Test")
});