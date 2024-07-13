/// @description Move damage display up and fade out

// Mover hacia arriba
y -= move_speed;

// Desvanecer
image_alpha -= fade_speed;

// Destruir la instancia cuando se desvanezca completamente
if (image_alpha <= 0) {
    instance_destroy();
}
