/// @description Insert description here
// You can write your code in this editor

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
attack_range = 150; // Range for attacking the player
move_speed = 3.5; // Movement speed
hp = 200; // Health points
idle_time = 0; // Timer for idle state

// Set a random initial direction
direction = irandom_range(0, 359);
depth = -45;