randomize(); // Inicializar la semilla aleatoria
global.clicked_exit = false; // Inicializar la variable global

// Inicializar las variables globales del mapa
global.map_width = 30;
global.map_height = 30;

// Tamaño de la ventana del juego
window_width = 1280; // Ancho de la ventana
window_height = 720; // Alto de la ventana

// nivel actual
// Evento Create de obj_controller
global.level = 1;


// Configuración de la vista
view_enabled = true;
view_visible[0] = true;
view_wview[0] = window_width;
view_hview[0] = window_height;
view_wport[0] = window_width;
view_hport[0] = window_height;
view_hborder[0] = window_width / 2;
view_vborder[0] = window_height / 2;

// Crear la cámara
instance_create_layer(0, 0, "Instances", obj_camera);



// Tamaño de las habitaciones
global.min_room_size = 2;
global.max_room_size = 3;

// Ancho de los pasillos
global.passage_width = irandom_range(1, 2);

// Crear una lista global para almacenar habitaciones
global.library_quantity = irandom_range(1, 2)
global.rooms_quantity = irandom_range(6, 9)
global.rooms = ds_list_create();

// Inicializar el mapa vacío
function create_new_map() {
	scr_generate_map();
	global.map_width += irandom_range(1,2);
	global.map_height += irandom_range(1,2);
	if (global.level mod 2 == 0) {
		global.rooms_quantity += irandom_range(0,1);
		global.max_room_size += irandom_range(0,1);
	}
	if (global.level mod 3 == 0) {
		global.library_quantity += 1;
	}
	instance_create_layer(0, 0, "Instances", obj_level_display);
}

create_new_map();