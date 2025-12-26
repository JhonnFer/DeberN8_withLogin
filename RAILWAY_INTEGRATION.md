# 🚂 WEB-RECOVERY LISTA PARA RAILWAY

## 📦 CAMBIOS REALIZADOS

La carpeta `web-recovery/` ahora está **100% lista para deployar en Railway**:

```
web-recovery/
├── 🆕 server.js              ← Servidor Express Node.js
├── ✏️  package.json           ← Con Express agregado
├── 🆕 Procfile                ← Instrucciones para Railway
├── 🆕 railway.json            ← Config Railway
├── 🆕 .railwayignore          ← Archivos a ignorar
├── 🆕 RAILWAY_DEPLOYMENT.md   ← Guía completa
├── 🆕 RAILWAY_SETUP_COMPLETE.md ← Resumen
│
└── [Otros archivos HTML/CSS/JS intactos]
```

---

## ⚡ DEPLOY EN RAILWAY (5 MINUTOS)

### 1️⃣ Instalar CLI

```bash
npm install -g @railway/cli
```

### 2️⃣ Login

```bash
railway login
```

### 3️⃣ Desplegar

```bash
cd app_pedidos/web-recovery
railway init
railway up
```

### ✅ ¡LISTO!

Tu URL será:

```
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html
```

---

## 🔧 CÓMO FUNCIONA

### En tu PC (Desarrollo)

```bash
cd web-recovery
npm install
npm start
# Acceso: http://localhost:3000/reset-password.html
```

### En Railway (Producción)

```bash
railway up
# Acceso: https://...up.railway.app/reset-password.html
```

---

## 📋 NUEVOS ARCHIVOS

| Archivo                     | Propósito                  | Líneas |
| --------------------------- | -------------------------- | ------ |
| `server.js`                 | Servidor Express Node.js   | 30     |
| `Procfile`                  | Instrucciones para Railway | 1      |
| `railway.json`              | Config avanzada            | 20     |
| `.railwayignore`            | Archivos a ignorar         | 10     |
| `RAILWAY_DEPLOYMENT.md`     | Guía deployment            | 250+   |
| `RAILWAY_SETUP_COMPLETE.md` | Resumen                    | 80     |

---

## 🌍 CONFIGURAR EN SUPABASE

Después de que estén en Railway, agrega esta URL a Supabase:

**Supabase → Authentication → URL Configuration → Redirect URLs:**

```
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html
```

---

## 📊 FLUJO FINAL

```
Email con link de Supabase
    ↓
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html
    ↓
Railway sirve página (desde server.js)
    ↓
Script.js valida token de Supabase
    ↓
Usuario cambia contraseña
    ↓
✅ Éxito
```

---

## 💡 VENTAJAS DE RAILWAY PARA ESTO

```
✅ HTTPS automático (requerido por Supabase)
✅ URL pública 24/7 (no depende de tu PC)
✅ Gratis con $5/mes de crédito
✅ Deploy en segundos
✅ Health check incluido
✅ Logs en tiempo real
✅ Variables de entorno integradas
✅ Auto-restart si falla
```

---

## 🧪 TESTING

### Local

```bash
cd web-recovery
npm install
npm start
# Abre: http://localhost:3000/reset-password.html
```

### Railway

```bash
railway logs -f
# Abre: https://...up.railway.app/reset-password.html
```

---

## 📞 DOCUMENTACIÓN COMPLETA

Dentro de `web-recovery/`:

- **[RAILWAY_DEPLOYMENT.md](web-recovery/RAILWAY_DEPLOYMENT.md)** - Guía 250+ líneas
- **[RAILWAY_SETUP_COMPLETE.md](web-recovery/RAILWAY_SETUP_COMPLETE.md)** - Resumen
- **[QUICKSTART.md](web-recovery/QUICKSTART.md)** - 5 minutos
- **[README.md](web-recovery/README.md)** - Guía general

---

## ✅ CHECKLIST

- [ ] Instalé `@railway/cli`
- [ ] Ejecuté `railway login`
- [ ] Desde `web-recovery/`, ejecuté `railway init`
- [ ] Ejecuté `railway up`
- [ ] Anoté la URL de Railway
- [ ] Agregué URL a Supabase → URL Configuration
- [ ] Probé localmente primero
- [ ] Probé en Railway
- [ ] Probé flujo completo (Forgot → Email → Reset → Success)

---

## 🎯 PRÓXIMOS PASOS

1. Lee [web-recovery/RAILWAY_DEPLOYMENT.md](web-recovery/RAILWAY_DEPLOYMENT.md)
2. Instala Railway CLI
3. Ejecuta `railway init` desde `web-recovery/`
4. Ejecuta `railway up`
5. ¡Listo! 🚀

---

## 💰 COSTOS

```
Plan Gratuito: $5/mes de crédito
Esta app: ~$0.50/mes (muy barato)
Resultado: GRATIS ✅
```

---

## 🎉 STATUS

```
WEB-RECOVERY LISTA PARA RAILWAY ✅

✨ Servidor Express: Listo
📦 package.json: Actualizado
🚂 Railway config: Lista
📝 Documentación: Completa
🧪 Testing: Local OK

¡A DEPLOYAR! 🚀
```

---

**👉 Comando rápido:**

```bash
cd web-recovery && npm install && npm start
# Prueba local en http://localhost:3000
```

**Luego:**

```bash
railway init
railway up
# ¡En Railway! 🚂
```

**Documentación:** [RAILWAY_DEPLOYMENT.md](web-recovery/RAILWAY_DEPLOYMENT.md)
