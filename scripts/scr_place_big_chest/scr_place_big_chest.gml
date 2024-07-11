// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function place_big_chest() {
	randomize();
    var placed = false;
	var probability = random_range(1,3);
    
    while (!placed & probability == 1) {
        var room_index = irandom(ds_list_size(global.rooms) - 1);
        var room1 = global.rooms[| room_index];

        var room_x1 = room1[| 0];
        var room_y1 = room1[| 1];
        var room_x2 = room1[| 2];
        var room_y2 = room1[| 3];

        // Verificar si la habitación contiene obj_scenary_entry o obj_scenary_exit
        var has_entry_exit = false;

        for (var xx = room_x1; xx <= room_x2; xx++) {
            for (var yy = room_y1; yy <= room_y2; yy++) {
                if (instance_position(xx * 256, yy * 256, obj_scenary_entry) != noone ||
                    instance_position(xx * 256, yy * 256, obj_scenary_exit) != noone) {
                    has_entry_exit = true;
                    break;
                }
            }
            if (has_entry_exit) break;
        }

        if (!has_entry_exit) {
            // Colocar el obj_chest_big en una posición aleatoria dentro de la habitación
            var chest_big_x = irandom_range(room_x1, room_x2);
            var chest_big_y = irandom_range(room_y1, room_y2);
            instance_create_layer(chest_big_x * 256, chest_big_y * 256, "Instances", obj_chest_big);
            placed = true;
        }
    }
}
