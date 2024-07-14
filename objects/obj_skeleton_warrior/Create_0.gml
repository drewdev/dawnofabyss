/// @description Initialize variables for skeleton warrior

// States
enum State {
    Idle,
    Walk,
    Chase,
    Attack,
    Hit,
    Dead
}

// Variables
path = noone; // Inicializar la variable path
state = State.Idle;
sprite_index = spr_skeleton_warrior_idle;
image_speed = 1;
vision_range = 750; // Range for detecting the player
attack_range = 100; // Range for attacking the player
move_speed = 4; // Movement speed
hp = 50; // Health points
minAttack = 1;
maxAttack = 5;
idle_time = 0; // Timer for idle state
hit = false;
// Set a random initial direction
direction = irandom_range(0, 359);
depth = -45;

// Knockback variables
knockback = false;
knockback_speed = 10;
knockback_duration = 14;
knockback_timer = 0;
knockback_direction = 0;
invulnerability_timer = 0;