function connect_rooms() {
	randomize();
    var connected_rooms = ds_list_create();
    ds_list_add(connected_rooms, global.rooms[| 0]);

    while (ds_list_size(connected_rooms) < ds_list_size(global.rooms)) {
        for (var i = 1; i < ds_list_size(global.rooms); i++) {
            var room1 = global.rooms[| i - 1];
            var room2 = global.rooms[| i];

            var center1_x = (room1[| 0] + room1[| 2]) / 2;
            var center1_y = (room1[| 1] + room1[| 3]) / 2;
            var center2_x = (room2[| 0] + room2[| 2]) / 2;
            var center2_y = (room2[| 1] + room2[| 3]) / 2;

            // Conectar horizontalmente con pasillos más anchos
            if (center1_x < center2_x) {
                for (var x_pos = center1_x; x_pos <= center2_x; x_pos++) {
                    for (var y_offset = -random_range(1, 2) div 2; y_offset <= random_range(1, 2) div 2; y_offset++) {
                        ds_grid_set(map, x_pos, center1_y + y_offset, 1);
                    }
                }
            } else {
                for (var x_pos = center2_x; x_pos <= center1_x; x_pos++) {
                    for (var y_offset = -random_range(1, 2) div 2; y_offset <= random_range(1, 2) div 2; y_offset++) {
                        ds_grid_set(map, x_pos, center2_y + y_offset, 1);
                    }
                }
            }

            // Conectar verticalmente con pasillos más anchos
            if (center1_y < center2_y) {
                for (var y_pos = center1_y; y_pos <= center2_y; y_pos++) {
                    for (var x_offset = -random_range(1, 2) div 2; x_offset <= random_range(1, 2) div 2; x_offset++) {
                        ds_grid_set(map, center2_x + x_offset, y_pos, 1);
                    }
                }
            } else {
                for (var y_pos = center2_y; y_pos <= center1_y; y_pos++) {
                    for (var x_offset = -random_range(1, 2) div 2; x_offset <= random_range(1, 2) div 2; x_offset++) {
                        ds_grid_set(map, center1_x + x_offset, y_pos, 1);
                    }
                }
            }

            // Asegurarse de que la habitación esté conectada
            if (!ds_list_find_index(connected_rooms, room2)) {
                connect_room_to_closest(room2, connected_rooms);
            }
        }
    }

    ds_list_destroy(connected_rooms);
}