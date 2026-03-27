const mysql = require("mysql2/promise");

let pool;

async function initPool() {
  pool = mysql.createPool({
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT || 3306),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    charset: "utf8mb4",
    waitForConnections: true,
    connectionLimit: 10
  });

  // ждём готовность MySQL
  for (let i = 0; i < 30; i++) {
    try { await pool.query("SELECT 1"); return; }
    catch { await new Promise(r => setTimeout(r, 1000)); }
  }
  throw new Error("MySQL not ready");
}

function getPool() {
  if (!pool) throw new Error("DB not initialized");
  return pool;
}

module.exports = { initPool, getPool };