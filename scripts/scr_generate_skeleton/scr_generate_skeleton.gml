function place_skeletons(num_warriors, num_archers) {
    for (var i = 0; i < num_warriors; i++) {
        var floor_found = false;
        while (!floor_found) {
            var xx = irandom(global.map_width - 1);
            var yy = irandom(global.map_height - 1);

            if (map[# xx, yy] == 1) { // If the cell is a floor
                instance_create_layer(xx * 256 + 128, yy * 256 + 128, "Instances", obj_skeleton_warrior);
                floor_found = true;
            }
        }
    }

    for (var j = 0; j < num_archers; j++) {
        var floor_found = false;
        while (!floor_found) {
            var xx = irandom(global.map_width - 1);
            var yy = irandom(global.map_height - 1);

            if (map[# xx, yy] == 1) { // If the cell is a floor
                instance_create_layer(xx * 256 + 128, yy * 256 + 128, "Instances", obj_archer_skeleton);
                floor_found = true;
            }
        }
    }
}
