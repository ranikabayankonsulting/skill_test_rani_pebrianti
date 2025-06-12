import mysql from 'mysql2/promise';

export const db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '', // sesuaikan
  database: 'testdb', // sesuaikan
  waitForConnections: true,
  connectionLimit: 10,
});