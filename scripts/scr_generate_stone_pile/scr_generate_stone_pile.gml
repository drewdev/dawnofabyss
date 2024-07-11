function generate_stone_pile(num_stone) {
	randomize();
    for (var i = 0; i < num_stone; i++) {
        // Encontrar una celda de piso aleatoria
        var floor_found = false;
        while (!floor_found) {
            var xx = irandom(global.map_width - 1);
            var yy = irandom(global.map_height - 1);

            if (map[# xx, yy] == 1 && can_place_object(xx * 256 + 0, yy * 256 + 0)) { // Si la celda es un piso y no está ocupada
                // Crear el objeto sarcofago en el centro del tile
                instance_create_layer(xx * 256 + 0, yy * 256 + 0, "Instances", obj_stone_pile);
                floor_found = true;
            }
        }
    }
}