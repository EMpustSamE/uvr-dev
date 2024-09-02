draw_sprite_ext(spr_studio,0,320,240,1,1,0,c_white,0.5);
draw_rectangle_color(450,166,530,186,c_red,c_green,c_green,c_red,0);
draw_rectangle_color(531,166,531-80*(1-world.volume),186,c_black,c_black,c_black,c_black,0);
draw_sprite_ext(spr_pixel,0,450+80*world.volume,166,2,20,0,c_white,1);
/*draw_set_color(c_white);
draw_set_font(Lang_GetFont(Lang_GetString("font.menu.0")))
draw_text_transformed(465,159.5,string(round(world.volume*100))+"%",2,2,0);