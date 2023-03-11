const mysql = require('mysql2');
const env = process.env;
const pool = mysql.createPool({host: 'localhost', user: 'root', database: 'jpingenieria_awlnet2023', password: 'root'});
module.exports = pool;
