function can_place_object(xx, yy) {
    return instance_position(xx, yy, obj_chest) == noone &&
           instance_position(xx, yy, obj_cadaver) == noone &&
           instance_position(xx, yy, obj_sarcofagus) == noone &&
           instance_position(xx, yy, obj_scenary_entry) == noone &&
           instance_position(xx, yy, obj_scenary_exit) == noone &&
		   instance_position(xx, yy, obj_wall_left) == noone &&
		   instance_position(xx, yy, obj_wall_right) == noone; 
}