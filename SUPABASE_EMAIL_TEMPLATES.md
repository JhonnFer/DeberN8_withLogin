# 📧 Templates de Email para Supabase

## Ubicación en Supabase

1. Ve a: https://app.supabase.com
2. **Authentication** → **Email Templates**
3. Selecciona cada tipo y copia el contenido

---

## 1️⃣ RESET PASSWORD (Lo más importante)

**Tipo:** `Reset Password`

### Asunto:

```
Restablecer tu contraseña en App Pedidos
```

### Contenido HTML:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <style>
      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
          sans-serif;
        background: #f5f5f5;
        margin: 0;
        padding: 20px;
      }
      .container {
        background: white;
        max-width: 600px;
        margin: 0 auto;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }
      .header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 30px 20px;
        text-align: center;
      }
      .header h1 {
        margin: 0;
        font-size: 28px;
      }
      .content {
        padding: 30px 20px;
      }
      .content p {
        color: #333;
        line-height: 1.6;
        margin: 15px 0;
      }
      .button {
        display: inline-block;
        background: #ff6b35;
        color: white;
        padding: 12px 30px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 600;
        margin: 20px 0;
      }
      .button:hover {
        background: #ff5722;
      }
      .footer {
        background: #f9f9f9;
        padding: 20px;
        text-align: center;
        color: #666;
        font-size: 12px;
        border-top: 1px solid #eee;
      }
      .warning {
        background: #fff3cd;
        border-left: 4px solid #ffc107;
        padding: 15px;
        margin: 20px 0;
        color: #856404;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>🍔 App Pedidos</h1>
        <p>Restablecer Contraseña</p>
      </div>

      <div class="content">
        <p>Hola,</p>

        <p>
          Recibimos una solicitud para restablecer la contraseña de tu cuenta en
          <strong>App Pedidos</strong>.
        </p>

        <p>Haz clic en el botón de abajo para restablecer tu contraseña:</p>

        <center>
          <a href="{{ .ConfirmationURL }}" class="button"
            >Restablecer Contraseña</a
          >
        </center>

        <p>O copia y pega este enlace en tu navegador:</p>
        <p
          style="word-break: break-all; background: #f5f5f5; padding: 10px; border-radius: 4px; font-size: 12px;"
        >
          {{ .ConfirmationURL }}
        </p>

        <div class="warning">
          <strong>⚠️ Por seguridad:</strong> Este enlace expira en 1 hora. Si no
          solicitaste un reseteo de contraseña, ignora este email.
        </div>

        <p>Si tienes problemas, contáctanos directamente.</p>

        <p>Saludos,<br /><strong>El equipo de App Pedidos</strong></p>
      </div>

      <div class="footer">
        <p>
          Este es un email automatizado. No respondas directamente a este
          correo.
        </p>
        <p>&copy; 2025 App Pedidos. Todos los derechos reservados.</p>
      </div>
    </div>
  </body>
</html>
```

---

## 2️⃣ CONFIRMATION (Para registros nuevos)

**Tipo:** `Confirmation`

### Asunto:

```
Confirma tu correo en App Pedidos
```

### Contenido HTML:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <style>
      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
          sans-serif;
        background: #f5f5f5;
        margin: 0;
        padding: 20px;
      }
      .container {
        background: white;
        max-width: 600px;
        margin: 0 auto;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }
      .header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 30px 20px;
        text-align: center;
      }
      .header h1 {
        margin: 0;
        font-size: 28px;
      }
      .content {
        padding: 30px 20px;
      }
      .content p {
        color: #333;
        line-height: 1.6;
        margin: 15px 0;
      }
      .button {
        display: inline-block;
        background: #28a745;
        color: white;
        padding: 12px 30px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 600;
        margin: 20px 0;
      }
      .button:hover {
        background: #218838;
      }
      .footer {
        background: #f9f9f9;
        padding: 20px;
        text-align: center;
        color: #666;
        font-size: 12px;
        border-top: 1px solid #eee;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>🍔 App Pedidos</h1>
        <p>Bienvenido</p>
      </div>

      <div class="content">
        <p>¡Hola! 👋</p>

        <p>Gracias por registrarte en <strong>App Pedidos</strong>.</p>

        <p>
          Para confirmar tu correo y activar tu cuenta, haz clic en el botón de
          abajo:
        </p>

        <center>
          <a href="{{ .ConfirmationURL }}" class="button">Confirmar Correo</a>
        </center>

        <p>O copia y pega este enlace:</p>
        <p
          style="word-break: break-all; background: #f5f5f5; padding: 10px; border-radius: 4px; font-size: 12px;"
        >
          {{ .ConfirmationURL }}
        </p>

        <p>Este enlace expira en 24 horas.</p>

        <p>¿Preguntas? Estamos aquí para ayudarte.</p>

        <p>Saludos,<br /><strong>El equipo de App Pedidos</strong></p>
      </div>

      <div class="footer">
        <p>
          Este es un email automatizado. No respondas directamente a este
          correo.
        </p>
        <p>&copy; 2025 App Pedidos. Todos los derechos reservados.</p>
      </div>
    </div>
  </body>
</html>
```

---

## 3️⃣ MAGIC LINK (Opcional - login sin contraseña)

**Tipo:** `Magic Link`

### Asunto:

```
Tu enlace mágico de acceso a App Pedidos
```

### Contenido HTML:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <style>
      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
          sans-serif;
        background: #f5f5f5;
        margin: 0;
        padding: 20px;
      }
      .container {
        background: white;
        max-width: 600px;
        margin: 0 auto;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }
      .header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 30px 20px;
        text-align: center;
      }
      .header h1 {
        margin: 0;
        font-size: 28px;
      }
      .content {
        padding: 30px 20px;
      }
      .button {
        display: inline-block;
        background: #004e89;
        color: white;
        padding: 12px 30px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 600;
        margin: 20px 0;
      }
      .footer {
        background: #f9f9f9;
        padding: 20px;
        text-align: center;
        color: #666;
        font-size: 12px;
        border-top: 1px solid #eee;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>🍔 App Pedidos</h1>
        <p>Acceso Rápido</p>
      </div>

      <div class="content">
        <p>¡Hola!</p>

        <p>Haz clic en el botón de abajo para acceder a tu cuenta:</p>

        <center>
          <a href="{{ .ConfirmationURL }}" class="button"
            >Acceder a App Pedidos</a
          >
        </center>

        <p>Este enlace expira en 15 minutos.</p>

        <p>Saludos,<br /><strong>El equipo de App Pedidos</strong></p>
      </div>

      <div class="footer">
        <p>
          Este es un email automatizado. No respondas directamente a este
          correo.
        </p>
      </div>
    </div>
  </body>
</html>
```

---

## 📝 Cómo usar en Supabase

### Paso 1: Ve a Email Templates

```
https://app.supabase.com
  → Tu Proyecto
    → Authentication (en sidebar)
      → Email Templates
```

### Paso 2: Configura Reset Password

1. Haz clic en **"Reset Password"**
2. Asunto: `Restablecer tu contraseña en App Pedidos`
3. Contenido: Copia el HTML del template anterior
4. Click **"Save"**

### Paso 3: (Opcional) Configura Confirmation

1. Haz clic en **"Confirmation"**
2. Asunto: `Confirma tu correo en App Pedidos`
3. Contenido: Copia el HTML del template anterior
4. Click **"Save"**

---

## 🔗 Variables disponibles en Supabase

```
{{ .ConfirmationURL }}     → URL completa con token
{{ .Email }}               → Email del usuario
{{ .Token }}               → Token único
{{ .SiteURL }}             → URL de tu sitio (desde settings)
{{ .RedirectTo }}          → URL de redirección
{{ .InvitationLink }}      → Link de invitación (solo invites)
```

---

## ⚠️ URLs Importantes

**Tu URL de Reset:**

```
https://debern8withlogin-production.up.railway.app/reset-password.html
```

La variable `{{ .ConfirmationURL }}` ya incluye el token, así que quedará:

```
https://debern8withlogin-production.up.railway.app/reset-password.html?token=ABC123&type=recovery
```

---

## 🧪 Prueba

Después de configurar los templates:

1. Abre tu app Flutter
2. Click **"Forgot Password"**
3. Ingresa tu email
4. **Revisa el email** (puede tomar 1-2 minutos)
5. Click en el link del email
6. Debería cargar tu página desde Railway ✅

---

## 💾 Resumen rápido

| Tipo               | Asunto                    | Acción                |
| ------------------ | ------------------------- | --------------------- |
| **Reset Password** | Restablecer tu contraseña | Cambiar contraseña    |
| **Confirmation**   | Confirma tu correo        | Verificar nuevo email |
| **Magic Link**     | Tu enlace mágico          | Login sin contraseña  |

**Prioridad:** Configura al menos **Reset Password** para que funcione el flujo de recuperación.
