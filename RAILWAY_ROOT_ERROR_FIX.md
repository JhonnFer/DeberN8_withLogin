# 🚂 SOLUCIÓN: "Could not find root directory: web-recovery"

## ❌ EL PROBLEMA

Railway no encuentra la carpeta `web-recovery` en la raíz del repositorio.

---

## 🔍 DIAGNÓSTICO

### Opción 1: Verificar estructura en GitHub

Ve a: https://github.com/JhonnFer/DeberN8_withLogin

Busca `web-recovery/` en la **raíz del repo**:

```
✅ BIEN:
JhonnFer/DeberN8_withLogin/
├── web-recovery/        ← Aquí
├── app_pedidos/
├── .gitignore
└── README.md

❌ MAL:
JhonnFer/DeberN8_withLogin/
├── app_pedidos/
│   ├── web-recovery/    ← Aquí NO (está dentro de app_pedidos)
│   └── ...
└── ...
```

---

## ✅ SOLUCIONES

### Solución 1: Si web-recovery está dentro de app_pedidos/

En Railway, configura:

```
Root Directory: app_pedidos/web-recovery
```

**Pasos:**

1. En Railway Dashboard → Deployment
2. Click en el deployment que falló
3. Click en **"Redeploy"**
4. Cambia Root Directory a: `app_pedidos/web-recovery`
5. Click en **Deploy**

---

### Solución 2: Si web-recovery debería estar en la raíz

**En tu PC:**

```bash
# Desde app_pedidos/
cd app_pedidos

# Ver estructura actual
ls -la

# Si web-recovery está aquí:
# Mover a la raíz del repo
cd ..
mv app_pedidos/web-recovery .

# Ver nuevo resultado
ls -la
# Debería mostrar:
# - web-recovery/
# - app_pedidos/
# - .git/
# - .gitignore

# Subir a GitHub
git add .
git commit -m "Move web-recovery to repo root"
git push origin main
```

Luego en Railway:

1. Click **"Redeploy"**
2. Railway detecta los cambios
3. Intenta nuevamente con Root Directory = `web-recovery`

---

### Solución 3: Verificar el nombre exacto

A veces hay diferencias en mayúsculas/minúsculas.

**En GitHub**, busca exactamente:

```
web-recovery    ← Todo minúsculas
web-Recovery    ← Mayúscula
WebRecovery     ← Camel case
```

Una vez identifiques el nombre exacto, en Railway usa ese mismo nombre.

---

## 🛠️ PASO A PASO PARA SOLUCIONAR

### Paso 1: Ver la estructura en GitHub

```bash
# En tu PC, abre GitHub o verifica:
git ls-files | grep -E "^web-recovery"

# Si aparece algo como:
# web-recovery/script.js
# web-recovery/server.js

# Significa que existe en la raíz ✅
```

### Paso 2: Si está en app_pedidos/, mover

```bash
cd app_pedidos
pwd  # Verifica dónde estás

# Si web-recovery está aquí, mover a raíz:
cd ..
mv app_pedidos/web-recovery .

# Verificar
ls -la web-recovery/
# Debería mostrar: server.js, package.json, etc.
```

### Paso 3: Subir a GitHub

```bash
git status
# Debería mostrar que web-recovery está en un nuevo lugar

git add .
git commit -m "Move web-recovery to repository root for Railway deployment"
git push origin main
```

### Paso 4: Railway redeploy

1. Ve a https://railway.app/dashboard
2. Abre tu proyecto
3. Click en **"Deployments"**
4. En el deployment fallido, click en **"Redeploy"**
5. Cambia Root Directory a: `web-recovery` (o `app_pedidos/web-recovery` si eso es correcto)
6. Click en **Deploy**

---

## 📋 VERIFICACIÓN

**En tu PC, para verificar dónde está web-recovery:**

```bash
# Desde la raíz del repo (donde está .git/)
find . -name "web-recovery" -type d

# Si ves:
# ./web-recovery           ← ✅ Bien
# ./app_pedidos/web-recovery  ← ❌ Necesita moverse
```

---

## 🔧 SI ESTÁ EN app_pedidos/

**Estructura actual:**

```
app_pedidos/
├── web-recovery/
│   ├── server.js
│   ├── package.json
│   └── ...
└── lib/
```

**En Railway, usa:**

```
Root Directory: app_pedidos/web-recovery
```

---

## 🎯 CHECKLIST

```
☐ Verificaste en GitHub dónde está web-recovery/
☐ Si está en app_pedidos/, moviste a raíz:
  git mv app_pedidos/web-recovery .
  git push origin main
☐ En Railway, configuraste Root Directory correctamente
☐ Hiciste Redeploy en Railway
☐ Esperas a que diga "✅ Deployment Successful"
```

---

## ⚡ COMANDO RÁPIDO

Para mover web-recovery a la raíz y subirlo:

```bash
cd /path/to/app_pedidos  # Tu repo local
git mv app_pedidos/web-recovery .
git commit -m "Move web-recovery to root for Railway"
git push origin main
```

Luego en Railway:

- Root Directory: `web-recovery`
- Redeploy

---

## 📞 REFERENCIAS

- Documentación Railway: https://docs.railway.app
- Root Directory docs: https://docs.railway.app/deploy/your-project

---

**El error se soluciona moviendo web-recovery a la raíz del repo o configurando correctamente el Root Directory en Railway.** 🚂
