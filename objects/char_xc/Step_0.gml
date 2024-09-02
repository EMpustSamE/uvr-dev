event_inherited();

global.char_name=function(timer,result){
	static timer = 0;
	timer++;
	if(timer/600==0){
		result="Cross"
	}else{
		result="Chara"
	}return(result)
};