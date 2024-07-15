// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_generate_chest(x1, x2, y1, y2){
	var num_chests = irandom_range(-1.8, 1); // Número aleatorio de cofres por habitación
    for (var i = 0; i < num_chests; i++) {
        var chest_x = irandom_range(x1, x2);
        var chest_y = irandom_range(y1, y2);
        if (can_place_object(chest_x * 256, chest_y * 256)) {
            instance_create_layer(chest_x * 256, chest_y * 256, "Instances", obj_chest);
        }
    }
}