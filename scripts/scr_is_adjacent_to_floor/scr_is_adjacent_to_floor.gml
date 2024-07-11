function is_adjacent_to_floor(x, y) {
    return is_floor(x - 1, y) || is_floor(x + 1, y) || 
           is_floor(x, y - 1) || is_floor(x, y + 1);
}