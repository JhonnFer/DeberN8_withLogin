# 🚂 RAILWAY DEPLOYMENT - GUÍA PASO A PASO

## 📍 TU CONFIGURACIÓN

- **GitHub Repo:** `JhonnFer/DeberN8_withLogin`
- **Carpeta a desplegar:** `web-recovery/`
- **Root Directory en Railway:** `web-recovery`

---

## ⚡ PASOS PARA DESPLEGAR (10 MINUTOS)

### Paso 1: Conectar GitHub a Railway

1. Ve a https://railway.app/dashboard
2. Click en **"New Project"**
3. Selecciona **"Deploy from GitHub"**
4. Autoriza Railway acceder a tu GitHub
5. Busca y selecciona: `JhonnFer/DeberN8_withLogin`

### Paso 2: Configurar Root Directory

1. En Railway, después de conectar el repo:
2. Verás una pantalla con **"Configure"**
3. En la sección **"Root Directory"**:
   - Escribe: `web-recovery`
   - Click en **Save** o **Continue**

```
Root Directory: web-recovery
```

### Paso 3: Variables de Entorno (Opcional)

Si necesitas variables personalizadas:

1. En Railway Dashboard → Variables
2. Agrega:
   ```
   SUPABASE_URL = https://tu-proyecto.supabase.co
   SUPABASE_ANON_KEY = eyJhbGc...
   NODE_ENV = production
   ```

### Paso 4: Deploy

Railway automáticamente:

1. Clona el repo
2. Va a la carpeta `web-recovery/`
3. Ejecuta `npm install`
4. Ejecuta `npm start` (desde Procfile/package.json)
5. ¡Tu app está viva!

### ✅ ¡LISTO!

Tu URL será algo como:

```
https://app-pedidos-pwd-recovery-production.up.railway.app
```

---

## 🔍 DÓNDE CONFIGURAR CADA COSA

### En Railway Dashboard

```
Dashboard
├── New Project
│   ├── Deploy from GitHub ← AQUÍ COMIENZA
│   └── Authorize GitHub
│
├── Selecciona Repository
│   └── JhonnFer/DeberN8_withLogin ← TU REPO
│
├── Configure Deployment
│   ├── Root Directory: web-recovery ← MUY IMPORTANTE
│   └── Save
│
├── Variables (Opcional)
│   ├── SUPABASE_URL = ...
│   └── SUPABASE_ANON_KEY = ...
│
└── Deploy
    └── ¡VIVO! 🚀
```

---

## 📋 ESTRUCTURA DEL REPO EN GITHUB

```
JhonnFer/DeberN8_withLogin/
├── web-recovery/              ← Root Directory = web-recovery
│   ├── server.js              ✅ Existe
│   ├── package.json           ✅ Existe
│   ├── Procfile               ✅ Existe
│   ├── reset-password.html
│   ├── styles.css
│   └── script.js
│
├── app_pedidos/               ← No deployaremos esto (es Flutter)
├── .gitignore
└── README.md
```

---

## ✨ RAILWAY DETECTARÁ AUTOMÁTICAMENTE

Cuando apuntes a `web-recovery/` como Root Directory, Railway:

✅ Encontrará `package.json`
✅ Verá `"start": "node server.js"`
✅ Ejecutará `npm install`
✅ Ejecutará `npm start`
✅ El puerto se asignará automáticamente

---

## 🔧 PASOS VISUALES EN RAILWAY

### Pantalla 1: New Project

```
┌──────────────────────────────┐
│   Create a new project       │
├──────────────────────────────┤
│ [ ] Deploy from GitHub       │ ← Click aquí
│ [ ] Database                 │
│ [ ] From Template            │
└──────────────────────────────┘
```

### Pantalla 2: Autorizar GitHub

```
Se abre GitHub OAuth
Autoriza: "authorize-railway"
Regresa a Railway automáticamente
```

### Pantalla 3: Seleccionar Repo

```
┌──────────────────────────────────┐
│   Search repositories            │
├──────────────────────────────────┤
│ JhonnFer/DeberN8_withLogin  ✓   │ ← Busca y click
└──────────────────────────────────┘
```

### Pantalla 4: Root Directory (¡MUY IMPORTANTE!)

```
┌──────────────────────────────────┐
│   Configure deployment           │
├──────────────────────────────────┤
│ Root directory                   │
│ ┌─────────────────────────────┐ │
│ │ web-recovery                │ │ ← Escribe aquí
│ └─────────────────────────────┘ │
│                                  │
│ [ Save ]  [ Continue ]           │
└──────────────────────────────────┘
```

### Pantalla 5: Variables (Opcional)

```
┌──────────────────────────────────┐
│   Environment Variables          │
├──────────────────────────────────┤
│ SUPABASE_URL                     │
│ ┌─────────────────────────────┐ │
│ │ https://...supabase.co     │ │
│ └─────────────────────────────┘ │
│                                  │
│ SUPABASE_ANON_KEY               │
│ ┌─────────────────────────────┐ │
│ │ eyJhbGc...                  │ │
│ └─────────────────────────────┘ │
└──────────────────────────────────┘
```

### Pantalla 6: Deploy

```
┌──────────────────────────────────┐
│   Deployment Status              │
├──────────────────────────────────┤
│ ⚙️  Building...                   │
│ ✅ npm install                   │
│ ✅ npm start                     │
│ ✅ Server running                │
│                                  │
│ URL:                             │
│ https://app-pedidos-pwd-recovery │
│ -production.up.railway.app       │
└──────────────────────────────────┘
```

