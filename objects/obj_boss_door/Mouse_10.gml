/// @description Insert description here
// You can write your code in this editor

sprite_index = spr_boss_door_hover;

// Crear el objeto controlador de nombre
// Crear el objeto controlador de nombre
if (!instance_exists(obj_name_display)) {
    var name_display = instance_create_layer(x, y, "Instances", obj_name_display);
    name_display.name_text = "Enter Boss Room"; // Cambia esto según el objeto
    name_display.target_object = id;
}