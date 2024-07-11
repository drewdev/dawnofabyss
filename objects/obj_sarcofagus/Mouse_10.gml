/// @description Insert description here
// You can write your code in this editor
// Cambiar a sprite con contorno blanco
sprite_index = spr_closed_sarcofagus_hover;

// Crear el objeto controlador de nombre
// Crear el objeto controlador de nombre
if (!instance_exists(obj_name_display)) {
    var name_display = instance_create_layer(x, y, "Instances", obj_name_display);
    name_display.name_text = "Closed Coffin"; // Cambia esto según el objeto
    name_display.target_object = id;
}