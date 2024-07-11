// En el evento Step del obj_darkness

// Ajustar la posición del objeto para que siga al personaje
if (instance_exists(obj_player)) {
    x = obj_player.x;
    y = obj_player.y;
}

// Verificar si se presiona la tecla Espacio
if (keyboard_check_pressed(vk_space)) {
    target_scale *= 1.3; // Aumentar la escala objetivo en un 10%
}

// Verificar si se presiona la tecla Alt
if (keyboard_check_pressed(vk_alt)) {
    target_scale = 1; // Volver al tamaño original
}

// Interpolación suave hacia la escala objetivo
var scale_speed = 0.05; // Velocidad de transición (ajusta este valor según sea necesario)
image_xscale = lerp(image_xscale, target_scale, scale_speed);
image_yscale = lerp(image_yscale, target_scale, scale_speed);
