/// @description Insert description here
// You can write your code in this editor
var blood_sprites = [
    spr_blood_1,
    spr_blood_2,
	spr_blood_3
];

// Seleccionar aleatoriamente uno de los sprites
sprite_index = choose(spr_blood_1, spr_blood_2, spr_blood_3);

random_size = random_range(0.3, 1);
image_xscale = random_size;
image_yscale = random_size;
image_angle = irandom_range(0, 360);

depth = -30;