/* global Swal */

/**
 * Utilidades para SweetAlert2 con soporte para tema claro/oscuro
 */

// Función para crear una alerta de éxito con el tema actual
function showSuccessAlert(title, text, buttonColor = '#28a745') {
    const theme = localStorage.getItem('theme') || 'light';
    const isDark = theme === 'dark';
    
    return Swal.fire({
        icon: 'success',
        title: title,
        text: text,
        confirmButtonColor: buttonColor,
        background: isDark ? '#333' : '#fff',
        color: isDark ? '#fff' : '#545454'
    });
}

// Función para crear una alerta de error con el tema actual
function showErrorAlert(title, text, buttonColor = '#dc3545') {
    const theme = localStorage.getItem('theme') || 'light';
    const isDark = theme === 'dark';
    
    return Swal.fire({
        icon: 'error',
        title: title,
        text: text,
        confirmButtonColor: buttonColor,
        background: isDark ? '#333' : '#fff',
        color: isDark ? '#fff' : '#545454'
    });
}

// Función para crear una alerta de información con el tema actual
function showInfoAlert(title, text, buttonColor = '#17a2b8') {
    const theme = localStorage.getItem('theme') || 'light';
    const isDark = theme === 'dark';
    
    return Swal.fire({
        icon: 'info',
        title: title,
        text: text,
        confirmButtonColor: buttonColor,
        background: isDark ? '#333' : '#fff',
        color: isDark ? '#fff' : '#545454'
    });
}

// Función para crear una alerta de advertencia con el tema actual
function showWarningAlert(title, text, buttonColor = '#ffc107') {
    const theme = localStorage.getItem('theme') || 'light';
    const isDark = theme === 'dark';
    
    return Swal.fire({
        icon: 'warning',
        title: title,
        text: text,
        confirmButtonColor: buttonColor,
        background: isDark ? '#333' : '#fff',
        color: isDark ? '#fff' : '#545454'
    });
}

// Función para crear una alerta de confirmación con el tema actual
function showConfirmAlert(title, text, confirmButtonText = 'Sí', cancelButtonText = 'No', confirmButtonColor = '#28a745', cancelButtonColor = '#dc3545') {
    const theme = localStorage.getItem('theme') || 'light';
    const isDark = theme === 'dark';
    
    return Swal.fire({
        icon: 'question',
        title: title,
        text: text,
        showCancelButton: true,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
        confirmButtonColor: confirmButtonColor,
        cancelButtonColor: cancelButtonColor,
        background: isDark ? '#333' : '#fff',
        color: isDark ? '#fff' : '#545454'
    });
} 