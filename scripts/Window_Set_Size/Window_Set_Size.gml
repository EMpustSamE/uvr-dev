///@arg window_size
function Window_Set_Size(){
	var window_size=argument[0];
	world._window_size=window_size;
	Flag_Set(FLAG_TYPE.SETTINGS,FLAG_SETTINGS.WINDOW_SIZE,window_size);
	//Flag_Save(FLAG_TYPE.SETTINGS);
	switch(window_size){
		case 0:
			window_set_size(640,480);
			break;
		case 1:
			window_set_size(960,720);
			break;
		case 2:
			window_set_size(1280,960);
			break;
	}
}