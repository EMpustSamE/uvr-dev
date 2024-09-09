event_inherited();

/*BATTLE_TURN_SCRIPT{
	Battle_MakeBoneWallBottom(20,20,10);
}
Battle_TurnWait(60);
BATTLE_TURN_SCRIPT{
	Battle_MakeBoneH(320,240,10,0,0,0,0,0,1);
}*/
if(battle._turn_count_time>battle._turn_time){
	exit;
	event_perform(ev_step,0);
}else if(battle._turn_count_time<battle._turn_time){
	battle._turn_count_time=battle._turn_time;
}else if(battle._turn_count_time==battle._turn_time){
	Battle_MakeBoneWallBottom(20,20,10);
}
Battle_TurnWait(60);
if(battle._turn_count_time>battle._turn_time){
	exit;
	event_perform(ev_step,0);
}else if(battle._turn_count_time<battle._turn_time){
	battle._turn_count_time=battle._turn_time;
}else if(battle._turn_count_time==battle._turn_time){
	Battle_MakeBoneH(320,240,10,0,0,0,0,0,1);
}