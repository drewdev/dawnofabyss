// Tamaño de la vista y el puerto (ajusta según tu resolución)
view_width = 2560;
view_height = 1440;
//view_width = 6000;
//view_height = 6000;


// Crear la cámara
camera = camera_create_view(0, 0, view_width, view_height, 0, -1, -1, -1, 0, 0);

// Asignar la cámara a la vista
view_camera[0] = camera;
view_set_visible(0, true);

