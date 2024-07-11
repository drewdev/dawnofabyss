// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_check_collision(){
	/// @description scr_check_collision(obj, new_x, new_y)
	/// @param obj El objeto que se va a mover
	/// @param new_x La nueva posición x del objeto
	/// @param new_y La nueva posición y del objeto

	var obj = argument0;
	var new_x = argument1;
	var new_y = argument2;

	// Verificar colisiones horizontales
	if (!place_meeting(new_x, y, obj_wall)) {
	    obj.x = new_x;
	}

	// Verificar colisiones verticales
	if (!place_meeting(x, new_y, obj_wall)) {
	    obj.y = new_y;
	}

}