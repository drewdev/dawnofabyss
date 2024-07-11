/// @description Update fade animation

// Asegurarse de que el objeto se posicione sobre el personaje
if (instance_exists(obj_player)) {
    x = obj_player.x;
    y = obj_player.y;
}

if (fade_out) {
    fade_alpha += fade_speed;
    if (fade_alpha >= 1) {
        fade_alpha = 1;
        fade_out = false;
        alarm[0] = room_speed * 0.1;// Esperar 2 segundos antes de regenerar el escenario
    }
} else {
    fade_alpha -= fade_speed;
    if (fade_alpha <= 0) {
        fade_alpha = 0;
        transition_complete = true;
    }
}
	
if (transition_complete) {
	instance_destroy();
	fade_out = true;
}