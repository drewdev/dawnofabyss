/// @description Draw the HUD

// Posición del círculo de vida en la pantalla relativa a la vista de la cámara
if (instance_exists(obj_player)) {
    x = obj_player.x;
    y = obj_player.y;
}
var screen_x = x + -1130; // Ajusta según la posición deseada
var screen_y = y + view_hview[0] - 150; // Ajusta según la posición deseada


// Dibujar el sprite del círculo de vida
draw_sprite(spr_life_circle_over, 0, screen_x, screen_y);
