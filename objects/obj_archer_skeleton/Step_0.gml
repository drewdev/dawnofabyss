/// @description State machine logic for archer skeleton

var distance_to_player = point_distance(x, y, obj_player.x, obj_player.y);
// Apply knockback if active
if (knockback) {
    var new_x = x + lengthdir_x(knockback_speed, knockback_direction);
    var new_y = y + lengthdir_y(knockback_speed, knockback_direction);

    // Check for collisions during knockback
    if (!scr_check_collision(new_x, y)) {
        x = new_x;
    }
    if (!scr_check_collision(x, new_y)) {
        y = new_y;
    }

    // Decrease knockback timer
    knockback_timer -= 1;
    if (knockback_timer <= 0) {
        knockback = false;
        if (hp <= 0) {
            state = State.Dead;
            sprite_index = spr_archer_skeleton_dead;
            image_speed = 1;
            image_index = 0; // Reset animation
        } else if (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) < vision_range) {
            state = State.Chase; // Return to Chase state if the player is within vision range
            sprite_index = spr_archer_skeleton_walk;
            image_speed = 1;
            move_speed = 4; // Reset speed
            path_end();
        } else {
            state = State.Idle; // Otherwise, return to Idle state
            sprite_index = spr_archer_skeleton_idle;
            image_speed = 1;
        }
    }
} else {
    // Update the state
    switch (state) {
        case State.Idle:
            if (hp <= 0) {
                state = State.Dead;
                sprite_index = spr_archer_skeleton_dead;
                image_speed = 1;
                image_index = 0; // Reset animation
                break;
            }

            idle_time -= 1;
            if (idle_time <= 0) {
                state = State.Walk;
                sprite_index = spr_archer_skeleton_walk;
                image_speed = 1;
                idle_time = irandom_range(60, 90); // Random idle time
            }
            break;
            
        case State.Walk:
            if (hp <= 0) {
                state = State.Dead;
                sprite_index = spr_archer_skeleton_dead;
                image_speed = 1;
                image_index = 0; // Reset animation
                break;
            }

            // Move in the current direction
            var new_x = x + lengthdir_x(move_speed, direction);
            var new_y = y + lengthdir_y(move_speed, direction);

            // Check for collisions
            if (!scr_check_collision(new_x, y)) {
                x = new_x;
            } else {
                direction = irandom_range(0, 359);
            }
            if (!scr_check_collision(x, new_y)) {
                y = new_y;
            } else {
                direction = irandom_range(0, 359);
            }

            // Check for player in vision range
            if (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) < vision_range) {
                state = State.Chase;
                sprite_index = spr_archer_skeleton_walk;
                image_speed = 1;
                move_speed = 4; // Reset speed
                path_end();
            }

            // Randomly switch to idle state
            if (irandom_range(0, 100) < 1) {
                state = State.Idle;
                sprite_index = spr_archer_skeleton_idle;
                image_speed = 1;
                idle_time = irandom_range(60, 120);
            }
            break;
            
        case State.Chase:
            if (hp <= 0) {
                state = State.Dead;
                sprite_index = spr_archer_skeleton_dead;
                image_speed = 1;
                image_index = 0; // Reset animation
                break;
            }

            if (instance_exists(obj_player)) {

                if (distance_to_player > attack_range) {
                    // Pathfinding logic
                    if (path != noone) {
                        path_delete(path);
                    }
                    path = path_add();
                    
                    if (mp_grid_path(global.grid, path, x, y, obj_player.x, obj_player.y, true)) {
                        path_start(path, move_speed, path_action_stop, false);
                    } else {
                        var dx = obj_player.x - x;
                        var dy = obj_player.y - y;
                        var angle = point_direction(x, y, obj_player.x, obj_player.y);
                        var new_x = x + lengthdir_x(move_speed, angle);
                        var new_y = y + lengthdir_y(move_speed, angle);

                        if (!scr_check_collision(new_x, y)) {
                            x = new_x;
                        }
                        if (!scr_check_collision(x, new_y)) {
                            y = new_y;
                        }
                    }
                } else {
                    // Stop moving if within the minimum distance
                    speed = 0;
                }

                // Switch to attack state if close enough
                if (distance_to_player <= attack_range) {
                    state = State.Attack;
                    image_speed = 1;
                    image_index = 0; // Reset animation
                    arrow_spawned = false; // Reset arrow spawned flag
                }

                // Adjust direction and animation scale
                if (obj_player.x > x) {
                    image_xscale = -1;
                } else {
                    image_xscale = 1;
                }
            } else {
                state = State.Idle; // Si no hay jugador, cambiar a estado Idle
                sprite_index = spr_archer_skeleton_idle;
                image_speed = 1;
            }
            break;
            
        case State.Attack:
            sprite_index = spr_archer_skeleton_attack;
            if (hp <= 0) {
                state = State.Dead;
                sprite_index = spr_archer_skeleton_dead;
                image_speed = 1;
                image_index = 0; // Reset animation
                break;
            }

            // Stop all movement while attacking
            path_end();

            // Generate arrow at frame 19
            if (image_index > 18 && image_index < 24 && !arrow_spawned) {
                var arrow = instance_create_layer(x, y-115, "Instances", obj_arrow);
                var direction_to_player = point_direction(x, y, obj_player.x, obj_player.y);
                arrow.direction = direction_to_player;
                arrow.speed = 7; // Set the speed of the arrow
                arrow_spawned = true; // Set flag to true to prevent multiple arrows
            }

            // Return to retreat state after attacking
            if (image_index >= sprite_get_number(sprite_index) - 1) {
                state = State.Retreat;
                sprite_index = spr_archer_skeleton_walk;
                move_speed = 4; // Reset speed
                path_end();
            }
            break;
        case State.Retreat:
            if (hp <= 0) {
                state = State.Dead;
                sprite_index = spr_archer_skeleton_dead;
                image_speed = 1;
                image_index = 0; // Reset animation
                break;
            }	

            if (instance_exists(obj_player)) {
                var distance_to_player = point_distance(x, y, obj_player.x, obj_player.y);

                // Si la distancia es suficiente o encuentra una colisión, pasar a Attack
                if (distance_to_player >= attack_range || scr_check_collision(x, y)) {
					arrow_spawned = false;
                    state = State.Attack;
                    sprite_index = spr_archer_skeleton_attack;
                    image_speed = 1;
                    image_index = 0; // Reset animation
                } else {
                    var angle = point_direction(obj_player.x, obj_player.y, x, y);
                    var new_x = x + lengthdir_x(move_speed, angle);
                    var new_y = y + lengthdir_y(move_speed, angle);

                    // Check for collisions
                    if (!scr_check_collision(new_x, y)) {
                        x = new_x;
                    }
                    if (!scr_check_collision(x, new_y)) {
                        y = new_y;
                    }
                }

                // Adjust direction and animation scale
                if (obj_player.x > x) {
                    image_xscale = -1;
                } else {
                    image_xscale = 1;
                }
            } else {
                state = State.Idle; // Si no hay jugador, cambiar a estado Idle
                sprite_index = spr_archer_skeleton_idle;
                image_speed = 1;
            }
            break;
        case State.Hit:
            if (hp <= 0) {
                state = State.Dead;
                sprite_index = spr_archer_skeleton_dead;
                image_speed = 1;
                image_index = 0; // Reset animation
                break;
            }

            // Ensure the path is stopped when hit
            path_end();
            speed = 0;
            move_speed = 0;
            
            // Cambiar a estado "chase" después de la animación de golpe si el jugador está dentro del rango de visión
            if (sprite_index == spr_archer_skeleton_hit && image_index >= sprite_get_number(sprite_index) - 1) {
                if (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) < vision_range) {
                    state = State.Chase;
                    sprite_index = spr_archer_skeleton_walk;
                    image_speed = 1;
                    move_speed = 4; // Reset speed
                    path_end();
                } else {
                    state = State.Idle;
                    sprite_index = spr_archer_skeleton_idle;
                    image_speed = 1;
                }
            }
            break;
            
        case State.Dead:
            // Ensure no movement in dead state
            path_end();
            speed = 0;
            move_speed = 0;
            if (image_index >= sprite_get_number(sprite_index) - 1) {
                image_speed = 0;
            }
            // The skeleton is dead, do nothing
            break;
    }
}

