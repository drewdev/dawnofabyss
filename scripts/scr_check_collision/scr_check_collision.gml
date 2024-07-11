// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_check_collision(){
	/// @description Check for collisions at a given position
	/// @param check_x
	/// @param check_y
	var check_x = argument0;
	var check_y = argument1;

	// Verificar colisión con obj_wall_top y obj_wall_bottom
	if (place_meeting(check_x, check_y, obj_wall_top) || 
	    place_meeting(check_x, check_y, obj_wall_bottom) || 
		
	    place_meeting(check_x, check_y, obj_wall_left_collision) || 
	    place_meeting(check_x, check_y, obj_wall_right_collision)) 
		
		
	{
	    return true;
	}
	return false;
}