// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_screen_shake(){
/// @description Apply screen shake

	if (global.shake_timer > 0) {
	    global.shake_timer -= 1;
	    var shake_x = irandom_range(-global.shake_magnitude, global.shake_magnitude);
	    var shake_y = irandom_range(-global.shake_magnitude, global.shake_magnitude);
	    var cam_x = camera_get_view_x(view_camera[0]);
	    var cam_y = camera_get_view_y(view_camera[0]);
	    camera_set_view_pos(view_camera[0], cam_x + shake_x, cam_y + shake_y);
	} else {
	    // Reset the view position if shake_timer is 0
	    var cam_x = camera_get_view_x(view_camera[0]);
	    var cam_y = camera_get_view_y(view_camera[0]);
	    if (cam_x != global.view_xview_start || cam_y != global.view_yview_start) {
	        camera_set_view_pos(view_camera[0], global.view_xview_start, global.view_yview_start);
	    }
	}

}