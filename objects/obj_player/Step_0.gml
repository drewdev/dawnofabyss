// Evento Step del obj_player

/// @description Move player towards mouse click

// Definir las direcciones
var dir_right = 0;
var dir_left = 180;

// Velocidad de movimiento
var move_speed = 6;
var deceleration_distance = 150; // Distancia a la que empieza a desacelerar
var min_speed = 1; // Velocidad mínima para desacelerar

// Verificar si se ha hecho clic en el ratón, solo si no está atacando
if (!attacking && mouse_check_button_released(mb_left)) {
    target_x = mouse_x;
    target_y = mouse_y;
    if (instance_exists(global.new_target)) {
        instance_destroy(global.new_target); // Destruir el objetivo anterior
    }
    global.new_target = instance_create_layer(target_x, target_y, "Instances", obj_target);
    target_set = true;
    
    // Calcular la ruta hacia el objetivo
    if (path != noone) {
        path_delete(path);
    }
    path = path_add();
    if (mp_grid_path(global.grid, path, x, y, target_x, target_y, true)) {
        path_start(path, move_speed, path_action_stop, false);
    } else {
        path_delete(path);
        path = noone;
    }
}

// Si hay un objetivo establecido y no está atacando, mover al personaje hacia esa posición
if (target_set && !attacking) {
    // Verificar colisiones y mover al personaje a lo largo del path
    if (path != noone && path_position != 1) {
        var distance_to_target = point_distance(x, y, target_x, target_y);
        
        // Desacelerar si está cerca del objetivo
        var current_speed = move_speed;
        if (distance_to_target < deceleration_distance) {
            current_speed = max(min_speed, move_speed * (distance_to_target / deceleration_distance));
        }

        var dir = point_direction(x, y, path_get_point_x(path, path_position), path_get_point_y(path, path_position));
        var new_x = x + lengthdir_x(current_speed, dir);
        var new_y = y + lengthdir_y(current_speed, dir);

        // Verificar colisiones
        if (!scr_check_collision(new_x, y)) {
            x = new_x;
        }
        if (!scr_check_collision(x, new_y)) {
            y = new_y;
        }

        // Ajustar la dirección y la animación mientras se mueve
        if (dir > 90 && dir < 270) {
            last_direction = dir_left; // Actualizar la última dirección
            image_xscale = 1; // Mirar a la izquierda
        } else {
            last_direction = dir_right; // Actualizar la última dirección
            image_xscale = -1; // Mirar a la derecha
        }

        // Reproducir la animación de caminar mientras se mueve
        if (sprite_index != spr_player_attack) {
            sprite_index = spr_player_walk;
            image_speed = 1;
        }

        // Verificar si el personaje está cerca del objetivo (10 píxeles de distancia)
        if (distance_to_target <= 10) {
            target_set = false;
            if (instance_exists(global.new_target)) {
                instance_destroy(global.new_target); // Destruir el objetivo cuando se alcanza
            }
            if (path != noone) {
                path_end();
                path_delete(path);
                path = noone;
            }
        }
    } else {
        // Si el personaje ha alcanzado el objetivo, detener el movimiento y destruir el objetivo
        target_set = false;
        if (instance_exists(global.new_target)) {
            instance_destroy(global.new_target); // Destruir el objetivo cuando se alcanza
        }
        if (path != noone) {
            path_end();
            path_delete(path);
            path = noone;
        }
    }
}

// Si no hay un objetivo, detener la animación y cambiar a idle, solo si no está atacando
if (!target_set && !attacking) {
    if (sprite_index != spr_player_attack) {
        image_speed = 0;
        image_index = 0; // Resetear la animación al primer frame
        sprite_index = spr_player_idle; // Sprite idle para cuando el jugador no se mueve
        // Mantener la dirección al quedar en idle
        if (last_direction == dir_right) {
            image_xscale = -1;
        } else {
            image_xscale = 1;
        }
    }
}

if (global.clicked_exit && place_meeting(x, y, obj_scenary_exit)) {
    if (!instance_exists(obj_fade)) {
        instance_create_layer(x, y, "Instances", obj_fade);
    }
    global.clicked_exit = false;
}

// Detectar ataque
if (keyboard_check_pressed(ord("D")) && !attacking) {
    attacking = true;
    sprite_index = spr_player_attack;
    image_index = 0;
    image_speed = 1;
    target_set = false;
    if (instance_exists(global.new_target)) {
        instance_destroy(global.new_target); // Destruir el objetivo cuando se alcanza
    }
    if (path != noone) {
        path_end();
        path_delete(path);
        path = noone;
    }
}

// Volver al sprite idle después de atacar
if (attacking && sprite_index == spr_player_attack && image_index >= sprite_get_number(spr_player_attack) - 1) {
    attacking = false;
    
    sprite_index = spr_player_idle;
    image_speed = 0;
    image_index = 0;
    // Mantener la dirección al quedar en idle
    if (last_direction == dir_right) {
        image_xscale = -1;
    } else {
        image_xscale = 1;
    }
}
