function surround_room_with_walls(x1, y1, x2, y2) {
    for (var x_pos = x1; x_pos <= x2; x_pos++) {
        for (var y_pos = y1; y_pos <= y2; y_pos++) {
            if (x_pos == x1 || x_pos == x2 || y_pos == y1 || y_pos == y2) {
                ds_grid_set(map, x_pos, y_pos, 2); // 2 representa una pared
            }
        }
    }
}