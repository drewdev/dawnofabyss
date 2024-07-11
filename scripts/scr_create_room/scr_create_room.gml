// Función para crear una habitación
function create_room(x1, y1, x2, y2) {
    for (var x_pos = x1; x_pos <= x2; x_pos++) {
        for (var y_pos = y1; y_pos <= y2; y_pos++) {
            ds_grid_set(map, x_pos, y_pos, 1); // 1 representa suelo
        }
    }
    // Almacenar la habitación como una lista de sus coordenadas
    var room1 = ds_list_create();
    ds_list_add(room1, x1, y1, x2, y2);
    ds_list_add(global.rooms, room1);
    // Añadir cofres aleatoriamente
    var num_chests = irandom_range(-1.8, 1); // Número aleatorio de cofres por habitación
    for (var i = 0; i < num_chests; i++) {
        var chest_x = irandom_range(x1, x2);
        var chest_y = irandom_range(y1, y2);
        if (can_place_object(chest_x * 256, chest_y * 256)) {
            instance_create_layer(chest_x * 256, chest_y * 256, "Instances", obj_chest);
        }
    }
}