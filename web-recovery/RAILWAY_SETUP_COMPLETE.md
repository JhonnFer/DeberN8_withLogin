# ✅ CARPETA WEB-RECOVERY CONFIGURADA PARA RAILWAY

## 📦 ARCHIVOS AGREGADOS/MODIFICADOS

```
web-recovery/
├── ✨ server.js              ← Servidor Express Node.js
├── ✏️  package.json           ← Ahora con Express como dependencia
├── 🆕 Procfile                ← Instrucciones para Railway
├── 🆕 railway.json            ← Configuración Railway avanzada
├── 🆕 .railwayignore          ← Archivos a ignorar en deploy
├── 🆕 RAILWAY_DEPLOYMENT.md   ← Guía de deployment (250+ líneas)
│
├── reset-password.html       ← Página HTML
├── styles.css                ← Estilos
├── script.js                 ← ✏️ Actualizado con comentarios de Railway
├── README.md                 ← Guía general
└── QUICKSTART.md             ← Setup rápido
```

---

## 🚀 CÓMO DEPLOYAR EN RAILWAY (5 MINUTOS)

### Paso 1: Instalar Railway CLI

```bash
npm install -g @railway/cli
```

### Paso 2: Hacer login

```bash
railway login
```

### Paso 3: Inicializar desde web-recovery

```bash
cd app_pedidos/web-recovery
railway init
```

### Paso 4: Desplegar

```bash
railway up
```

### ✅ ¡Listo!

Tu app estará en:

```
https://app-pedidos-pwd-recovery-production.up.railway.app
```

---

## 🔧 CÓMO FUNCIONA

### Local (Desarrollo)

```bash
cd web-recovery
npm install
npm start
# http://localhost:3000/reset-password.html
```

### Railway (Producción)

```bash
railway up
# https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html
```

---

## 📋 NUEVO SERVIDOR EXPRESS

### server.js

```javascript
// Escucha en puerto 3000 (o la que Railway asigne)
// Sirve reset-password.html
// Tiene health check en /health
```

**Características:**

- ✅ Estático (sirve archivos HTML, CSS, JS)
- ✅ Health check en `/health` (para Railway)
- ✅ 404 automático a reset-password.html
- ✅ Compatible con Railway

---

## 🌍 URL FINAL EN SUPABASE

Después de deployar en Railway, agrega esta URL a Supabase:

**En Supabase → Authentication → URL Configuration → Redirect URLs:**

```
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html
```

---

## 📊 FLUJO COMPLETO

```
Usuario en Flutter
    ↓
"Olvidé contraseña" → Email
    ↓
Supabase envía email con link a:
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html?token=...
    ↓
Usuario abre link
    ↓
Railway sirve página
    ↓
script.js valida token de Supabase
    ↓
Muestra formulario
    ↓
Usuario cambia contraseña
    ↓
Éxito ✅
```

---

## 💻 ARCHIVOS CLAVE

### `server.js` - Qué Hace

```javascript
// Puerto: 3000 (o la que Railway asigne)
// Ruta raíz: / → reset-password.html
// Ruta reset: /reset-password.html → reset-password.html
// Health: /health → {"status":"ok"}
// 404: Todo → reset-password.html
```

### `Procfile` - Le Dice a Railway

```
web: node server.js
```

Traducción: "Railway, ejecuta `node server.js` como el proceso web"

### `railway.json` - Configuración

```json
{
  "build": "nixpacks",
  "deploy": {
    "startCommand": "npm start"
  }
}
```

---

## 🧪 TESTING

### Test 1: Local primero

```bash
cd web-recovery
npm install
npm start

# Test en navegador: http://localhost:3000/reset-password.html
```

### Test 2: En Railway

```bash
railway logs -f

# Abre la URL en navegador
# Verifica que cargue la página
```

### Test 3: Flujo completo

```
1. Flutter → Forgot Password
2. Ingresa email
3. Revisa email
4. Abre link (va a Railway)
5. Formulario carga
6. Ingresa contraseña
7. ¡Éxito!
```

---

## 📝 VARIABLES EN RAILWAY

Las credenciales de Supabase ya están en `script.js`, pero si quieres usar variables de Railway:

```bash
railway variables set SUPABASE_URL https://tu-proyecto.supabase.co
railway variables set SUPABASE_ANON_KEY eyJhbGc...
```

Luego en script.js:

```javascript
const SUPABASE_URL = process.env.SUPABASE_URL || "...";
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || "...";
```

---

## 🔗 MONITOREAR RAILWAY

```bash
# Ver logs en tiempo real
railway logs -f

# Ver variables
railway variables list

# Ver status
railway status

# Health check
curl https://app-pedidos-pwd-recovery-production.up.railway.app/health
```

---

## 💰 COSTOS

```
Plan Free:
✅ $5/mes de crédito
✅ Apps pequeñas gratis
✅ 3 proyectos máximo

Para esta app: ✅ GRATIS (consume muy poco)
```

---

## 🎯 PRÓXIMOS PASOS

1. **Lee:** [web-recovery/RAILWAY_DEPLOYMENT.md](RAILWAY_DEPLOYMENT.md)

2. **Instala Railway CLI:**

   ```bash
   npm install -g @railway/cli
   ```

3. **Desde web-recovery/, ejecuta:**

   ```bash
   railway init
   railway up
   ```

4. **Configura en Supabase:**

   - URL Configuration → Redirect URLs
   - Agrega URL de Railway

5. **Prueba:**
   - Forgot Password en app
   - Abre link del email
   - ¡Debe funcionar!

---

## ✅ COMPARATIVA: Local vs Railway

| Aspecto         | Local                          | Railway                   |
| --------------- | ------------------------------ | ------------------------- |
| URL             | http://localhost:3000          | https://...up.railway.app |
| HTTPS           | ❌ No                          | ✅ Sí                     |
| Accesible desde | Tu PC                          | Internet                  |
| Costo           | Gratis                         | $5/mes (o gratis)         |
| Setup           | 1 minuto                       | 5 minutos                 |
| Mantenimiento   | Debes mantener tu PC encendido | 24/7 automático           |

---

## 📞 DOCUMENTACIÓN

**Dentro de web-recovery/:**

- `RAILWAY_DEPLOYMENT.md` - Guía completa (250+ líneas)
- `QUICKSTART.md` - Setup rápido (5 minutos)
- `README.md` - Guía general

**Links útiles:**

- Railway Docs: https://docs.railway.app
- Railway CLI: https://railway.app/cli

---

## 🎉 STATUS

```
┌──────────────────────────────────────────┐
│   WEB-RECOVERY CONFIGURADA PARA RAILWAY │
│                                          │
│   ✅ Servidor Express creado             │
│   ✅ package.json actualizado            │
│   ✅ Procfile listo                      │
│   ✅ railway.json listo                  │
│   ✅ .railwayignore creado               │
│   ✅ Documentación completa              │
│   ✅ Listo para railway up               │
│                                          │
│   Status: LISTO PARA RAILWAY 🚂          │
│                                          │
└──────────────────────────────────────────┘
```

---

**👉 Empieza:** `railway init` desde `web-recovery/` 🚀

**📖 Aprende:** [RAILWAY_DEPLOYMENT.md](RAILWAY_DEPLOYMENT.md)
