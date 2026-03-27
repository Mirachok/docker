const express = require("express");
const path = require("path");
const fs = require("fs");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const multer = require("multer");
const { initPool, getPool } = require("./db");

const app = express();
app.use(express.json());

// статика для фото
const uploadDir = path.join(__dirname, "uploads");
if (!fs.existsSync(uploadDir)) fs.mkdirSync(uploadDir, { recursive: true });
app.use("/uploads", express.static(uploadDir));

// upload фото (admin only)
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => {
    const safe = file.originalname.replace(/[^a-zA-Z0-9._-]/g, "_");
    cb(null, `${Date.now()}-${safe}`);
  },
});
const upload = multer({ storage });

const JWT_SECRET = process.env.JWT_SECRET || "secret";

function signToken(u) {
  return jwt.sign(
    { id: u.id, username: u.username, role: u.role },
    JWT_SECRET,
    { expiresIn: "7d" }
  );
}

function auth(req, res, next) {
  const h = req.headers.authorization || "";
  const token = h.startsWith("Bearer ") ? h.slice(7) : "";
  if (!token) return res.status(401).json({ message: "Нужен вход" });
  try {
    req.user = jwt.verify(token, JWT_SECRET);
    return next();
  } catch {
    return res.status(401).json({ message: "Токен неверный" });
  }
}

function adminOnly(req, res, next) {
  if (req.user?.role !== "admin")
    return res.status(403).json({ message: "Только админ" });
  next();
}

async function ensureAdmin() {
  const pool = getPool();
  const login = process.env.ADMIN_LOGIN || "admin";
  const pass = process.env.ADMIN_PASSWORD || "admin123";

  const [rows] = await pool.query("SELECT id FROM users WHERE username=?", [
    login,
  ]);
  if (rows.length) return;

  const hash = await bcrypt.hash(pass, 10);
  await pool.query(
    "INSERT INTO users (username, password_hash, role) VALUES (?,?, 'admin')",
    [login, hash]
  );
}

// ---------- Public
app.get("/api/info", (req, res) =>
  res.json({ title: process.env.APP_TITLE || "АПТ" })
);

// ---------- Auth
app.post("/api/auth/register", async (req, res) => {
  const { username, password } = req.body || {};
  if (!username || !password)
    return res.status(400).json({ message: "Нужны username и password" });

  const pool = getPool();
  const [u] = await pool.query("SELECT id FROM users WHERE username=?", [
    username,
  ]);
  if (u.length) return res.status(409).json({ message: "Пользователь уже есть" });

  const hash = await bcrypt.hash(password, 10);
  await pool.query(
    "INSERT INTO users (username, password_hash, role) VALUES (?,?, 'user')",
    [username, hash]
  );
  res.json({ message: "OK" });
});

app.post("/api/auth/login", async (req, res) => {
  const { username, password } = req.body || {};
  if (!username || !password)
    return res.status(400).json({ message: "Нужны username и password" });

  const pool = getPool();
  const [rows] = await pool.query("SELECT * FROM users WHERE username=?", [
    username,
  ]);
  if (!rows.length)
    return res.status(401).json({ message: "Неверный логин/пароль" });

  const u = rows[0];
  const ok = await bcrypt.compare(password, u.password_hash);
  if (!ok) return res.status(401).json({ message: "Неверный логин/пароль" });

  res.json({ token: signToken(u), role: u.role, username: u.username });
});

// ---------- Upload (admin only)
app.post("/api/upload", auth, adminOnly, upload.single("file"), (req, res) => {
  res.json({ filename: req.file.filename });
});

// ---------- Students
// список: только 3 поля для таблицы (Фото, ФИО, Группа) + id
app.get("/api/students", auth, async (req, res) => {
  const [rows] = await getPool().query(
    "SELECT id, first_name, last_name, middle_name, group_name, photo FROM students ORDER BY id"
  );
  res.json(rows);
});

