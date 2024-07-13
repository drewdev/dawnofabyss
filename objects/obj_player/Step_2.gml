/// @description Insert description here

halfViewWidth = camera_get_view_width(view_camera[0]) / 2;
halfViewHeight = camera_get_view_height(view_camera[0]) / 2;

camera_set_view_pos(view_camera[0], x - halfViewWidth, y - halfViewHeight);

// Guardar la posición inicial de la cámara
global.view_xview_start = camera_get_view_x(view_camera[0]);
global.view_yview_start = camera_get_view_y(view_camera[0]);

// Aplicar screen shake
scr_screen_shake();
