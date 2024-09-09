global.debug=true;
global.language=LANGUAGE.ENGLISH;

//if(global.debug){
	instance_create_depth(0,0,0,obj_debug);
//}

Anim_Init();
Bezier_Init();
Shop_Init();

Input_Init();
Input_Bind(INPUT.CONFIRM,INPUT_TYPE.KEYBOARD,0,vk_enter);
Input_Bind(INPUT.CONFIRM,INPUT_TYPE.KEYBOARD,0,ord("Z"));
Input_Bind(INPUT.CANCEL,INPUT_TYPE.KEYBOARD,0,vk_shift);
Input_Bind(INPUT.CANCEL,INPUT_TYPE.KEYBOARD,0,ord("X"));
Input_Bind(INPUT.MENU,INPUT_TYPE.KEYBOARD,0,vk_control);
Input_Bind(INPUT.MENU,INPUT_TYPE.KEYBOARD,0,ord("C"));
Input_Bind(INPUT.UP,INPUT_TYPE.KEYBOARD,0,vk_up);
Input_Bind(INPUT.DOWN,INPUT_TYPE.KEYBOARD,0,vk_down);
Input_Bind(INPUT.LEFT,INPUT_TYPE.KEYBOARD,0,vk_left);
Input_Bind(INPUT.RIGHT,INPUT_TYPE.KEYBOARD,0,vk_right);
Flag_Init();

Encounter_Init();

Lang_Init();
Lang_LoadList();
var def_lang;
switch(os_get_language()){
	case "en":
		def_lang=0;
		break;
	case "zh":
		def_lang=1;
		break;
}
Flag_Load(FLAG_TYPE.SETTINGS,FLAG_SETTINGS.LANGUAGE);
Language_Set(Flag_Get(FLAG_TYPE.SETTINGS,FLAG_SETTINGS.LANGUAGE,1));

BGM_Init();

Dialog_Init();

Demo_Init();

instance_create_depth(0,0,0,camera);
instance_create_depth(0,0,0,fader);
instance_create_depth(0,0,0,border);
instance_create_depth(0,0,0,closed_captions);

application_surface_draw_enable(false);

//Border_SetEnabled(true);

Flag_Load(FLAG_TYPE.SETTINGS);
volume = Flag_Get(FLAG_TYPE.SETTINGS,FLAG_SETTINGS.VOLUME,1);
window_size = Flag_Get(FLAG_TYPE.SETTINGS,FLAG_SETTINGS.WINDOW_SIZE,1);

randomize();

room_goto_next();