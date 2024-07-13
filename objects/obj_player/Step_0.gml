/// @description Move player towards mouse click

// Definir las direcciones
var dir_right = 0;
var dir_left = 180;

// Velocidad de movimiento
var move_speed = 6;
var deceleration_distance = 150; // Distancia a la que empieza a desacelerar
var min_speed = 1; // Velocidad mínima para desacelerar

// Verificar si el jugador está muerto
if (hp <= 0) {
    // Manejar la muerte del jugador aquí, por ejemplo, cambiar a un sprite de muerte, detener el movimiento, etc.
    sprite_index = spr_player_dead;
    return; // Salir del evento step para que el jugador no realice ninguna acción más
}

// Disminuir temporizadores
if (invulnerability_timer > 0) {
    invulnerability_timer -= 1;
}
if (attack_cooldown > 0) {
    attack_cooldown -= 1;
}

// Aplicar knockback si está activo
if (knockback) {
    var new_x = x + lengthdir_x(knockback_speed, knockback_direction);
    var new_y = y + lengthdir_y(knockback_speed, knockback_direction);

    // Verificar colisiones durante el knockback
    if (!scr_check_collision(new_x, y)) {
        x = new_x;
    }
    if (!scr_check_collision(x, new_y)) {
        y = new_y;
    }

    // Disminuir el temporizador de knockback
    knockback_timer -= 1;
    if (knockback_timer <= 0) {
        knockback = false;
    }
}

// Verificar ataques de enemigos y aplicar knockback al jugador
if (!knockback && invulnerability_timer <= 0) {
    var enemy = instance_place(x, y, obj_skeleton_warrior); // Verifica colisión con enemigos
    if (hp > 0 && enemy && enemy.state == State.Attack) {
        hp -= 10; // Ajusta el valor de daño según sea necesario
        sprite_index = spr_player_hit;
        image_speed = 1;
        image_index = 0; // Restablece la animación
        invulnerability_timer = 30; // Ajusta el tiempo de invulnerabilidad

        // Aplicar knockback al jugador
        knockback = true;
        knockback_timer = 10; // Duración del knockback
        knockback_direction = point_direction(enemy.x, enemy.y, x, y);

        // Detener el movimiento y los ataques
        target_set = false;
        if (path != noone) {
            path_end();
            path_delete(path);
            path = noone;
        }
        attacking = false;
		var dmg = instance_create_layer(x, y, "Instances", obj_damage_display);
		dmg.damage_value = 10; // Ajusta este valor al daño recibido
		dmg.draw_color = c_red;
        // Iniciar screen shake
        global.shake_timer = 10; // Duración del screen shake (ajusta según sea necesario)
    }
}

// Verificar si se ha hecho clic en el ratón, solo si no está atacando ni en knockback
if (!knockback && !attacking && mouse_check_button_released(mb_left)) {
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

// Si hay un objetivo establecido y no está en knockback ni en animación hit, mover al personaje hacia esa posición
if (target_set && !knockback && sprite_index != spr_player_hit && !attacking) {
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
        sprite_index = spr_player_walk;
        image_speed = 1;

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

// Si no hay un objetivo, detener la animación y cambiar a idle, solo si no está atacando ni en knockback
if (!target_set && !knockback && !attacking && sprite_index != spr_player_hit) {
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

// Detectar ataque
if (keyboard_check_pressed(ord("D")) && attack_cooldown <= 0 && !knockback) {
    attacking = true;
    sprite_index = spr_player_attack;
    image_index = 0;
    image_speed = 1;
    attack_cooldown = 30; // Ajusta el tiempo de enfriamiento del ataque
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

// Registrar el ataque solo durante la animación de ataque
if (attacking && sprite_index == spr_player_attack && image_index >= sprite_get_number(sprite_index) / 2 && image_index < sprite_get_number(sprite_index) - 1) {
    var enemy = instance_place(x, y, obj_skeleton_warrior); // Detectar colisiones con enemigos
    if (enemy != noone) {
        with (enemy) {
            if (invulnerability_timer <= 0 && state != State.Dead) {
                hp -= 10; // Ajustar el valor de daño según sea necesario
                state = State.Hit;
                sprite_index = spr_skeleton_warrior_hit;
                image_speed = 1;
                image_index = 0; // Restablecer la animación

                // Aplicar retroceso al enemigo
                knockback = true;
                knockback_timer = knockback_duration;
                knockback_direction = point_direction(other.x, other.y, x, y);

                // Establecer invulnerabilidad para evitar múltiples golpes instantáneos
                invulnerability_timer = 30; // Ajusta el valor según sea necesario
                // Iniciar screen shake
                global.shake_timer = 5; // Duración del screen shake (ajusta según sea necesario)
            }
        }
    }
}

// Volver al sprite idle después de atacar
if (attacking && sprite_index == spr_player_attack && image_index >= sprite_get_number(spr_player_attack) - 1) {
    attacking = false;
}

// Asegurarse de que se retome la animación adecuada después de knockback y hit
if (!knockback && sprite_index != spr_player_hit) {
    if (target_set && !attacking) {
        sprite_index = spr_player_walk;
        image_speed = 1;
    } else if (!target_set && !attacking) {
        sprite_index = spr_player_idle;
        image_speed = 0;
        image_index = 0; // Resetear la animación al primer frame
        // Mantener la dirección al quedar en idle
        if (last_direction == dir_right) {
            image_xscale = -1;
        } else {
            image_xscale = 1;
        }
    }
}

// Manejar la finalización de la animación de hit
if (sprite_index == spr_player_hit && image_index >= sprite_get_number(sprite_index) - 1) {
    if (target_set) {
        sprite_index = spr_player_walk;
        image_speed = 1;
    } else {
        sprite_index = spr_player_idle;
        image_speed = 0;
        image_index = 0; // Resetear la animación al primer frame
        // Mantener la dirección al quedar en idle
        if (last_direction == dir_right) {
            image_xscale = -1;
        } else {
            image_xscale = 1;
        }
    }
}

// Verificar si el jugador está en la posición del obj_scenary_exit
if (global.clicked_exit && place_meeting(x, y, obj_scenary_exit)) {
    if (!instance_exists(obj_fade)) {
        instance_create_layer(x, y, "Instances", obj_fade);
    }
    global.clicked_exit = false;
}

scr_screen_shake();
show_debug_message(global.shake_timer)