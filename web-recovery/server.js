// Servidor Express para servir la página de recuperación de contraseña
const express = require("express");
const path = require("path");
const app = express();

const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.static(path.join(__dirname)));

// Rutas
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "reset-password.html"));
});

app.get("/reset-password.html", (req, res) => {
  res.sendFile(path.join(__dirname, "reset-password.html"));
});

// Health check (para Railway)
app.get("/health", (req, res) => {
  res.status(200).json({ status: "ok", timestamp: new Date().toISOString() });
});

// 404
app.use((req, res) => {
  res.status(404).sendFile(path.join(__dirname, "reset-password.html"));
});

// Iniciar servidor
app.listen(PORT, "0.0.0.0", () => {
  console.log(
    `✅ Servidor de recuperación de contraseña corriendo en puerto ${PORT}`
  );
  console.log(`📍 Acceso: http://localhost:${PORT}`);
  console.log(
    `🔐 Reset Password: http://localhost:${PORT}/reset-password.html`
  );
});
