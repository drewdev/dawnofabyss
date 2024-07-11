function is_floor(x, y) {
    return (x >= 0 && x < global.map_width && y >= 0 && y < global.map_height && map[# x, y] == 1);
}