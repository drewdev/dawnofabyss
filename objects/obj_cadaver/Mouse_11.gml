/// @description Insert description here
// You can write your code in this editor
// Ajustar el sprite al sprite normal correspondiente
if (sprite_index == spr_cadaver_1_hover) {
    sprite_index = spr_cadaver_1;
} else if (sprite_index == spr_cadaver_2_hover) {
    sprite_index = spr_cadaver_2;
} else if (sprite_index == spr_cadaver_3_hover) {
    sprite_index = spr_cadaver_3;
}

// Destruir el objeto controlador de nombre
with (obj_name_display) {
    instance_destroy();
}
