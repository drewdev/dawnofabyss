/// @description Arrow movement and collision

// Mover la flecha en la dirección establecida
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

// Ajustar la rotación de la imagen según la dirección de movimiento
image_angle = direction;

// Check for collision with player
if (place_meeting(x, y, obj_player)) {
    with (obj_player) {
        if (invulnerability_timer <= 0) {
            var damage = irandom_range(obj_archer_skeleton.minAttack, obj_archer_skeleton.maxAttack);
            hp -= damage; // Adjust damage value as needed
            invulnerability_timer = 30; // Prevent multiple hits in quick succession
            var dmg = instance_create_layer(x, y, "Instances", obj_damage_display);
            dmg.damage_value = damage; // Adjust this value to the damage received
            dmg.draw_color = c_red;
        }
    }
    instance_destroy(); // Destroy arrow on impact
}



if (scr_check_collision(x, y+50) || place_meeting(x, y, obj_force_field)) {
    instance_destroy();
}