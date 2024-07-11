/// @description Insert description here
// You can write your code in this editor
// Ajustar el sprite al sprite de hover correspondiente
if (sprite_index == spr_cadaver_1) {
    sprite_index = spr_cadaver_1_hover;
} else if (sprite_index == spr_cadaver_2) {
    sprite_index = spr_cadaver_2_hover;
} else if (sprite_index == spr_cadaver_3) {
    sprite_index = spr_cadaver_3_hover;
}

// Crear el objeto controlador de nombre
if (!instance_exists(obj_name_display)) {
    var name_display = instance_create_layer(x, y, "Instances", obj_name_display);
    name_display.name_text = "Corpse";
    name_display.target_object = id;
}
