if(!surface_exists(surf)){
	surf=surface_create(640,480);
}

//surface_set_target(surf);
draw_set_font(font_mars_needs_cunnilingus);
draw_set_color(c_white);
draw_text(0,0,"Room:"+string(room)+","+string(room_get_name(room)));
draw_text(0,20,"fps:"+string(fps));
draw_text(0,40,"instance count:"+string(instance_count));
//draw_text(0,0,"Player moveable:"+instance_exists(char_player)?string(char_player.moveable):"undefinded");
//surface_reset_target();

//draw_surface(surf,0,0);
