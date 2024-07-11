// Evento Draw de obj_level_display
draw_set_color(c_white);
draw_set_font(fnt_object_name); // Asegúrate de tener una fuente creada y asignada
draw_text(obj_player.x + -1200, obj_player.y + -650, "Nivel: " + string(global.level));
