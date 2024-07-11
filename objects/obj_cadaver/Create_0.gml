/// @description Inicializar el objeto cadáver
// Lista de sprites de cadáveres
var cadaver_sprites = [
    spr_cadaver_1,
    spr_cadaver_2,
    spr_cadaver_3
];

// Seleccionar aleatoriamente uno de los sprites
sprite_index = choose(spr_cadaver_1, spr_cadaver_2, spr_cadaver_3);

// Voltear horizontal y/o verticalmente aleatoriamente
image_xscale = choose(-1, 1);
depth = -30;