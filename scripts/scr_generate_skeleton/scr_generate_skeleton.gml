function place_skeletons(entry_room_index) {
    for (var i = 0; i < global.skeleton_warrior; i++) {
        place_skeleton_room(obj_skeleton_warrior, entry_room_index);
    }

    for (var i = 0; i < global.skeleton_archer; i++) {
        place_skeleton_room(obj_archer_skeleton, entry_room_index);
    }

    for (var i = 0; i < global.skeleton_mage; i++) {
        place_skeleton_room(obj_mage_skeleton, entry_room_index);
    }
}

function place_skeleton_room(skeleton_type, entry_room_index) {
    var floor_found = false;
    var attempts = 0;
    var max_attempts = 100; // Limitar los intentos para evitar bucles infinitos

    while (!floor_found && attempts < max_attempts) {
        var xx = irandom(global.map_width - 1);
        var yy = irandom(global.map_height - 1);

        if (map[# xx, yy] == 1) { // Si la celda es un piso
            var room_index = find_room_index(xx, yy); // Encuentra el índice de la habitación actual
            if (room_index != entry_room_index) { // Asegúrate de que no sea la misma habitación que la entrada
                instance_create_layer(xx * 256 + 128, yy * 256 + 128, "Instances", skeleton_type);
                floor_found = true;
            }
        }
        attempts++;
    }

    if (!floor_found) {
        show_debug_message("No se pudo colocar " + string(skeleton_type) + " después de " + string(attempts) + " intentos.");
    }
}

