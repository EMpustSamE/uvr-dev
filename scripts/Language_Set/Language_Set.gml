///@arg lang
function Language_Set(){
	var lang = argument[0];
	Lang_Uninit();
	Lang_Init();
	Lang_LoadList();
	Lang_LoadString(lang);
	Lang_LoadSprite(lang);
	Lang_LoadFont(lang);
	Encounter_Custom();
	global.language=lang;
	with(text_typer){
		event_user(5);
	}
	room_restart();
	Flag_Set(FLAG_TYPE.SETTINGS,FLAG_SETTINGS.LANGUAGE,lang);
	show_debug_message("language set")
	//Flag_Save(FLAG_TYPE.SETTINGS)
}