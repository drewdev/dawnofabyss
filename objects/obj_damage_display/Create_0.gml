/// @description Initialize damage display

damage_value = 0; // Valor del daño a mostrar
move_speed = 0.3; // Velocidad de movimiento hacia arriba
fade_speed = 0.01; // Velocidad de desvanecimiento

// Color y fuente del texto
draw_color = c_red;
draw_set_font(fnt_default); // Asegúrate de tener una fuente configurada
depth = -5000;