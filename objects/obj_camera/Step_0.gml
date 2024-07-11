// Asegúrate de que el jugador exista antes de ajustar la vista
if (instance_exists(obj_player)) {
    // Obtén la posición del jugador
    var player_x = obj_player.x;
    var player_y = obj_player.y;

    // Tamaño de la vista
    var view_width = camera_get_view_width(camera);
    var view_height = camera_get_view_height(camera);
}
