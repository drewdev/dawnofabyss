// Asegúrate de que la vista siga al jugador
var player = obj_player; // Asegúrate de que este sea el nombre correcto de tu objeto jugador

if (instance_exists(player)) {
    // Calcula la posición objetivo de la vista para centrar al jugador
    var target_x = player.x - view_wview[0] / 2;
    var target_y = player.y - view_hview[0] / 2;
    
    // Asegúrate de que la vista no se salga del mapa
    target_x = clamp(target_x, 0, global.map_width * 256 - view_wview[0]);
    target_y = clamp(target_y, 0, global.map_height * 256 - view_hview[0]);
    
    // Interpolación para un movimiento más suave
    var lerp_speed = 0.1; // Ajusta este valor para cambiar la velocidad de seguimiento (0.0 - 1.0)
    view_xview[0] = lerp(view_xview[0], target_x, lerp_speed);
    view_yview[0] = lerp(view_yview[0], target_y, lerp_speed);
}

if (keyboard_check_pressed(vk_enter)) {
    reset_map();
}