const mysql = require('mysql2');
const env = process.env;
const pool = mysql.createPool({host: 'localhost', user: 'root', database: 'jpingenieria_jpnet2023', password: '2045'});
module.exports = pool;
