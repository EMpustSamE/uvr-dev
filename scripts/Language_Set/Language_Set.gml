///@arg lang
function Language_Set(){
Lang_LoadString(argument[0]);
Lang_LoadSprite(argument[0]);
Lang_LoadFont(argument[0]);
Encounter_Custom();
global.language=argument[0];
with(text_typer){
	event_user(5);
}
room_restart();
Flag_Set(FLAG_TYPE.SETTINGS,FLAG_SETTINGS.LANGUAGE,argument[0]);
show_debug_message("language set")
//Flag_Save(FLAG_TYPE.SETTINGS)
}