function draw_map() {
    var player_placed = false;
    var new_object_count = 0; // Contador de obj_new_object colocadas
    var max_attempts = 200; // Límite de intentos para evitar bucles infinitos
    var entry_x, entry_y, exit_x, exit_y; // Variables para almacenar las posiciones de entrada y salida
    var entry_room_index = -1, exit_room_index = -1;

    // Primero, dibujar el mapa y colocar los objetos básicos
    for (var map_x = 0; map_x < global.map_width; map_x++) {
        for (var map_y = 0; map_y < global.map_height; map_y++) {
            if (map[# map_x, map_y] == 1) {
                // Dibujar el piso
                instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_floor);
                // Colocar al jugador en la primera posición de piso encontrada
                if (!player_placed) {
                    var player_instance = instance_create_layer(map_x * 256 + 50, map_y * 256 + 300, "Instances", obj_player);
                    player_placed = true;

                    // Crear el objeto de entrada detrás del jugador
                    entry_x = map_x * 256;
                    entry_y = (map_y * 256) + 256; // Ajusta la posición según sea necesario
                    instance_create_layer(entry_x, entry_y, "Instances", obj_scenary_entry);

                    // Almacenar el índice de la habitación de entrada
                    entry_room_index = find_room_index(entry_x / 256, entry_y / 256);
                }
            } else if (map[# map_x, map_y] == 2) {
                // Dibujar la pared
                instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_bottom);
            } else if (is_closed_corner(map_x, map_y)) {
                // Esquinas cerradas
                if (is_floor(map_x - 1, map_y - 1) && is_floor(map_x - 1, map_y) && is_floor(map_x, map_y - 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_corner_topleft);
                } else if (is_floor(map_x + 1, map_y - 1) && is_floor(map_x + 1, map_y) && is_floor(map_x, map_y - 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_corner_topright);
                } else if (is_floor(map_x - 1, map_y + 1) && is_floor(map_x - 1, map_y) && is_floor(map_x, map_y + 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_corner_bottomleft);
                } else if (is_floor(map_x + 1, map_y + 1) && is_floor(map_x + 1, map_y) && is_floor(map_x, map_y + 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_corner_bottomright);
                }
                // Añadir pared superior para esquinas cerradas
                if (is_floor(map_x, map_y - 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_top);
                }
                // Añadir pared inferior para esquinas cerradas
                if (is_floor(map_x, map_y + 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_bottom);
                }
                // Añadir paredes izquierda y derecha para esquinas cerradas
                if (is_floor(map_x - 1, map_y)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_left);
                }
                if (is_floor(map_x + 1, map_y)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_right);
                }
                // Añadir pared superior adicional entre las esquinas cerradas y las paredes adyacentes
                if (!is_floor(map_x - 1, map_y - 1) && is_floor(map_x - 1, map_y) && is_floor(map_x, map_y - 1)) {
                    instance_create_layer((map_x - 1) * 256, map_y * 256, "Instances", obj_wall_top);
                }
                if (!is_floor(map_x + 1, map_y - 1) && is_floor(map_x + 1, map_y) && is_floor(map_x, map_y - 1)) {
                    instance_create_layer((map_x + 1) * 256, map_y * 256, "Instances", obj_wall_top);
                }
                if (!is_floor(map_x - 1, map_y + 1) && is_floor(map_x - 1, map_y) && is_floor(map_x, map_y + 1)) {
                    instance_create_layer((map_x - 1) * 256, map_y * 256, "Instances", obj_wall_bottom);
                }
                if (!is_floor(map_x + 1, map_y + 1) && is_floor(map_x + 1, map_y) && is_floor(map_x, map_y + 1)) {
                    instance_create_layer((map_x + 1) * 256, map_y * 256, "Instances", obj_wall_bottom);
                }
            } else if (is_open_corner(map_x, map_y)) {
                // Esquinas abiertas
                if (is_floor(map_x + 1, map_y) && is_floor(map_x, map_y - 1) && !is_floor(map_x + 1, map_y - 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_corner_topright_open);
                } else if (is_floor(map_x - 1, map_y) && is_floor(map_x, map_y - 1) && !is_floor(map_x - 1, map_y - 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_corner_topleft_open);
                } else if (is_floor(map_x + 1, map_y) && is_floor(map_x, map_y + 1) && !is_floor(map_x + 1, map_y + 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_corner_bottomright_open);
                } else if (is_floor(map_x - 1, map_y) && is_floor(map_x, map_y + 1) && !is_floor(map_x - 1, map_y + 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_corner_bottomleft_open);
                }
                // Añadir pared superior para esquinas abiertas
                if (is_floor(map_x, map_y - 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_top);
                }
                // Añadir pared inferior para esquinas abiertas
                if (is_floor(map_x, map_y + 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_bottom);
                }
                // Añadir paredes izquierda y derecha para esquinas abiertas
                if (is_floor(map_x - 1, map_y)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_left);
                }
                if (is_floor(map_x + 1, map_y)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_right);
                }
            } else if (is_adjacent_to_floor(map_x, map_y)) {
                // Bordes
                if (is_floor(map_x - 1, map_y)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_left);
                } else if (is_floor(map_x + 1, map_y)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_right);
                } else if (is_floor(map_x, map_y - 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_top);
                } else if (is_floor(map_x, map_y + 1)) {
                    instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_wall_bottom);
                }
                // Añadir esquinas abiertas para paredes superiores e inferiores
                if (is_dark(map_x - 1, map_y) && instance_position((map_x - 1) * 256, map_y * 256, obj_wall_top) != noone) {
                    instance_create_layer((map_x - 1) * 256, map_y * 256, "Instances", obj_wall_corner_bottomright_open);
                }
                if (is_dark(map_x + 1, map_y) && instance_position((map_x + 1) * 256, map_y * 256, obj_wall_top) != noone) {
                    instance_create_layer((map_x + 1) * 256, map_y * 256, "Instances", obj_wall_corner_bottomleft_open);
                }
                if (is_dark(map_x - 1, map_y) && instance_position((map_x - 1) * 256, map_y * 256, obj_wall_bottom) != noone) {
                    instance_create_layer((map_x - 1) * 256, map_y * 256, "Instances", obj_wall_corner_topright_open);
                }
                if (is_dark(map_x + 1, map_y) && instance_position((map_x + 1) * 256, map_y * 256, obj_wall_bottom) != noone) {
                    instance_create_layer((map_x + 1) * 256, map_y * 256, "Instances", obj_wall_corner_topleft_open);
                }
            } else {
                // Dibujar celda oscura
                instance_create_layer(map_x * 256, map_y * 256, "Instances", obj_dark);
            }
        }
    }

    // Eliminar obj_wall_corner_topright_open sobre obj_wall_bottom que no están en una esquina
    var wall_bottom_list = ds_list_create();
    var wall_corner_list = ds_list_create();
	var floor_list = ds_list_create();

    // Recopilar instancias de obj_wall_bottom y obj_wall_corner_topright_open
    with (obj_wall_bottom) {
        ds_list_add(wall_bottom_list, id);
    }
    with (obj_wall_corner_topright_open) {
        ds_list_add(wall_corner_list, id);
    }
	with (obj_floor) {
		ds_list_add(floor_list, id);
    }

    // Verificar y eliminar obj_wall_corner_topright_open no deseados
    for (var i = 0; i < ds_list_size(wall_corner_list); i++) {
        var corner = wall_corner_list[| i];
        if (position_meeting(corner.x, corner.y, obj_wall_bottom) && !is_open_corner(corner.x / 256, corner.y / 256)) {
            with (corner) {
                instance_destroy();
            }
        }
    }
	
	for (var i = 0; i < ds_list_size(floor_list); i++) {
        var floor1 = floor_list[| i];
        if (position_meeting(floor1.x, floor1.y, obj_wall_left) || position_meeting(floor1.x, floor1.y, obj_wall_right) || position_meeting(floor1.x, floor1.y, obj_wall_bottom)) {
            with (floor1) {
                instance_destroy();
            }
        }
    }

    ds_list_destroy(wall_bottom_list);
    ds_list_destroy(wall_corner_list);

    // Añadir paredes superiores e inferiores adicionales
    for (var map_x = 0; map_x < global.map_width; map_x++) {
        for (var map_y = 0; map_y < global.map_height; map_y++) {
            if (instance_position(map_x * 256, map_y * 256, obj_wall_left) != noone) {
                if (is_dark(map_x, map_y - 1) && instance_position(map_x * 256, (map_y - 1) * 256, obj_wall_top) == noone) {
                    instance_create_layer(map_x * 256, (map_y - 1) * 256, "Instances", obj_wall_corner_topleft_open);
                }
                if (is_dark(map_x, map_y + 1) && instance_position(map_x * 256, (map_y + 1) * 256, obj_wall_bottom) == noone) {
                    instance_create_layer(map_x * 256, (map_y + 1) * 256, "Instances", obj_wall_bottom);
                }
            }
            if (instance_position(map_x * 256, map_y * 256, obj_wall_right) != noone) {
                if (is_dark(map_x, map_y - 1) && instance_position(map_x * 256, (map_y - 1) * 256, obj_wall_top) == noone) {
                    instance_create_layer(map_x * 256, (map_y - 1) * 256, "Instances", obj_wall_corner_topright_open);
                }
                if (is_dark(map_x, map_y + 1) && instance_position(map_x * 256, (map_y + 1) * 256, obj_wall_bottom) == noone) {
                    instance_create_layer(map_x * 256, (map_y + 1) * 256, "Instances", obj_wall_bottom);
                }
            }
        }
    }

    // Generar la salida en una habitación aleatoria diferente de la entrada
    var exit_placed = false;
    while (!exit_placed) {
        var exit_room_index = irandom(ds_list_size(global.rooms) - 1);
        var exit_room = global.rooms[| exit_room_index];

        // Verificar que la salida no esté en la misma habitación que la entrada
        var player_room_x = floor(player_instance.x / 256);
        var player_room_y = floor(player_instance.y / 256);
        if (exit_room_index != entry_room_index) {
            // Colocar la salida en una posición aleatoria dentro de la habitación
            exit_x = irandom_range(exit_room[| 0], exit_room[| 2]);
            exit_y = irandom_range(exit_room[| 1], exit_room[| 3]);
            if (can_place_object(exit_x * 256, exit_y * 256)) {
                instance_create_layer(exit_x * 256, exit_y * 256 + 100, "Instances", obj_scenary_exit);
                exit_placed = true;
                exit_room_index = find_room_index(exit_x / 256, exit_y / 256);
            }
        }
    }

    var new_object_count = 0;
    var attempts = 0; // Contador de intentos
    var max_attempts = 300; // Aumentamos el límite de intentos
    var instance = obj_library;
    while (new_object_count < 3 && attempts < max_attempts) {
        // Escoger una posición aleatoria dentro del mapa
        var obj_x = irandom(global.map_width - 2) + 1; // Asegura que no seleccionemos los bordes
        var obj_y = irandom(global.map_height - 1);

        // Verificar las condiciones para colocar el nuevo objeto
        if (instance_position(obj_x * 256, obj_y * 256, obj_wall_bottom) != noone &&
            instance_position((obj_x - 1) * 256, obj_y * 256, obj_wall_bottom) != noone &&
            instance_position((obj_x + 1) * 256, obj_y * 256, obj_wall_bottom) != noone) {
                if (global.level mod 5 == 0 && new_object_count == 0) {
                    instance = obj_boss_door;
                } else { instance = obj_library }
            instance_create_layer(obj_x * 256 + 120, obj_y * 256 + 30, "Instances", instance);
            new_object_count++;
        }
        attempts++;
    }

    if (new_object_count < 3) {
        show_debug_message("No se pudieron colocar todas las instancias de obj_library. Intentos: " + string(attempts));
    } else {
        show_debug_message("Todas las instancias de obj_library colocadas.");
    }

    generate_collision_walls();
    // In your map generation code
    place_skeletons(entry_room_index); // Adjust the number of skeletons as needed
}
