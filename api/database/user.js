const mysql = require("mysql")
const { config } = require("../config");

db = require("../database/db");

class User {
    constructor(connection) {
        
    }

    findBy = (by, value) => {
        const connection = mysql.createConnection(config.db)
        connection.query('SELECT * FROM users WHERE ${by} = ${value}');
        console.log(results)
        return results
    }

    register = (username, email, password) => {
        this.connection.query("INSERT INTO `users` (`username`, `email`, `password`) VALUES ('${username}', '${email}', '${password};"), function(error, results, fields) {
            if(!error) {
                if (results) {
                    id = results[0]['id']
                    return id
                }
            }
        }
    }

    isUserNameRegistered = (username) => {
        return this.findBy('username', username)
    }
    
    

}

module.exports = User;