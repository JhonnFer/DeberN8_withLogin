# 🚀 Integración con Railway para Autenticación Avanzada

## ¿Por qué Railway?

Railway es una plataforma de hosting que permite:

- ✅ Hosting backend sin complicaciones
- ✅ Variables de entorno seguras
- ✅ Base de datos PostgreSQL integrada
- ✅ Servir un servicio de autenticación personalizado
- ✅ Restablecimiento de contraseña con email custom

---

## OPCIÓN 1: Usar Supabase (RECOMENDADO - MÁS FÁCIL) ⭐

La app ya está configurada con **Supabase que maneja todo automáticamente**:

### ✅ Lo que Supabase HACE POR TI:

- Autenticación con email/contraseña
- Restablecimiento de contraseña (envía email automático)
- Gestión de usuarios
- Base de datos PostgreSQL
- RLS (Row Level Security)
- JWT tokens

### ⏱️ Tiempo de setup: 10 minutos

**No necesitas Railway si usas Supabase completo.**

---

## OPCIÓN 2: Combinar Supabase + Railway (MÁS CONTROL)

Si quieres un backend personalizado en Railway para restablecimiento de contraseña custom:

### A. Crear un backend Node.js en Railway

1. **Ir a [railway.app](https://railway.app)**
2. **Sign up** (con GitHub es más fácil)
3. **New Project** → **Deploy from GitHub** → Selecciona un repo o crea uno nuevo

### B. Crear el código del backend

En tu máquina local:

```bash
mkdir app-pedidos-backend
cd app-pedidos-backend
npm init -y
npm install express cors dotenv nodemailer axios
```

**Crear `server.js`:**

```javascript
const express = require("express");
const cors = require("cors");
const nodemailer = require("nodemailer");
require("dotenv").config();

const app = express();
app.use(cors());
app.use(express.json());

// Configurar Nodemailer con tu email
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASSWORD, // App password de Google
  },
});

// Endpoint para enviar email de reseteo
app.post("/api/reset-password", async (req, res) => {
  const { email, resetToken } = req.body;

  try {
    const resetLink = `${process.env.APP_URL}/reset?token=${resetToken}`;

    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: email,
      subject: "Restablecer tu contraseña - App Pedidos",
      html: `
        <h2>Restablecer Contraseña</h2>
        <p>Haz clic en el siguiente enlace para restablecer tu contraseña:</p>
        <a href="${resetLink}">Restablecer Contraseña</a>
        <p>Este enlace expira en 1 hora.</p>
      `,
    });

    res.json({ success: true, message: "Email enviado" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

// Health check
app.get("/health", (req, res) => {
  res.json({ status: "OK" });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor en puerto ${PORT}`));
```

**Crear `.env`:**

```
EMAIL_USER=tu_email@gmail.com
EMAIL_PASSWORD=tu_app_password_google
APP_URL=https://tudominio.com
SUPABASE_URL=https://tu_proyecto.supabase.co
SUPABASE_KEY=tu_anon_key
```

**Crear `package.json`:**

```json
{
  "name": "app-pedidos-backend",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "dotenv": "^16.0.3",
    "nodemailer": "^6.9.1",
    "axios": "^1.3.0"
  }
}
```

### C. Desplegar en Railway

1. Pushea a GitHub:

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/tu_usuario/app-pedidos-backend
git push -u origin main
```

2. En Railway:

   - **New** → **GitHub Repo** → Selecciona el repo
   - **Add Variables** (las del `.env`)
   - Railway automáticamente detecta `package.json` y instala dependencias
   - Auto-deploys cuando haces push a GitHub

3. Obtén la URL:
   - En Railway, ve a **Deployments**
   - Copia la URL del dominio (ej: `app-pedidos-backend.up.railway.app`)

---

## OPCIÓN 3: Usar Vercel para Email (ALTERNATIVA)

Si prefieres Vercel en lugar de Railway:

### A. Crear serverless function en Vercel

1. Ir a [vercel.com](https://vercel.com)
2. **New Project** → **Import Git Repository**

**Estructura:**

```
vercel.json
api/
  reset-password.js
```

**`api/reset-password.js`:**

```javascript
import nodemailer from "nodemailer";

export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method not allowed" });
  }

  const { email, resetToken } = req.body;

  const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASSWORD,
    },
  });

  try {
    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: email,
      subject: "Restablecer tu contraseña",
      html: `
        <h2>Restablecer Contraseña</h2>
        <a href="${process.env.APP_URL}/reset?token=${resetToken}">
          Haz clic aquí
        </a>
      `,
    });

    return res.status(200).json({ success: true });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
}
```

**`vercel.json`:**

```json
{
  "env": {
    "EMAIL_USER": "@email_user",
    "EMAIL_PASSWORD": "@email_password",
    "APP_URL": "@app_url"
  }
}
```

---

## CONFIGURACIÓN DE GMAIL APP PASSWORD

Necesitas **App Password** de Google (no tu contraseña):

1. Ve a [myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)
2. Selecciona:
   - **App**: Mail
   - **Device**: Windows Computer
3. Google te da una contraseña de 16 caracteres
4. Usa esa contraseña en `EMAIL_PASSWORD`

---

## ¿CUÁL ELEGIR?

| Opción       | Ventajas                             | Desventajas           | Tiempo    |
| ------------ | ------------------------------------ | --------------------- | --------- |
| **Supabase** | Fácil, integrado, todos los features | Menos customización   | ⏱️ 5 min  |
| **Railway**  | Full control, fácil de desplegar     | Más configuración     | ⏱️ 30 min |
| **Vercel**   | Serverless, rápido, pay-as-you-go    | Requiere conocimiento | ⏱️ 20 min |

### ✅ **RECOMENDACIÓN FINAL:**

**Usa Supabase completo (que ya está configurado)**. Es lo más fácil y tiene todo que necesitas.

---

## 📝 PRÓXIMOS PASOS

Si decides usar Railway/Vercel:

1. Crea el backend
2. Obtén la URL
3. En `lib/providers/auth_provider.dart`, agrega:

```dart
final resetPasswordProvider = FutureProvider.family<bool, String>((ref, email) async {
  final response = await http.post(
    Uri.parse('https://tu-backend.railway.app/api/reset-password'),
    body: jsonEncode({'email': email}),
  );
  return response.statusCode == 200;
});
```

4. Usa en `forgot_password_screen.dart`

---

¿Necesitas ayuda con Railway o Vercel? 📞
