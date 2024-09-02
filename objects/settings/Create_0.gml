live;

prefix="{font FONT.MENU}{instant true}{shadow true}{scale 2}{depth -9999}";//{align "+string(string_length(id.text)*12)+"}
title=noone;
language=noone;
language_index=noone;
window_size=noone;
window_size_index=noone;
volume=noone;
volume_index=noone;
fullscreen=noone;
fullscreen_index=noone;
fullscreen_text="";
if(window_get_fullscreen()){
	fullscreen_n=0;
}else{
	fullscreen_n=1;
}
border_obj=noone;
border_obj_index=noone;
border_var=0;
save=noone;
choice=0;

event_user(0);
