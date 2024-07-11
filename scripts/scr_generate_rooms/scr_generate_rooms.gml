function generate_rooms(num_rooms) {
	for (var i = 0; i < num_rooms; i++) {
        var r_width = irandom_range(global.min_room_size, global.max_room_size);
        var r_height = irandom_range(global.min_room_size, global.max_room_size);
        var x_pos = irandom_range(1, global.map_width - r_width - 1);
        var y_pos = irandom_range(1, global.map_height - r_height - 1);

        create_room(x_pos, y_pos, x_pos + r_width - 1, y_pos + r_height - 1);
    }
    // Generar habitaciones grandes
    for (var j = 0; j < 1; j++) {
       var r_width = irandom_range(global.min_room_size * 1.2, global.max_room_size * 1.2);
        var r_height = irandom_range(global.min_room_size * 1.2, global.max_room_size * 1.2);
        var x_pos = irandom_range(1, global.map_width - r_width - 1);
        var y_pos = irandom_range(1, global.map_height - r_height - 1);

        create_room(x_pos, y_pos, x_pos + r_width - 1, y_pos + r_height - 1);
    }
}
