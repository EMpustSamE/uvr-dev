///@arg enabled,blur
function Border_SetEnabled() {
	var ENABLED=argument[0];

	if(ENABLED){
		switch(world.window_size){
			case 1:
				window_set_size(960,540);
				break;
			case 1.5:
				window_set_size(1440,1080);
				break;
			case 2:
				window_set_size(1920,1440);
				break;
		}
		border._enabled=true;
		border.blur=argument[1]
	}else{
		switch(world.window_size){
			case 1:
				window_set_size(640,480);
				break;
			case 1.5:
				window_set_size(960,720);
				break;
			case 2:
				window_set_size(1280,960);
				break;
		}
		border._enabled=false;
	
		if(sprite_exists(border._sprite)){
			sprite_flush(border._sprite);
			border._sprite=-1;
		}
		if(sprite_exists(border._sprite_previous)){
			sprite_flush(border._sprite_previous);
			border._sprite_previous=-1;
		}
	}
	
	return true;


}
