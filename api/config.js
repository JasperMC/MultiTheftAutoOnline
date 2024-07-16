const config = {
    db: {
      /* don't expose password or any sensitive info, done only for demo */
      host: "localhost",
      user: "root",
      password: "star500",
      database: "mta",
      connectTimeout: 60000
    },
    listPerPage: 10,
    jwt_secret: "da1865f5c8f3abffd57750a2ed208bfb5c6dc12f10f5434353e023aa36770ab0"
  };
  module.exports = config;