function connect_room_to_closest(room, visited) {
    var closest_room = -1;
    var closest_distance = 10000;

    for (var i = 0; i < ds_list_size(visited); i++) {
        var v_room = visited[| i];
        var center1_x = (room[| 0] + room[| 2]) / 2;
        var center1_y = (room[| 1] + room[| 3]) / 2;
        var center2_x = (v_room[| 0] + v_room[| 2]) / 2;
        var center2_y = (v_room[| 1] + v_room[| 3]) / 2;

        var distance = abs(center1_x - center2_x) + abs(center1_y - center2_y);

        if (distance < closest_distance) {
            closest_distance = distance;
            closest_room = v_room;
        }
    }

    var center1_x = (room[| 0] + room[| 2]) / 2;
    var center1_y = (room[| 1] + room[| 3]) / 2;
    var center2_x = (closest_room[| 0] + closest_room[| 2]) / 2;
    var center2_y = (closest_room[| 1] + closest_room[| 3]) / 2;

    // Crear pasillos en ángulo recto
    if (center1_x != center2_x && center1_y != center2_y) {
        for (var x_pos = min(center1_x, center2_x); x_pos <= max(center1_x, center2_x); x_pos++) {
            ds_grid_set(map, x_pos, center1_y, 1);
        }
        for (var y_pos = min(center1_y, center2_y); y_pos <= max(center1_y, center2_y); y_pos++) {
            ds_grid_set(map, center2_x, y_pos, 1);
        }
    } else {
        for (var x_pos = min(center1_x, center2_x); x_pos <= max(center1_x, center2_x); x_pos++) {
            ds_grid_set(map, x_pos, center1_y, 1);
        }
        for (var y_pos = min(center1_y, center2_y); y_pos <= max(center1_y, center2_y); y_pos++) {
            ds_grid_set(map, center1_x, y_pos, 1);
        }
    }
	generate_random_objects();
    ds_list_add(visited, room);
}