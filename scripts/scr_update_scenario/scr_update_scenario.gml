// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_update_scenario(){
	if (global.level > 3) {
		obj_floor.sprite_index = spr_floor_a;
		obj_wall_bottom.sprite_index = spr_wall_bottom_a;
		obj_wall_corner_bottomleft.sprite_index = spr_wall_corner_bottomright_a;
		//obj_wall_corner_bottomleft_open.sprite_index = spr_wall_corner_topright_a;
		obj_wall_corner_bottomright.sprite_index = spr_wall_corner_bottomleft_a;
		obj_wall_corner_bottomright_open.sprite_index = spr_wall_corner_topleft_a;
		obj_wall_corner_topleft.sprite_index = spr_wall_right_a;
		obj_wall_corner_topleft_open.sprite_index = spr_wall_corner_topright_a;
		obj_wall_corner_topright.sprite_index = spr_wall_left_a;
		obj_wall_corner_topright_open.sprite_index = spr_wall_corner_topleft_a;
		obj_wall_left.sprite_index = spr_wall_right_a;
		obj_wall_right.sprite_index = spr_wall_left_a;
		obj_wall_top.sprite_index = spr_wall_bottom_a;
	}
	if (global.level > 6) {
		obj_floor.sprite_index = spr_floor_b;
		obj_wall_bottom.sprite_index = spr_wall_bottom_b;
		obj_wall_corner_bottomleft.sprite_index = spr_wall_corner_bottomright_b;
		//obj_wall_corner_bottomleft_open.sprite_index = spr_wall_corner_topright_b;
		obj_wall_corner_bottomright.sprite_index = spr_wall_corner_bottomleft_b;
		obj_wall_corner_bottomright_open.sprite_index = spr_wall_corner_topleft_b;
		obj_wall_corner_topleft.sprite_index = spr_wall_right_b;
		obj_wall_corner_topleft_open.sprite_index = spr_wall_corner_topright_b;
		obj_wall_corner_topright.sprite_index = spr_wall_left_b;
		obj_wall_corner_topright_open.sprite_index = spr_wall_corner_topleft_b;
		obj_wall_left.sprite_index = spr_wall_right_b;
		obj_wall_right.sprite_index = spr_wall_left_b;
		obj_wall_top.sprite_index = spr_wall_bottom_b;
	}
	if (global.level > 9) {
		obj_floor.sprite_index = spr_floor_c;
		obj_wall_bottom.sprite_index = spr_wall_bottom_c;
		obj_wall_corner_bottomleft.sprite_index = spr_wall_corner_bottomright_c;
		//obj_wall_corner_bottomleft_open.sprite_index = spr_wall_corner_topright_a;
		obj_wall_corner_bottomright.sprite_index = spr_wall_corner_bottomleft_c;
		obj_wall_corner_bottomright_open.sprite_index = spr_wall_corner_topleft_c;
		obj_wall_corner_topleft.sprite_index = spr_wall_right_c;
		obj_wall_corner_topleft_open.sprite_index = spr_wall_corner_topright_c;
		obj_wall_corner_topright.sprite_index = spr_wall_left_c;
		obj_wall_corner_topright_open.sprite_index = spr_wall_corner_topleft_c;
		obj_wall_left.sprite_index = spr_wall_right_c;
		obj_wall_right.sprite_index = spr_wall_left_c;
		obj_wall_top.sprite_index = spr_wall_bottom_c;
	}

}