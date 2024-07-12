// Evento Create del obj_player

target_x = x;
target_y = y;
target_set = false;
// Inicializar la variable global new_target
global.new_target = noone;
// Inicializar la variable path
path = noone;
path_direction = noone;

// Set depth of character and sword
depth = -50; // Character's depth (higher value, drawn below)

// Inicializar el estado de ataque
attacking = false;
last_direction = 0; // Para almacenar la última dirección