---

## 🧪 VERIFICAR QUE FUNCIONA

### Opción 1: Abrir en navegador

```
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html
```

Debería mostrar la página de reset.

### Opción 2: Health Check

```
https://app-pedidos-pwd-recovery-production.up.railway.app/health
```

Debería devolver:

```json
{
  "status": "ok",
  "timestamp": "2025-12-25T..."
}
```

### Opción 3: Ver Logs

En Railway Dashboard → Logs:

```
✅ Server running on port 3000
✅ GET /reset-password.html 200
```

---

## 📋 CHECKLIST

```
PRE-DEPLOYMENT:
☐ Hiciste git push (ya hecho ✅)
☐ Repo está en GitHub: JhonnFer/DeberN8_withLogin
☐ web-recovery/ está en la raíz del repo

RAILWAY SETUP:
☐ Tienes cuenta en railway.app
☐ Conectaste GitHub a Railway
☐ Seleccionaste el repo correcto
☐ Configuraste Root Directory = web-recovery
☐ Agregaste variables (si necesitas)

VERIFICACIÓN:
☐ Railway dice "Deployment Successful"
☐ Página carga en navegador
☐ Health check responde
☐ Logs no muestran errores
```

---

## ⚠️ PROBLEMAS COMUNES

### Error: "Cannot find module 'express'"

**Solución:** En web-recovery/, verifica que `package.json` tenga:

```json
{
  "dependencies": {
    "express": "^4.18.2"
  }
}
```

Si falta, en tu PC:

```bash
cd web-recovery
npm install express
git add package-lock.json
git commit -m "Add express dependency"
git push
```

Railway automáticamente redeploy.

### Error: "Root directory not found"

**Solución:** En Railway, verifica que escribiste exactamente:

```
web-recovery
```

No `web-recovery/` (sin slash al final).

### La página no carga

**Solución:** En Railway → Logs, busca errores. Probablemente:

- Port está tomado (Railway lo asigna automáticamente)
- Archivo no existe
- Syntax error en JavaScript

### Deploy infinite

**Solución:** En Railway → Deployment:

- Click en "Cancel"
- Verifica package.json
- Verifica Procfile
- Reintenta

---

## 🔗 CONFIGURAR EN SUPABASE

Después de que funcione en Railway:

**Supabase → Authentication → URL Configuration:**

Agrega en **Redirect URLs:**

```
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html
```

(Reemplaza con tu URL real de Railway)

---

## 📊 FLUJO COMPLETO CON GITHUB + RAILWAY

```
1. Tu código en GitHub
   ↓
   JhonnFer/DeberN8_withLogin
   └── web-recovery/
       ├── server.js
       ├── package.json
       └── ...

2. Railway conecta a GitHub
   ↓
   Autoriza acceso

3. Selecciona repo y rama
   ↓
   JhonnFer/DeberN8_withLogin / main

4. Configura Root Directory
   ↓
   web-recovery

5. Railway clona y despliega
   ↓
   npm install
   npm start

6. Servidor activo
   ↓
   https://...up.railway.app

7. Email de Supabase apunta aquí
   ↓
   Usuario abre link → funciona ✅
```

---

## 💡 TIPS

### Tip 1: Auto-deploy con cada git push

Railway automáticamente redeploy cuando haces:

```bash
git push origin main
```

No necesitas hacer `railway up` manualmente.

### Tip 2: Ver logs en tiempo real

```bash
railway logs -f
```

### Tip 3: Variables secretas

Para no exponer credenciales en GitHub:

- En Railway Dashboard → Variables
- Agrega variables allí
- Script.js las lee automáticamente

### Tip 4: Cambiar rama

Si quieres desplegar desde otra rama:

- Railway → Deployments → Redeploy
- Selecciona rama diferente

---

## ✅ RESUMEN

| Acción      | Dónde       | Qué hacer                               |
| ----------- | ----------- | --------------------------------------- |
| 1. GitHub   | Tu PC       | `git push origin main` ✅               |
| 2. Railway  | railway.app | New Project → Deploy from GitHub        |
| 3. Repo     | Railway     | Selecciona `JhonnFer/DeberN8_withLogin` |
| 4. Root Dir | Railway     | Escribe `web-recovery`                  |
| 5. Deploy   | Railway     | Click en Deploy                         |
| 6. Verifica | Navegador   | Abre https://...up.railway.app          |
| 7. Supabase | Supabase    | Agrega URL a Redirect URLs              |

---

## 🎉 RESULTADO FINAL

```
┌─────────────────────────────────────┐
│   RAILWAY DEPLOYMENT EXITOSO        │
│                                     │
│   Repository:                       │
│   JhonnFer/DeberN8_withLogin        │
│                                     │
│   Root Directory:                   │
│   web-recovery/                     │
│                                     │
│   URL:                              │
│   https://app-pedidos-pwd-recovery  │
│   -production.up.railway.app        │
│                                     │
│   Status: ✅ LIVE 24/7              │
│                                     │
└─────────────────────────────────────┘
```

---

## 🚀 PRÓXIMOS PASOS

1. Ve a https://railway.app/dashboard
2. Haz login (si no estás)
3. Click en **"New Project"**
4. **"Deploy from GitHub"**
5. Autoriza GitHub
6. Busca `JhonnFer/DeberN8_withLogin`
7. Root Directory: `web-recovery`
8. Deploy
9. ¡Listo! 🎉

---

**Tu carpeta web-recovery está en Railway. El usuario final verá tu página de recuperación de contraseña.** 🚂✨
