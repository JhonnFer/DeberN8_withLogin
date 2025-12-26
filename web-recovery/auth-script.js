// ========================================
// CONFIGURACIÓN SUPABASE
// ========================================

const SUPABASE_URL = "https://prnijxtfspduxanobawa.supabase.co";
const SUPABASE_ANON_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBybmlqeHRmc3BkdXhhbm9iYXdhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY3MjIwNTIsImV4cCI6MjA4MjI5ODA1Mn0.kIvzqYTeEOieb8ARM24u8mWoJirr0kXvnvDiQR8pzk4";

const REDIRECT_BASE_URL =
  window.location.origin +
  window.location.pathname.split(/reset-password\.html|index\.html/)[0];

console.log("🔐 REDIRECT_BASE_URL:", REDIRECT_BASE_URL);

// Inicializar cliente Supabase
const { createClient } = window.supabase;
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// ========================================
// ELEMENTOS DEL DOM
// ========================================

const validatingState = document.getElementById("validating");
const resetFormState = document.getElementById("resetForm");
const setPasswordFormState = document.getElementById("setPasswordForm");
const sendingState = document.getElementById("sending");
const successState = document.getElementById("success");
const errorState = document.getElementById("error");
const invalidTokenState = document.getElementById("invalidToken");

const resetPasswordForm = document.getElementById("resetPasswordForm");
const setPasswordForm = document.getElementById("setPasswordFormElement");

// ========================================
// VARIABLES GLOBALES
// ========================================

let currentUser = null;
let currentToken = null;
let tokenType = null; // 'recovery' o 'signup'

// ========================================
// INICIALIZACIÓN
// ========================================

async function init() {
  console.log("🚀 Inicializando...");

  try {
    // Validar sesión actual
    const {
      data: { session },
      error: sessionError,
    } = await supabase.auth.getSession();

    if (sessionError) {
      console.error("❌ Error obteniendo sesión:", sessionError);
      showState("invalidToken");
      return;
    }

    // Si hay sesión activa
    if (session) {
      currentUser = session.user;
      console.log("✅ Usuario con sesión activa:", currentUser.email);
      showState("setPasswordForm");
      return;
    }

    // Verificar tokens en URL
    const urlParams = new URLSearchParams(window.location.hash.slice(1));
    const accessToken = urlParams.get("access_token");
    const type = urlParams.get("type");

    if (!accessToken) {
      console.warn("⚠️ No hay token en la URL");
      showState("invalidToken");
      return;
    }

    currentToken = accessToken;
    tokenType = type; // 'recovery' o 'signup'

    console.log("🔑 Token encontrado:", {
      type: type,
      tokenLength: accessToken.length,
    });

    // Setear sesión con el token
    const { data, error } = await supabase.auth.setSession({
      access_token: accessToken,
      refresh_token: "", // No es necesario para solo leer usuario
    });

    if (error) {
      console.error("❌ Error estableciendo sesión:", error);
      showState("invalidToken");
      return;
    }

    // Obtener usuario actual
    const { data: userData, error: userError } = await supabase.auth.getUser(
      accessToken
    );

    if (userError) {
      console.error("❌ Error obteniendo usuario:", userError);
      showState("invalidToken");
      return;
    }

    currentUser = userData.user;
    console.log("✅ Token válido para usuario:", currentUser.email);

    // Mostrar formulario apropiado según el tipo de token
    if (type === "recovery") {
      console.log("📧 Token de RECUPERACIÓN - mostrar formulario de reset");
      showState("resetForm");
    } else if (type === "signup") {
      console.log("📝 Token de REGISTRO - mostrar formulario de confirmación");
      showState("setPasswordForm");
    } else {
      console.log("❓ Tipo de token desconocido:", type);
      showState("resetForm");
    }
  } catch (error) {
    console.error("💥 Error en init():", error);
    showState("error");
  }
}

// ========================================
// FUNCIONES DE UI
// ========================================

function showState(state) {
  const states = [
    "validating",
    "resetForm",
    "setPasswordForm",
    "sending",
    "success",
    "error",
    "invalidToken",
  ];

  states.forEach((s) => {
    const el = document.getElementById(s);
    if (el) {
      el.classList.remove("active");
    }
  });

  const targetState = document.getElementById(state);
  if (targetState) {
    targetState.classList.add("active");
  }

  console.log("🎨 Estado actual:", state);
}

