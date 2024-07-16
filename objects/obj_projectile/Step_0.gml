/// @description Projectile movement and collision

// Update the orbit angle
orbit_angle += orbit_speed;
if (orbit_angle >= 360) {
    orbit_angle -= 360;
}

// Calculate the orbit offsets
var orbit_x = lengthdir_x(orbit_radius, orbit_angle);
var orbit_y = lengthdir_y(orbit_radius, orbit_angle);

// Calculate the movement towards the player
var move_x = lengthdir_x(speed, direction_to_player);
var move_y = lengthdir_y(speed, direction_to_player);

// Apply the movement and orbiting effect
x += move_x + orbit_x;
y += move_y + orbit_y;

// Rotate the projectile sprite
image_angle += 10;

// Check for collision with player
if (place_meeting(x, y, obj_player)) {
    with (obj_player) {
        if (invulnerability_timer <= 0) {
            var damage = irandom_range(obj_mage_skeleton.minAttack, obj_mage_skeleton.maxAttack);
            hp -= damage; // Adjust damage value as needed
            invulnerability_timer = 30; // Prevent multiple hits in quick succession
            var dmg = instance_create_layer(x, y, "Instances", obj_damage_display);
            dmg.damage_value = damage; // Adjust this value to the damage received
            dmg.draw_color = c_aqua;
        }
    }
    instance_destroy(); // Destroy projectile on impact
}
// Destroy the projectile if it collides with a wall
if (scr_check_collision(x, y+90) || place_meeting(x, y, obj_force_field)) {
    instance_destroy();
}
