/// @description Draw the HUD

// Variables del jugador
var player = obj_player;
var max_hp = 100; // Máxima vida del jugador (ajusta según sea necesario)
var current_hp = player.hp; // Vida actual del jugador

// Posición del círculo de vida en la pantalla relativa a la vista de la cámara
if (instance_exists(obj_player)) {
    x = obj_player.x;
    y = obj_player.y;
}

var screen_x = x + -1130; // Ajusta según la posición deseada
var screen_y = y + view_hview[0] - 150; // Ajusta según la posición deseada
var circle_radius = 100; // Radio del círculo (ajusta según el tamaño deseado)

// Calcular el porcentaje de vida
var hp_percentage = current_hp / max_hp;
var angle = hp_percentage * 360;

// Dibujar el sprite del círculo de vida
draw_sprite(spr_life_circle, 0, screen_x, screen_y);

// Dibujar la barra de progreso circular
// Dibujar la barra de progreso circular

var dark_red = make_color_rgb(255, 4, 5); // Ajusta los valores RGB y alfa según sea necesario

// Dibujar la barra de progreso circular
draw_set_alpha(0.2); // Ajusta la transparencia según sea necesario
draw_set_color(dark_red);

var num_segments = 100; // Ajusta este valor para la suavidad de la barra
var angle_step = angle / num_segments;

draw_primitive_begin(pr_trianglelist);
for (var i = 0; i < num_segments; i++) {
    var a0 = degtorad(i * angle_step - 90); // Convertir grados a radianes y ajustar el ángulo inicial
    var a1 = degtorad((i + 1) * angle_step - 90); // Convertir grados a radianes y ajustar el ángulo inicial

    var x0 = screen_x + cos(a0) * circle_radius;
    var y0 = screen_y + sin(a0) * circle_radius;
    var x1 = screen_x + cos(a1) * circle_radius;
    var y1 = screen_y + sin(a1) * circle_radius;

    draw_vertex_color(screen_x, screen_y, dark_red, 0.2);
    draw_vertex_color(x0, y0, dark_red, 0.2);
    draw_vertex_color(x1, y1, dark_red, 0.2);
}
draw_primitive_end();

// Restaurar el color predeterminado
draw_set_color(c_white);
draw_set_alpha(1);
