// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function generate_collision_walls(){
	// Eliminar las obj_wall_top y obj_wall_bottom que se superponen con obj_wall_left y obj_wall_right
    with (obj_wall_left) {
        var top_inst = instance_position(x, y, obj_wall_top);
        var bottom_inst = instance_position(x, y, obj_wall_bottom);
        if (top_inst != noone) {
            with (top_inst) {
                instance_destroy();
            }
        }
        if (bottom_inst != noone) {
            with (bottom_inst) {
                instance_destroy();
            }
        }
    }

    with (obj_wall_right) {
        var top_inst = instance_position(x, y, obj_wall_top);
        var bottom_inst = instance_position(x, y, obj_wall_bottom);
        if (top_inst != noone) {
            with (top_inst) {
                instance_destroy();
            }
        }
        if (bottom_inst != noone) {
            with (bottom_inst) {
                instance_destroy();
            }
        }
    }
    
    // Eliminar las obj_wall_top y obj_wall_bottom que se superponen con obj_wall_corner_bottomleft y obj_wall_corner_bottomright
    with (obj_wall_corner_bottomleft) {
        var top_inst = instance_position(x, y, obj_wall_top);
        var bottom_inst = instance_position(x, y, obj_wall_bottom);
        if (top_inst != noone) {
            with (top_inst) {
                instance_destroy();
            }
        }
        if (bottom_inst != noone) {
            with (bottom_inst) {
                instance_destroy();
            }
        }
    }

    with (obj_wall_corner_bottomright) {
        var top_inst = instance_position(x, y, obj_wall_top);
        var bottom_inst = instance_position(x, y, obj_wall_bottom);
        if (top_inst != noone) {
            with (top_inst) {
                instance_destroy();
            }
        }
        if (bottom_inst != noone) {
            with (bottom_inst) {
                instance_destroy();
            }
        }
    }
	// Agregar obj_wall_top sobre obj_wall_corner_topright_open y obj_wall_corner_topleft_open siempre y cuando no se encuentren sobre un obj_wall_left u obj_wall_right
    with (obj_wall_corner_topright_open) {
        if (instance_position(x, y, obj_wall_left) == noone && instance_position(x, y, obj_wall_right) == noone) {
            instance_create_layer(x, y, "Instances", obj_wall_top);
        }
    }

    with (obj_wall_corner_topleft_open) {
        if (instance_position(x, y, obj_wall_left) == noone && instance_position(x, y, obj_wall_right) == noone) {
            instance_create_layer(x, y, "Instances", obj_wall_top);
        }
    }
	
	// Agregar obj_wall_left_collision y obj_wall_right_collision
	with (obj_wall_right) {
        if (instance_position(x, y, obj_wall_left_collision) == noone) {
            instance_create_layer(x, y, "Instances", obj_wall_right_collision);
        }
    }
	
	with (obj_wall_right_collision) {
        if (instance_position(x, y, obj_wall_corner_topleft)) {
            instance_destroy();
        }
    }
	with (obj_wall_right_collision) {
        if (instance_position(x, y, obj_wall_left_collision)) {
            instance_destroy();
        }
    }
	with (obj_wall_right_collision) {
        if (instance_position(x, y, obj_wall_left)) {
            instance_destroy();
        }
    }
    with (obj_wall_left) {
        if (instance_position(x, y, obj_wall_right_collision) == noone) {
            instance_create_layer(x, y, "Instances", obj_wall_left_collision);
        }
    }

}