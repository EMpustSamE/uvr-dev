timer++

txt.override_alpha=studio_a;
txt.x=_x;
txt.y=_y;


BGM_SetPitch(0,function(){return(fps/60)});

/*if(file_exists(working_directory/GAME_SAVE_NAME/"file0")&&Input_IsPressed(INPUT.CONFIRM)){
	room_goto_next();
}*/

if(_uvr_play){
	alarm[1]=60/20;
	_uvr_play=false;
}

if(timer<=410){
	_stx=random_range(318,322);
	_sty=random_range(238,242);
}else{
	if(_stc){
		Anim_Create(id,"_sty",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,240,-240,20);
		_stc=false;
	}
}

if(timer==30){
	Anim_Create(id,"_a",0,0,1,-1,60);
}

if(timer==80){
	_y=-35;
	Anim_Create(id,"_y",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,-35,315,30);
	txt.text+="{clear}"+Lang_GetString("logo.origin");
	Anim_Create(id,"_y",ANIM_TWEEN.CUBIC,ANIM_EASE.IN,280,-315,30,60);
}

if(timer==200){
	Anim_Create(id,"_y",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,-35,315,30);
	txt.text+="{clear}"+Lang_GetString("logo.ce");
	Anim_Create(id,"_y",ANIM_TWEEN.CUBIC,ANIM_EASE.IN,280,-315,30,60);
}

if(timer==320){
	Anim_Create(id,"_y",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,-35,315,30);
	txt.text+="{clear}"+Lang_GetString("logo.mm");
	Anim_Create(id,"_y",ANIM_TWEEN.CUBIC,ANIM_EASE.IN,280,-315,30,60);
}

if(timer==600){
	room_goto(room_menu);
}

ss.image_yscale+=5;
