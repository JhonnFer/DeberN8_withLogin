# ✅ SOLUCIÓN CONFIRMADA: web-recovery está en la RAÍZ

## ✔️ VERIFICACIÓN

En tu PC, web-recovery SÍ está en la raíz:

```
C:\Users\USUARIO\Documents\Semestre-25B\Desarrollo_Movil\TareaN6\app_pedidos\
├── web-recovery/           ← ✅ AQUÍ ESTÁ
├── lib/
├── pubspec.yaml
├── .git/
└── ...
```

---

## ❌ EL PROBLEMA EN RAILWAY

Railway no la encuentra en GitHub. Posibles causas:

1. **No se sincronizó completamente**
2. **Git no rastreó los archivos**
3. **Está en .gitignore**

---

## ✅ SOLUCIÓN: FORZAR GIT A RASTREAR

### Paso 1: Asegúrate que web-recovery está en Git

```bash
# En tu terminal PowerShell, desde app_pedidos/:
cd "C:\Users\USUARIO\Documents\Semestre-25B\Desarrollo_Movil\TareaN6\app_pedidos"

# Ver qué está en git
git ls-files | Select-String "web-recovery"
```

Si ves resultados como:

```
web-recovery/server.js
web-recovery/package.json
web-recovery/script.js
```

✅ Está en Git.

Si NO ves nada, continúa al Paso 2.

### Paso 2: Agregar web-recovery a Git

```bash
# Asegúrate de estar en la raíz del repo (donde está .git/)
cd "C:\Users\USUARIO\Documents\Semestre-25B\Desarrollo_Movil\TareaN6\app_pedidos"

# Agregar específicamente web-recovery
git add web-recovery/

# Ver cambios
git status
# Debería mostrar: "Changes to be committed: web-recovery/..."

# Commit
git commit -m "Ensure web-recovery is tracked by Git"

# Push
git push -u origin main
```

### Paso 3: Verificar en GitHub

Abre: https://github.com/JhonnFer/DeberN8_withLogin

Deberías ver la carpeta `web-recovery/` en la raíz.

### Paso 4: Railway Redeploy

1. https://railway.app/dashboard
2. Abre tu proyecto
3. Click en **"Deployments"**
4. En el deployment fallido, click **"Redeploy"**
5. Verifica:
   - Root Directory: `web-recovery`
   - Rama: `main`
6. Click **Deploy**

---

## 🧪 VERIFICACIÓN COMPLETA

### En tu PC:

```powershell
# 1. Ver estructura
Get-ChildItem -Path "C:\Users\USUARIO\Documents\Semestre-25B\Desarrollo_Movil\TareaN6\app_pedidos\web-recovery" -Name

# Debería mostrar:
# server.js
# package.json
# Procfile
# reset-password.html
# styles.css
# script.js
# etc.

# 2. Ver si está en git
git ls-files | Select-String "web-recovery"

# Debería mostrar archivos de web-recovery/
```

### En GitHub:

Abre: https://github.com/JhonnFer/DeberN8_withLogin

Busca en la raíz:

- ✅ web-recovery/ (carpeta)
- ✅ app_pedidos/ (carpeta)
- ✅ .git/ (carpeta)

---

## 📋 PASOS RÁPIDOS

```bash
# Terminal PowerShell en app_pedidos/:

# 1. Ver estado
git status

# 2. Si web-recovery tiene cambios, agregar
git add web-recovery/

# 3. Commit
git commit -m "Sync web-recovery for Railway deployment"

# 4. Push
git push origin main

# 5. Esperar 30 segundos (GitHub procesa)

# 6. Railway redeploy
```

---

## 🚂 RAILWAY REDEPLOY

Después de `git push`:

1. https://railway.app/dashboard
2. Proyecto: app-pedidos-pwd-recovery
3. Deployments → El que falló → Redeploy
4. Root Directory: `web-recovery`
5. Deploy

---

## ⚠️ SI AÚN FALLA

### Opción A: Eliminar y crear de nuevo

```bash
# En Railway:
# 1. Deployments → Click en los 3 puntos
# 2. Delete Deployment
# 3. Click "New Deployment"
# 4. Configura desde cero:
#    - Root Directory: web-recovery
#    - Branch: main
#    - Deploy
```

### Opción B: Usar Railway CLI

```bash
# Instalar Railway CLI
npm install -g @railway/cli

# Login
railway login

# Desde web-recovery/
cd web-recovery
npm install
npm start

# Luego desde raíz
cd ..
railway link
railway up
```

---

## 🎯 CHECKLIST

```
☐ Git status muestra web-recovery/
☐ git ls-files | Select-String "web-recovery" devuelve archivos
☐ GitHub muestra web-recovery/ en la raíz
☐ En Railway, Root Directory = web-recovery
☐ Railway redeploy dice "✅ Deployment Successful"
☐ URL accesible: https://...up.railway.app/reset-password.html
```

---

## ✅ RESUMEN

**Tu web-recovery ESTÁ en la raíz en tu PC. Solo necesitas:**

1. `git add web-recovery/`
2. `git commit` y `git push`
3. En Railway: Redeploy con Root Directory = `web-recovery`

---

**La solución es sincronizar git y forzar el redeploy en Railway.** 🚂
