# 🚂 DESPLEGAR EN RAILWAY

## 🎯 ¿QUÉ ES RAILWAY?

Railway es una plataforma moderna para deployar aplicaciones:

```
✅ Gratis con $5/mes de crédito
✅ HTTPS automático
✅ Deploy en segundos
✅ Variables de entorno integradas
✅ Soporte para Node.js, Python, Go, etc.
✅ Base de datos incluida
✅ CLI simple
```

---

## ⚡ SETUP EN 5 MINUTOS

### Paso 1: Instalar Railway CLI

```bash
npm install -g @railway/cli
```

O descarga desde: https://railway.app/cli

### Paso 2: Hacer login

```bash
railway login
```

Se abrirá el navegador. Autoriza Railway.

### Paso 3: Initializar proyecto

```bash
cd app_pedidos/web-recovery
railway init
```

Sigue el asistente:

- Project name: `app-pedidos-pwd-recovery`
- Environment: `production`

### Paso 4: Desplegar

```bash
railway up
```

¡Eso es! Railway automáticamente:

- Detecta que es Node.js
- Instala dependencias (`npm install`)
- Ejecuta `npm start` (que corre `node server.js`)
- Asigna una URL pública

### Paso 5: Ver la URL

```bash
railway open
```

O ejecuta:

```bash
railway variables list
```

Tu URL será algo como:

```
https://app-pedidos-pwd-recovery-production.up.railway.app
```

---

## 🔧 CONFIGURAR VARIABLES EN RAILWAY

Railway proporciona las credenciales automáticamente. Si necesitas variables:

### Opción 1: Desde CLI

```bash
railway variables set SUPABASE_URL https://tu-proyecto.supabase.co
railway variables set SUPABASE_ANON_KEY eyJhbGc...
```

### Opción 2: Desde Dashboard

1. Ve a https://railway.app/dashboard
2. Abre tu proyecto `app-pedidos-pwd-recovery`
3. Tab "Variables"
4. Agrega:
   - `SUPABASE_URL` = tu URL
   - `SUPABASE_ANON_KEY` = tu clave

### Opción 3: Desde .env

Crea `.env` en web-recovery/:

```env
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_ANON_KEY=eyJhbGc...
```

Railway lo detectará automáticamente.

---

## 📍 CONFIGURAR EN SUPABASE

### Paso 1: Obtener URL de Railway

Después de deployar:

```bash
railway open
# Anota la URL, ejemplo:
# https://app-pedidos-pwd-recovery-production.up.railway.app
```

### Paso 2: Agregar a Supabase

En Supabase → Authentication → URL Configuration:

```
Redirect URLs:
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html
```

Click en "Save".

---

## 🧪 TESTING

### Test Local Primero

```bash
cd web-recovery
npm install
npm start

# Abre: http://localhost:3000/reset-password.html
```

Verifica que funcione localmente antes de deployar.

### Test en Railway

```bash
railway logs
# Ver logs en tiempo real
```

Si hay errores, aparecerán en los logs.

---

## 📊 ESTRUCTURA DE ARCHIVOS

```
web-recovery/
├── server.js              ← 🆕 Servidor Express
├── package.json           ← ✏️ Actualizado con Express
├── Procfile               ← 🆕 Para Railway
├── railway.json           ← 🆕 Config de Railway
├── .railwayignore         ← 🆕 Archivos a ignorar
│
├── reset-password.html
├── styles.css
├── script.js
├── README.md
└── QUICKSTART.md
```

### Qué hace cada archivo nuevo:

| Archivo        | Propósito                                       |
| -------------- | ----------------------------------------------- |
| `server.js`    | Servidor Node.js/Express que sirve los archivos |
| `Procfile`     | Le dice a Railway que ejecute `node server.js`  |
| `railway.json` | Configuración avanzada de Railway               |
| `package.json` | Ahora incluye Express como dependencia          |

---

## 🔄 FLUJO COMPLETO CON RAILWAY

```
1. Tu código en GitHub
   ↓
2. railway up (o webhook de GitHub)
   ↓
3. Railway detecta Node.js
   ↓
4. npm install (instala Express)
   ↓
5. npm start (corre node server.js)
   ↓
6. Tu servidor está VIVO en:
   https://app-pedidos-pwd-recovery-production.up.railway.app
   ↓
7. Supabase envía email con link a tu dominio
   ↓
8. Usuario abre link → funcionando ✅
```

