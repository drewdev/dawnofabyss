/// @description Initialize player variables

target_x = x;
target_y = y;
target_set = false;
// Inicializar la variable global new_target
global.new_target = noone;
// Inicializar la variable path
path = noone;
path_direction = noone;
hp = 200; // Health points
// Set depth of character and sword
depth = -50; // Character's depth (higher value, drawn below)

// Inicializar el estado de ataque
attacking = false;
last_direction = 0; // Para almacenar la última dirección

// Variables de knockback
knockback = false;
knockback_speed = 12;
knockback_timer = 0;
knockback_direction = 0;

invulnerability_timer = 0;
attack_cooldown = 0;