// детально: все поля
app.get("/api/students/:id", auth, async (req, res) => {
  const [rows] = await getPool().query("SELECT * FROM students WHERE id=?", [
    req.params.id,
  ]);
  if (!rows.length) return res.status(404).json({ message: "Не найдено" });
  res.json(rows[0]);
});

app.post("/api/students", auth, adminOnly, async (req, res) => {
  const s = req.body || {};
  const sql = `INSERT INTO students
    (first_name,last_name,middle_name,group_name,speciality,email,phone,photo)
    VALUES (?,?,?,?,?,?,?,?)`;
  const params = [
    s.first_name,
    s.last_name,
    s.middle_name,
    s.group_name,
    s.speciality,
    s.email,
    s.phone,
    s.photo || "no-photo.svg",
  ];
  const [r] = await getPool().query(sql, params);
  res.json({ id: r.insertId });
});

app.put("/api/students/:id", auth, adminOnly, async (req, res) => {
  const s = req.body || {};
  const sql = `UPDATE students SET
    first_name=?, last_name=?, middle_name=?, group_name=?, speciality=?, email=?, phone=?, photo=?
    WHERE id=?`;
  const params = [
    s.first_name,
    s.last_name,
    s.middle_name,
    s.group_name,
    s.speciality,
    s.email,
    s.phone,
    s.photo || "no-photo.svg",
    req.params.id,
  ];
  await getPool().query(sql, params);
  res.json({ message: "OK" });
});

app.delete("/api/students/:id", auth, adminOnly, async (req, res) => {
  await getPool().query("DELETE FROM students WHERE id=?", [req.params.id]);
  res.json({ message: "OK" });
});

// ---------- Teachers
// список: Фото, ФИО, Должность (position) + id
app.get("/api/teachers", auth, async (req, res) => {
  const [rows] = await getPool().query(
    "SELECT id, first_name, last_name, middle_name, position, photo FROM teachers ORDER BY id"
  );
  res.json(rows);
});

// детально: все поля
app.get("/api/teachers/:id", auth, async (req, res) => {
  const [rows] = await getPool().query("SELECT * FROM teachers WHERE id=?", [
    req.params.id,
  ]);
  if (!rows.length) return res.status(404).json({ message: "Не найдено" });
  res.json(rows[0]);
});

app.post("/api/teachers", auth, adminOnly, async (req, res) => {
  const t = req.body || {};
  const sql = `INSERT INTO teachers
    (first_name,last_name,middle_name,department,position,email,phone,photo)
    VALUES (?,?,?,?,?,?,?,?)`;
  const params = [
    t.first_name,
    t.last_name,
    t.middle_name,
    t.department,
    t.position,
    t.email,
    t.phone,
    t.photo || "no-photo.svg",
  ];
  const [r] = await getPool().query(sql, params);
  res.json({ id: r.insertId });
});

app.put("/api/teachers/:id", auth, adminOnly, async (req, res) => {
  const t = req.body || {};
  const sql = `UPDATE teachers SET
    first_name=?, last_name=?, middle_name=?, department=?, position=?, email=?, phone=?, photo=?
    WHERE id=?`;
  const params = [
    t.first_name,
    t.last_name,
    t.middle_name,
    t.department,
    t.position,
    t.email,
    t.phone,
    t.photo || "no-photo.svg",
    req.params.id,
  ];
  await getPool().query(sql, params);
  res.json({ message: "OK" });
});

app.delete("/api/teachers/:id", auth, adminOnly, async (req, res) => {
  await getPool().query("DELETE FROM teachers WHERE id=?", [req.params.id]);
  res.json({ message: "OK" });
});

// ---------- Start
initPool()
  .then(async () => {
    await ensureAdmin();
    app.listen(3000, "0.0.0.0", () => console.log("API on 3000"));
  })
  .catch((e) => {
    console.error(e);
    process.exit(1);
  });