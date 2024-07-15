// Script assets have changed for v2.3.0 see

function scr_generate_map(){
	randomize();
	map = ds_grid_create(global.map_width, global.map_height);
	ds_grid_clear(map, 0);
	// Generar el mapa
	generate_rooms(global.rooms_quantity); // Generar habitaciones aleatoriamente

	connect_rooms();    // Conectar las habitaciones con pasillos más anchos
	draw_map();         // Dibujar el mapa generado

	place_big_chest(); // Agregar un cofre grande
}