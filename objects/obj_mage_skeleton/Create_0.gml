/// @description Initialize variables for skeleton archer
// States

vision_range = 1000; // Mayor radio de visión
attack_range = 600; // Ataque a distancia
state = State.Idle;

target = noone;
idle_time = 0;
depth = -45;

// Variables
path = noone; // Inicializar la variable path
sprite_index = spr_skeleton_mage_idle;
image_speed = 1;
move_speed = 4; // Movement speed
hp = 50; // Health points
minAttack = 3;
maxAttack = 9;
hit = false;
// Set a random initial direction
direction = irandom_range(0, 359);

// Knockback variables
knockback = false;
knockback_speed = 10;
knockback_duration = 14;
knockback_timer = 0;
knockback_direction = 0;
invulnerability_timer = 0;

arrow_spawned = false; // Flag to ensure arrow spawns only once
