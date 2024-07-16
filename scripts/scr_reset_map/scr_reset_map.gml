function reset_map() {
    with (obj_floor) instance_destroy();
    with (obj_wall_corner_topleft) instance_destroy();
    with (obj_wall_corner_topright) instance_destroy();
    with (obj_wall_corner_bottomleft) instance_destroy();
    with (obj_wall_corner_bottomright) instance_destroy();
    with (obj_wall_corner_topleft_open) instance_destroy();
    with (obj_wall_corner_topright_open) instance_destroy();
    with (obj_wall_corner_bottomleft_open) instance_destroy();
    with (obj_wall_corner_bottomright_open) instance_destroy();
    with (obj_wall_top) instance_destroy();
    with (obj_wall_bottom) instance_destroy();
    with (obj_wall_left) instance_destroy();
    with (obj_wall_right) instance_destroy();
    with (obj_dark) instance_destroy();
	with (obj_boss_door) instance_destroy();
	with (obj_wall_left_collision) instance_destroy();
	with (obj_wall_right_collision) instance_destroy();
	
    // reset items
    with (obj_library) instance_destroy();
    with (obj_chest) instance_destroy();
    with (obj_chest_big) instance_destroy();
    with (obj_sarcofagus) instance_destroy();
    with (obj_cadaver) instance_destroy();
    with (obj_target) instance_destroy();
    with (obj_stone_pile) instance_destroy();
    with (obj_blood) instance_destroy();
    with (obj_scenary_entry) instance_destroy();
    with (obj_scenary_exit) instance_destroy();
    // Eliminar el objeto jugador y la cámara
    with (obj_player) instance_destroy();
    with (obj_camera) instance_destroy();
	with (obj_level_display) instance_destroy();
	// Elimianr enemigos
	with (obj_skeleton_warrior) instance_destroy();
	with (obj_archer_skeleton) instance_destroy();
	with (obj_mage_skeleton) instance_destroy();
	with (obj_force_field) instance_destroy();
	// Limpiar la lista de habitaciones
    ds_list_clear(global.rooms);
	// Limpiar paths
	mp_grid_destroy(global.grid);
    // Incrementar el nivel
    global.level = global.level + 1;

    // Regenerar el escenario llamando a la función de generar el mapa desde obj_controller
    with (obj_controller) {
        create_new_map();
	} 
}
