// Arrow Create Event/// @description Initialize projectile variables

direction_to_player = point_direction(x, y, obj_player.x, obj_player.y);
speed = 1; // Set the initial speed of the projectile
orbit_radius = 10; // Set the radius of the orbit
orbit_speed = 10; // Set the speed of the orbit
orbit_angle = 8; // Initial angle for the orbit

image_angle = direction; // Alinear la imagen con la dirección de la flecha
depth = -6666;