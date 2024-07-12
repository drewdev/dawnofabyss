/// @description State machine logic

// Update the state
switch (state) {
    case State.Idle:
        idle_time -= 1;
        if (idle_time <= 0) {
            state = State.Walk;
            sprite_index = spr_skeleton_warrior_walk;
            image_speed = 1;
            idle_time = irandom_range(60, 120); // Random idle time
        }
        break;
        
    case State.Walk:
        // Move in the current direction
        var new_x = x + lengthdir_x(move_speed, direction);
        var new_y = y + lengthdir_y(move_speed, direction);

        // Check for collisions
        if (!scr_check_collision(new_x, y)) {
            x = new_x;
        }
        if (!scr_check_collision(x, new_y)) {
            y = new_y;
        }
        
        // Change direction occasionally
        if (irandom_range(0, 100) < 2) {
            direction = irandom_range(0, 359);
        }

        // Check for player in vision range
        if (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) < vision_range) {
            state = State.Chase;
            sprite_index = spr_skeleton_warrior_walk;
            image_speed = 1;
        }

        // Randomly switch to idle state
        if (irandom_range(0, 100) < 1) {
            state = State.Idle;
            sprite_index = spr_skeleton_warrior_idle;
            image_speed = 1;
            idle_time = irandom_range(60, 120);
        }
        break;
        
     case State.Chase:
        // Verificar si el path existe antes de eliminarlo
        if (path != noone) {
            path_delete(path);
        }
        path = path_add();
        
        // Recalcular la ruta solo si es necesario
        if (mp_grid_path(global.grid, path, x, y, obj_player.x, obj_player.y, true)) {
            path_start(path, move_speed, path_action_stop, false);
        } else {
            // Intentar moverse en línea recta si no se puede calcular una ruta
            var dx = obj_player.x - x;
            var dy = obj_player.y - y;
            var angle = point_direction(x, y, obj_player.x, obj_player.y);
            var new_x = x + lengthdir_x(move_speed, angle);
            var new_y = y + lengthdir_y(move_speed, angle);

            // Verificar colisiones
            if (!scr_check_collision(new_x, y)) {
                x = new_x;
            }
            if (!scr_check_collision(x, new_y)) {
                y = new_y;
            }
        }

        // Si está lo suficientemente cerca, cambiar al estado de ataque
        if (point_distance(x, y, obj_player.x, obj_player.y) < attack_range) {
            state = State.Attack;
            sprite_index = spr_skeleton_warrior_attack;
            image_speed = 1;
            image_index = 0; // Resetear animación
        }

        // Ajustar la dirección y la escala de la animación
        if (obj_player.x > x) {
            // Mirar a la derecha
            image_xscale = -1;
        } else {
            // Mirar a la izquierda
            image_xscale = 1;
        }
        break;
        
    case State.Attack:
        // If the attack animation is finished, go back to idle or chase state
        if (image_index >= sprite_get_number(sprite_index) - 1) {
            if (point_distance(x, y, obj_player.x, obj_player.y) < attack_range) {
                state = State.Idle;
                sprite_index = spr_skeleton_warrior_idle;
            } else {
                state = State.Chase;
                sprite_index = spr_skeleton_warrior_walk;
            }
        }
        break;
        
    case State.Hit:
        // If the hit animation is finished, go back to idle or chase state
        if (image_index >= sprite_get_number(sprite_index) - 1) {
            if (hp <= 0) {
                state = State.Dead;
                sprite_index = spr_skeleton_warrior_dead;
                image_speed = 1;
                image_index = 0; // Reset animation
            } else {
                state = State.Idle;
                sprite_index = spr_skeleton_warrior_idle;
            }
        }
        break;
        
    case State.Dead:
		if (image_index >= sprite_get_number(spr_skeleton_warrior_dead) - 1) {
			image_speed = 0;
		}
        // The skeleton is dead, do nothing
        break;
}

// Check for player attacks
if (place_meeting(x, y, obj_player) && obj_player.attacking) {
    hp -= 10; // Decrease health
    state = State.Hit;
    sprite_index = spr_skeleton_warrior_hit;
    image_speed = 1;
    image_index = 0; // Reset animation
}

// Adjust the direction and animation scale for walking and idle states
if (state == State.Walk || state == State.Idle) {
    if (direction > 90 && direction < 270) {
        // Facing left
        image_xscale = 1;
    } else {
        // Facing right
        image_xscale = -1;
    }
}
