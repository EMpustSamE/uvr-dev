live;

/*if(instance_exists(title)){
	instance_destroy(title);
}
if(instance_exists(language)){
	instance_destroy(language);
}
if(instance_exists(language_index)){
	instance_destroy(language_index);
}
if(instance_exists(window_size)){
	instance_destroy(window_size);
}
if(instance_exists(window_size_index)){
	instance_destroy(window_size_index);
}
if(instance_exists(volume)){
	instance_destroy(volume);
}
if(instance_exists(volume_index)){
	instance_destroy(volume_index);
}
if(instance_exists(fullscreen)){
	instance_destroy(fullscreen);
}
if(instance_exists(fullscreen_index)){
	instance_destroy(fullscreen_index);
}
if(instance_exists(border_obj)){
	instance_destroy(border_obj);
}
if(instance_exists(border_obj_index)){
	instance_destroy(border_obj_index);
}
if(instance_exists(save)){
	instance_destroy(save);
}*/
with(text_typer){
	instance_destroy();
}

title=instance_create_depth(320,30,0,text_typer);
language=instance_create_depth(70,80,0,text_typer);
language_index=instance_create_depth(450,80,0,text_typer);
window_size=instance_create_depth(70,120,0,text_typer);
window_size_index=instance_create_depth(450,120,0,text_typer);
volume=instance_create_depth(70,160,0,text_typer);
volume_index=instance_create_depth(465,159.5,0,text_typer);
fullscreen=instance_create_depth(70,200,0,text_typer);
fullscreen_index=instance_create_depth(450,200,0,text_typer);
border_obj=instance_create_depth(70,240,0,text_typer);
border_obj_index=instance_create_depth(450,240,0,text_typer);
save=instance_create_depth(70,280,0,text_typer);

title.text=(prefix+"{align 1}"+Lang_GetString("settings.title"));
if(choice==0){
	language.text=prefix+Lang_GetString("settings.language.choice")
	language_index.text=prefix+Lang_GetString("settings.language_index.choice")
}else{
	language.text=(prefix+Lang_GetString("settings.language"));
	language_index.text=(prefix+Lang_GetString("settings.language_index"));
}
if(choice==1){
	window_size.text=prefix+Lang_GetString("settings.window_size.choice");
	switch(window_size_n){
		case 1:
			window_size_index.text=prefix+"{color `gray`}<{color `yellow`} 1x >";
			break;
		case 1.5:
			window_size_index.text=prefix+"{color `yellow`}< 1.5x >";
			break;
		case 2:
			window_size_index.text=prefix+"{color `yellow`}< 2x {color `gray`}>";
			break;
	}
}else{
	window_size.text=prefix+Lang_GetString("settings.window_size");
	switch(window_size_n){
		case 1:
			window_size_index.text=prefix+"{color `gray`}<{color `white`} 1x >";
			break;
		case 1.5:
			window_size_index.text=prefix+"< 1.5x >";
			break;
		case 2:
			window_size_index.text=prefix+"< 2x {color `gray`}>";
			break;
	}
	window_size_index.text=prefix+"{color `gray`}<{color `white`} 1x >";
}
if(choice==2){
	volume.text=prefix+Lang_GetString("settings.volume.choice");
	volume_index.text=prefix+"{color `yellow`}"+string(round(world.volume*100))+"%";
}else{
	volume.text=prefix+Lang_GetString("settings.volume");
	volume_index.text=prefix+string(round(world.volume*100))+"%";
}
if(choice==3){
	fullscreen.text=prefix+Lang_GetString("settings.fullscreen.choice");
	fullscreen_index.text=prefix+fullscreen_text;
}else{
	fullscreen.text=prefix+Lang_GetString("settings.fullscreen");
	fullscreen_index.text=prefix+fullscreen_text;
}
if(choice==4){
	border_obj.text=prefix+Lang_GetString("settings.border.choice");
	border_obj_index.text=prefix+Border_GetName(border_var,true);
}else{
	border_obj.text=prefix+Lang_GetString("settings.border");
	border_obj_index.text=prefix+Border_GetName(border_var);
}
if(choice==5){
	save.text=prefix+Lang_GetString("settings.save.choice");
}else{
	save.text=prefix+Lang_GetString("settings.save");
}