// Decrease invulnerability timer
if (invulnerability_timer > 0) {
    invulnerability_timer -= 1;
}

// Check for player attacks only if not invulnerable and not dead
if (hp > 0 && invulnerability_timer <= 0 && place_meeting(x, y, obj_player) && obj_player.attacking) {
    
    state = State.Hit;
    sprite_index = spr_archer_skeleton_hit;
    image_speed = 1;
    image_index = 0; // Reset animation

    // Ensure the path is stopped when hit
    path_end();
    speed = 0;
    move_speed = 0;

    // Aplicar retroceso al recibir un golpe
    knockback = true;
    knockback_timer = knockback_duration;
    knockback_direction = point_direction(obj_player.x, obj_player.y, x, y);

    // Set invulnerability timer to avoid multiple hits
    invulnerability_timer = 50; // Adjust this value as needed

    var damage = irandom_range(obj_player.minAttack, obj_player.maxAttack);
    hp -= damage; // Decrease health
    var dmg = instance_create_layer(x, y, "Instances", obj_damage_display);
    dmg.damage_value = damage; // Ajusta este valor al daño recibido
    if (damage == obj_player.maxAttack) {
        dmg.draw_color = c_yellow;
    } else {
        dmg.draw_color = c_white;
    }
    // Iniciar screen shake
    global.shake_timer = 5; // Duración del screen shake
}

// Adjust the direction and animation scale for walking and idle states
if (state == State.Walk || state == State.Idle) {
    if (direction > 90 && direction < 270) {
        image_xscale = 1;
    } else {
        image_xscale = -1;
    }
}
