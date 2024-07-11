function find_room_index(room_x, room_y) {
    for (var i = 0; i < ds_list_size(global.rooms); i++) {
        var this_room = global.rooms[| i];
        if (room_x >= this_room[| 0] && room_x <= this_room[| 2] && room_y >= this_room[| 1] && room_y <= this_room[| 3]) {
            return i;
        }
    }
    return -1;
}