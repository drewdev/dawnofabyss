/// @description Move player towards mouse click

// Definir las direcciones
var dir_right = 0;
var dir_left = 180;

// Velocidad de movimiento
var move_speed = 7;

// Verificar si se ha hecho clic en el ratón
if (mouse_check_button_released(mb_left)) {
    target_x = mouse_x;
    target_y = mouse_y;
    if (instance_exists(global.new_target)) {
        instance_destroy(global.new_target); // Destruir el objetivo anterior
    }
    global.new_target = instance_create_layer(target_x, target_y, "Instances", obj_target);
    target_set = true;
}

// Si hay un objetivo establecido, mover al personaje hacia esa posición
if (target_set) {
    // Calcular la dirección hacia el objetivo
    var dx = target_x - x;
    var dy = target_y - y;
    var distance = point_distance(x, y, target_x, target_y);

    // Mover al personaje
    if (distance > move_speed) {
        var angle = point_direction(x, y, target_x, target_y);
        var new_x = x + lengthdir_x(move_speed, angle);
        var new_y = y + lengthdir_y(move_speed, angle);

        // Verificar colisiones antes de actualizar la posición
        if (!scr_check_collision(new_x, y)) {
            x = new_x;
        }
        if (!scr_check_collision(x, new_y)) {
            y = new_y;
        }
    } else {
        // Si el personaje ha alcanzado el objetivo, detener el movimiento y destruir el objetivo
        x = target_x;
        y = target_y;
        target_set = false;
        if (instance_exists(global.new_target)) {
            instance_destroy(global.new_target); // Destruir el objetivo cuando se alcanza
        }
    }

    // Ajustar la dirección y la animación
    if (dx > 0) {
        direction = dir_right;
        sprite_index = spr_player_walk;
        image_xscale = 1; // Mirar a la derecha
    } else {
        direction = dir_left;
        sprite_index = spr_player_walk;
        image_xscale = -1; // Mirar a la izquierda
    }
    
    // Reproducir la animación de caminar
    image_speed = 1;
}

// Si no hay un objetivo, detener la animación y cambiar a idle
if (!target_set) {
    image_speed = 0;
    image_index = 0; // Resetear la animación al primer frame
    sprite_index = spr_player_idle; // Sprite idle para cuando el jugador no se mueve
}

if (global.clicked_exit && place_meeting(x, y, obj_scenary_exit)) {
    if (!instance_exists(obj_fade)) {
        instance_create_layer(x, y, "Instances", obj_fade);
    }
    global.clicked_exit = false;
}