---

## 📝 MONITOREAR Y MANTENER

### Ver logs en tiempo real

```bash
railway logs -f
```

### Ver variables

```bash
railway variables list
```

### Actualizar código

Simplemente haz:

```bash
git add .
git commit -m "Update password recovery"
git push
```

Railway automáticamente redeploy si tienes GitHub conectado.

### Redeploy manual

```bash
railway up
```

### Ver status del servidor

```bash
# Health check
curl https://app-pedidos-pwd-recovery-production.up.railway.app/health

# Debería devolver:
# {"status":"ok","timestamp":"2025-12-25T..."}
```

---

## 💰 COSTOS

```
Plan Gratuito:
✅ $5/mes de crédito
✅ Ejecutar apps pequeñas gratuitamente
✅ Máximo 3 proyectos

Plan Pro:
💳 $10/mes
✅ Proyectos ilimitados
✅ Mejor soporte
```

Para esta app (recuperación de contraseña), $5/mes es MÁS QUE SUFICIENTE.

---

## 🐛 TROUBLESHOOTING

### Error: "Failed to build"

**Solución:**

```bash
# Verifica que package.json esté correcto
npm install
npm start

# Luego:
railway up
```

### Error: "Cannot find module 'express'"

**Solución:**

```bash
npm install express
git add package-lock.json
git commit -m "Add express dependency"
git push
railway up
```

### La app no inicia

**Solución:**

```bash
# Ver logs detallados
railway logs -f

# Buscar errores en stdout
```

### URL de Railway es muy larga

**Solución:** Puedes cambiar el nombre del proyecto:

1. Railway Dashboard → Settings → Rename Project
2. La URL se acortará automáticamente

---

## 🔗 INTEGRACIÓN CON GITHUB

Para auto-deploy cada vez que hagas push:

### Paso 1: Conectar GitHub

1. Railway Dashboard → GitHub → Authorize
2. Autoriza Railway acceder a tus repositorios

### Paso 2: Configurar auto-deploy

1. Abre el proyecto en Railway
2. Tab "Source"
3. Conecta tu repo de GitHub
4. Selecciona rama `main` o `master`

### Paso 3: Hacer push automáticamente deploya

```bash
git push origin main

# Railway detecta el cambio y automáticamente:
# 1. Clona el repo
# 2. npm install
# 3. npm start
# 4. Redeploy completo
```

---

## 📚 COMANDOS RAILWAY ÚTILES

```bash
# Login
railway login

# Initializar proyecto
railway init

# Ver proyectos
railway list

# Desplegar
railway up

# Abrir dashboard
railway open

# Ver logs
railway logs

# Ver logs en tiempo real
railway logs -f

# Ver variables
railway variables list

# Establecer variable
railway variables set NOMBRE valor

# Abrir shell en el servidor
railway shell

# Ver status
railway status
```

---

## ✅ CHECKLIST PRE-DEPLOYMENT

- [ ] `npm install` funciona localmente
- [ ] `npm start` inicia sin errores
- [ ] App responde en `http://localhost:3000`
- [ ] `/health` devuelve JSON
- [ ] Actualicé SUPABASE_URL en script.js
- [ ] Actualicé SUPABASE_ANON_KEY en script.js
- [ ] Railway CLI está instalado
- [ ] Estoy logged in a Railway (`railway login`)
- [ ] Ejecuté `railway init` desde web-recovery/
- [ ] Ejecuté `railway up`
- [ ] La URL en Railway es accesible
- [ ] Configuré Redirect URL en Supabase

---

## 🎉 ¡LISTO!

Tu página de recuperación de contraseña está en Railway:

```
🚂 Railway URL:
https://app-pedidos-pwd-recovery-production.up.railway.app/reset-password.html

📝 Configurar en Supabase:
Authentication → URL Configuration → Redirect URLs
```

---

## 📞 RECURSOS

- **Railway Docs:** https://docs.railway.app
- **Ejemplos:** https://railway.app/templates
- **CLI Reference:** https://docs.railway.app/reference/cli-api

---

**¡Tu página de recuperación está viva en Railway!** 🚀
