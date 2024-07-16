// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_force_field(){
	obj_player.force_field_active = true;
    obj_player.force_field_timer = room_speed * 5; // 5 segundos de protección
    obj_player.force_field_instance = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_force_field);
    obj_player.force_field_instance.depth = obj_player.depth - 1; // Asegurar que el campo de fuerza esté dibujado detrás del jugador
}