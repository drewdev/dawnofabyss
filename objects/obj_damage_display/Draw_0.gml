/// @description Draw damage value

// Dibujar el valor del daño
draw_set_alpha(image_alpha);
draw_set_color(draw_color);
draw_text(x, y-260, string(damage_value));
draw_set_alpha(1);