function togglePasswordVisibility(inputId) {
  const input = document.getElementById(inputId);
  if (input.type === "password") {
    input.type = "text";
  } else {
    input.type = "password";
  }
}

function clearErrors() {
  document.querySelectorAll(".error-text").forEach((el) => {
    el.textContent = "";
    el.style.display = "none";
  });
}

function showError(elementId, message) {
  const el = document.getElementById(elementId);
  if (el) {
    el.textContent = message;
    el.style.display = "block";
  }
}

function reloadPage() {
  window.location.reload();
}

function closeWindow() {
  window.close();
}

// ========================================
// VALIDACIÓN
// ========================================

function validatePassword(password) {
  if (!password || password.length < 6) {
    return "La contraseña debe tener al menos 6 caracteres";
  }
  return null;
}

function validatePasswordMatch(password, confirm) {
  if (password !== confirm) {
    return "Las contraseñas no coinciden";
  }
  return null;
}

// ========================================
// RESET DE CONTRASEÑA
// ========================================

async function handleResetPassword(event) {
  event.preventDefault();
  clearErrors();

  const newPassword = document.getElementById("newPassword").value;
  const confirmPassword = document.getElementById("confirmPassword").value;

  console.log("🔐 Intentando resetear contraseña...");

  // Validar
  let passwordError = validatePassword(newPassword);
  if (passwordError) {
    showError("passwordError", passwordError);
    return;
  }

  let matchError = validatePasswordMatch(newPassword, confirmPassword);
  if (matchError) {
    showError("passwordError", matchError);
    return;
  }

  showState("sending");
  document.getElementById("sendingText").textContent =
    "Actualizando tu contraseña...";

  try {
    // Actualizar contraseña en Supabase
    const { data, error } = await supabase.auth.updateUser({
      password: newPassword,
    });

    if (error) {
      console.error("❌ Error actualizando contraseña:", error);
      showState("error");
      document.getElementById("errorMessage").textContent =
        error.message || "Error al actualizar la contraseña";
      return;
    }

    console.log("✅ Contraseña actualizada exitosamente");
    showState("success");

    // Auto-close después de 3 segundos
    setTimeout(() => {
      closeWindow();
    }, 3000);
  } catch (error) {
    console.error("💥 Error:", error);
    showState("error");
    document.getElementById("errorMessage").textContent =
      error.message || "Error desconocido";
  }
}

// ========================================
// CONFIRMAR CONTRASEÑA (NUEVO USUARIO)
// ========================================

async function handleSetPassword(event) {
  event.preventDefault();
  clearErrors();

  const password = document.getElementById("setupPassword").value;
  const confirmPassword = document.getElementById("setupConfirmPassword").value;

  console.log("✍️ Intentando confirmar contraseña de nuevo usuario...");

  // Validar
  let passwordError = validatePassword(password);
  if (passwordError) {
    showError("setupPasswordError", passwordError);
    return;
  }

  let matchError = validatePasswordMatch(password, confirmPassword);
  if (matchError) {
    showError("setupConfirmError", matchError);
    return;
  }

  showState("sending");
  document.getElementById("sendingText").textContent =
    "Confirmando tu contraseña...";

  try {
    // Actualizar contraseña en Supabase
    const { data, error } = await supabase.auth.updateUser({
      password: password,
    });

    if (error) {
      console.error("❌ Error confirmando contraseña:", error);
      showState("error");
      document.getElementById("errorMessage").textContent =
        error.message || "Error al confirmar la contraseña";
      return;
    }

    console.log("✅ Contraseña confirmada exitosamente");
    showState("success");

    // Auto-close después de 3 segundos
    setTimeout(() => {
      closeWindow();
    }, 3000);
  } catch (error) {
    console.error("💥 Error:", error);
    showState("error");
    document.getElementById("errorMessage").textContent =
      error.message || "Error desconocido";
  }
}

// ========================================
// EVENT LISTENERS
// ========================================

if (resetPasswordForm) {
  resetPasswordForm.addEventListener("submit", handleResetPassword);
}

if (setPasswordForm) {
  setPasswordForm.addEventListener("submit", handleSetPassword);
}

// Limpiar errores mientras escribe
document.addEventListener("input", clearErrors);

// ========================================
// INICIAR
// ========================================

// Esperar a que Supabase esté listo
window.addEventListener("load", init);

// O iniciar directamente si el DOM ya está listo
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", init);
} else {
  init();
}

console.log("✅ Script cargado correctamente");
