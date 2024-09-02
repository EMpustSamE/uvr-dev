///@arg border_var,choosen
function Border_GetName(){
	var _border = argument[0];
	var choosen = false;
	if(argument_count>=1){
		choosen = argument[1];
	}
	var result = "";
	if(!choosen){
		switch(_border){
			case 0:
				result = "{color `gray`}<{color `white`} None >";
				break;
			case 1:
				result = "< Simple {color `gray`}>";
				break;
		}
	}else{
		switch(_border){
			case 0:
				result = "{color `gray`}<{color `yellow`} None >";
				break;
			case 1:
				result = "{color `yellow`}< Simple {color `gray`}>";
				break;
		}
	}
	return(result);
}