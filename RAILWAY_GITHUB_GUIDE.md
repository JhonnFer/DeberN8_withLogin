# 🚂 RAILWAY + GITHUB - DEPLOYMENT COMPLETO

## 📍 TU CONFIGURACIÓN

```
GitHub Repository: JhonnFer/DeberN8_withLogin
Carpeta a desplegar: web-recovery/
Root Directory en Railway: web-recovery
```

---

## ⚡ DEPLOYMENT EN 5 PASOS

### 1️⃣ Railway Dashboard

```
https://railway.app/dashboard
```

### 2️⃣ New Project

```
Click en "New Project"
```

### 3️⃣ Deploy from GitHub

```
Click en "Deploy from GitHub"
Autoriza Railway acceder a GitHub
```

### 4️⃣ Selecciona Repo

```
Busca: JhonnFer/DeberN8_withLogin
Click para seleccionar
```

### 5️⃣ Configura Root Directory

```
Root Directory: web-recovery
Click en Save/Deploy
```

---

## 🎯 LO MÁS IMPORTANTE

### Root Directory

```
⚠️ DEBE SER: web-recovery
❌ NO: web-recovery/
❌ NO: ./web-recovery
❌ NO: /web-recovery
```

Rail way buscará en esa carpeta:

- `package.json` ✅
- `server.js` ✅
- `Procfile` ✅

---

## 📊 FLUJO AUTOMÁTICO

```
1. Haces git push
   ↓
2. GitHub recibe cambios
   ↓
3. Railway webhook detecta push
   ↓
4. Railway clona el repo
   ↓
5. Va a carpeta: web-recovery/
   ↓
6. npm install
   ↓
7. npm start (node server.js)
   ↓
8. ¡VIVO! 🚀
   https://app-pedidos-pwd-recovery-production.up.railway.app
```

---

## ✅ CHECKLIST

```
PRE-DEPLOY:
☐ Git push hecho (ya lo hiciste ✅)
☐ Repo en GitHub: JhonnFer/DeberN8_withLogin ✅
☐ Carpeta web-recovery/ existe ✅
☐ package.json en web-recovery/ ✅
☐ server.js en web-recovery/ ✅
☐ Procfile en web-recovery/ ✅

RAILWAY SETUP:
☐ Cuenta en railway.app
☐ GitHub conectado
☐ Repo seleccionado
☐ Root Directory = web-recovery

VERIFICACIÓN:
☐ "Deployment Successful"
☐ URL accesible en navegador
☐ /health devuelve JSON
☐ Logs sin errores
```

---

## 🔧 PANTALLAS DE RAILWAY

### Pantalla 1: Project Settings

```
┌─────────────────────────────────────┐
│   Create a new project              │
├─────────────────────────────────────┤
│ Options:                            │
│ [ ] Database                        │
│ [ ] Deploy from GitHub       ← AQUÍ │
│ [ ] From Template                   │
└─────────────────────────────────────┘
```

### Pantalla 2: GitHub Authorization

```
Se abre GitHub OAuth
Autoriza Railway
Regresa automáticamente
```

### Pantalla 3: Select Repository

```
┌─────────────────────────────────────┐
│   Repositories                      │
├─────────────────────────────────────┤
│ Search...                           │
│                                     │
│ ✓ JhonnFer/DeberN8_withLogin       │
│   [Select]                          │
└─────────────────────────────────────┘
```

### Pantalla 4: Configure Root Directory

```
┌─────────────────────────────────────┐
│   Configure                         │
├─────────────────────────────────────┤
│ Root Directory                      │
│ ┌───────────────────────────────┐  │
│ │ web-recovery                  │  │
│ └───────────────────────────────┘  │
│                                     │
│ [Save]  [Continue]  [Deploy Now]  │
└─────────────────────────────────────┘
```

### Pantalla 5: Deployment

```
┌─────────────────────────────────────┐
│   Deployment Log                    │
├─────────────────────────────────────┤
│ ⚙️  Building...                     │
│ ✅ Cloning repository              │
│ ✅ npm install                     │
│ ✅ npm start                       │
│ ✅ Server online                   │
│                                     │
│ URL:                                │
│ https://app-pedidos-pwd-recovery-  │
│ production.up.railway.app           │
└─────────────────────────────────────┘
```

---

## 📋 ESTRUCTURA DEL REPO EN GITHUB

