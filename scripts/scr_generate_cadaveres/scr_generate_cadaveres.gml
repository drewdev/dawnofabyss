function generate_cadaveres(num_cadaveres) {
    for (var i = 0; i < num_cadaveres; i++) {
        // Encontrar una celda de piso aleatoria
        var floor_found = false;
        while (!floor_found) {
            var xx = irandom(global.map_width - 1);
            var yy = irandom(global.map_height - 1);

            if (map[# xx, yy] == 1 && can_place_object(xx * 256 + 128, yy * 256 + 128)) { // Si la celda es un piso y no está ocupada
                // Crear el objeto cadáver en el centro del tile
                instance_create_layer(xx * 256 + 128, yy * 256 + 128, "Instances", obj_cadaver);
                floor_found = true;
            }
        }
    }
}