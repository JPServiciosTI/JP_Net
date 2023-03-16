const mysql = require("mysql2");
const pool2 = mysql.createPool({
  host: "localhost",
  user: "root",
  database: "jpingenieria_consolidadodeplanillajpnet",
  password: "2045",
});
module.exports = pool2;
