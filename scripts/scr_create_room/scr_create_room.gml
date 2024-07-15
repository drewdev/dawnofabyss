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
	scr_generate_chest(x1, x2, y1, y2);
	generate_random_objects();
}