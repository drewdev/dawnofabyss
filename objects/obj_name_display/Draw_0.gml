if (instance_exists(target_object)) {
    var text_width = string_width(name_text);
    var text_height = string_height(name_text);
    var padding = 10; // Padding around el texto

    // Obtener la posición del objeto en la vista actual
    var pos_x = target_object.x - text_width / 2;
    var pos_y = target_object.y - 10 - text_height - padding; // Ajustar la posición sobre el objeto

    // Dibujar el rectángulo de fondo semi-transparente
    draw_set_alpha(0.75); // Establecer transparencia
    draw_set_color(c_black);
    draw_rectangle(pos_x - padding, pos_y - padding, pos_x + text_width + padding, pos_y + text_height + padding, false);
    draw_set_alpha(1); // Restablecer transparencia

    // Dibujar el texto
    draw_set_font(fnt_object_name); // Asegúrate de tener una fuente adecuada
    draw_set_color(c_white);
    draw_text(pos_x, pos_y, name_text);
}
