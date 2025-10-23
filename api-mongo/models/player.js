const mongoose = require('mongoose');

const PlayerSchema = mongoose.Schema( 

    {
        username: {
            type: String,
            required: true
        },

        password: {
            type: String,
            required: true
        },

        email: {
            type: String,
            required: true
        },

        model: {
            type: Number,
            required: false,
            default: 0
        },

        cash: {
            type: Number,
            required: false,
            default: 0
        }
    }

);


const Player = mongoose.model("player", PlayerSchema)

module.exports = Player;