```
JhonnFer/DeberN8_withLogin/
│
├── web-recovery/                    ← ROOT DIRECTORY = web-recovery
│   ├── server.js                    ✅ Necesario
│   ├── package.json                 ✅ Necesario
│   ├── Procfile                     ✅ Necesario
│   ├── railway.json
│   ├── .railwayignore
│   ├── reset-password.html
│   ├── styles.css
│   ├── script.js
│   ├── README.md
│   ├── QUICKSTART.md
│   ├── RAILWAY_DEPLOYMENT.md
│   ├── RAILWAY_GITHUB_DEPLOYMENT.md ← ⭐ Esta guía
│   └── ...
│
├── app_pedidos/                     ← NO se desplegará (Flutter)
│   ├── lib/
│   ├── pubspec.yaml
│   └── ...
│
├── .gitignore
├── .git/
└── README.md
```

---

## 🧪 VERIFICAR QUE FUNCIONA

### Paso 1: Esperar a que Railway termine

```
En Railroad Dashboard → Deployments
Espera a que muestroe "✅ Successful"
```

### Paso 2: Abrir URL en navegador

```
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html
```

Debería mostrarse la página HTML con el formulario.

### Paso 3: Health Check

```
https://app-pedidos-pwd-recovery-production.up.railway.app/health
```

Debería devolver JSON:

```json
{ "status": "ok", "timestamp": "2025-12-25T..." }
```

### Paso 4: Ver logs

En Railway Dashboard → Logs:

```
✅ Server running on port 3000
✅ GET /reset-password.html 200
✅ GET /styles.css 200
✅ GET /script.js 200
```

---

## 📍 CONFIGURAR EN SUPABASE

Después de que funcione en Railway:

**Supabase.com → Tu Proyecto → Authentication → URL Configuration**

En **Redirect URLs**, agrega:

```
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html
```

(Reemplaza el dominio con el tuyo de Railway)

---

## 🔄 AUTO-DEPLOY CON GIT

Cada vez que hagas:

```bash
git push origin main
```

Railway automáticamente:

1. Detecta el cambio
2. Clona el repo
3. npm install
4. npm start
5. Redeploy automático

**NO necesitas hacer `railway up` manualmente.** ✅

---

## 📚 DOCUMENTACIÓN

En `web-recovery/`:

- **[RAILWAY_GITHUB_DEPLOYMENT.md](web-recovery/RAILWAY_GITHUB_DEPLOYMENT.md)** ← Esta guía detallada
- **[RAILWAY_DEPLOYMENT.md](web-recovery/RAILWAY_DEPLOYMENT.md)** - Guía CLI
- **[QUICKSTART.md](web-recovery/QUICKSTART.md)** - 5 minutos
- **[README.md](web-recovery/README.md)** - General

---

## ⚠️ PROBLEMAS COMUNES

| Problema                   | Solución                                                    |
| -------------------------- | ----------------------------------------------------------- |
| "Root directory not found" | Verifica que sea exactamente `web-recovery` (sin slashes)   |
| "Cannot find module"       | En web-recovery/, `npm install` y `git push`                |
| Deploy hangs               | Cancela y reintenta. Verifica logs.                         |
| 404 errors                 | Asegúrate que /reset-password.html está en web-recovery/    |
| Port error                 | Railway asigna el puerto automáticamente. No lo configures. |

---

## 🚀 COMANDO FINAL

Desde tu PC:

```bash
# Ya hecho, pero para futuras actualizaciones:
cd app_pedidos
git add .
git commit -m "Update password recovery"
git push origin main

# Railway automáticamente redeploy
```

---

## 🎉 RESULTADO

```
┌──────────────────────────────────────┐
│    DEPLOYMENT EXITOSO EN RAILWAY     │
│                                      │
│    Repo: JhonnFer/DeberN8_withLogin  │
│    Carpeta: web-recovery/            │
│                                      │
│    URL Viva:                         │
│    https://app-pedidos-pwd-recovery  │
│    -production.up.railway.app        │
│                                      │
│    Status: ✅ LIVE 24/7               │
│                                      │
│    Auto-deploy: ✅ Habilitado        │
│    Cada git push = redeploy auto     │
│                                      │
└──────────────────────────────────────┘
```

---

## 📞 QUICK REFERENCE

```
🌐 Railway Dashboard: https://railway.app/dashboard
📚 Railway Docs: https://docs.railway.app
🐙 Tu Repo: https://github.com/JhonnFer/DeberN8_withLogin
📧 Supabase: https://app.supabase.com
```

---

**¡Tu carpeta web-recovery está desplegada en Railway con auto-deploy desde GitHub!** 🚂✨

Guía detallada: [RAILWAY_GITHUB_DEPLOYMENT.md](web-recovery/RAILWAY_GITHUB_DEPLOYMENT.md)
