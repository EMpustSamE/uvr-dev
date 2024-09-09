#define MuiltWindow_prepare_buffer
/// MuiltWindow_prepare_buffer(size:int)->buffer~
#args _size
_size = argument0
gml_pragma("global", "global.__MuiltWindow_buffer = undefined");
var _buf = global.__MuiltWindow_buffer;
if (_buf == undefined) {
    _buf = buffer_create(_size, buffer_grow, 1);
    global.__MuiltWindow_buffer = _buf;
} else if (buffer_get_size(_buf) < _size) {
    buffer_resize(_buf, _size);
}
buffer_seek(_buf, buffer_seek_start, 0);
return _buf;

#define windows_draw_surface
#args WindowID
#args SurfaceID
#args x
#args y
WindowID = argument0
SurfaceID = argument1
x = argument2
y = argument3
if(surface_exists(SurfaceID)){

	var surf_width = surface_get_width(SurfaceID)
	var surf_height = surface_get_height(SurfaceID)
	
	var buffer = buffer_create(surf_width * surf_height * 4, buffer_fixed, 1);
	
	buffer_get_surface(buffer, SurfaceID, 0);
	
	buffer_seek(buffer,buffer_seek_start,0)
	
	var address = int64(buffer_get_address(buffer))
	
	windows_set_surface_raw(WindowID,address,surf_width,surf_height,x,y)
	
	buffer_delete(buffer)

}

#define keyboard_check_direct_released
#args key
if !variable_global_exists("laststats_"+string(key)){
	variable_global_set("laststats_"+string(key),keyboard_check_direct(key));
}

if(variable_global_get("laststats_"+string(key)) != keyboard_check_direct(key)){

	if(keyboard_check_direct(key)){
		variable_global_set("laststats_"+string(key),keyboard_check_direct(key))
		return false;
	}else{
		variable_global_set("laststats_"+string(key),keyboard_check_direct(key))
		return true;
	}	
}
return false;

#define keyboard_check_direct_pressed
#args key
if !variable_global_exists("laststats_"+string(key)){
	variable_global_set("laststats_"+string(key),keyboard_check_direct(key));
}

if(variable_global_get("laststats_"+string(key)) != keyboard_check_direct(key)){

	if(keyboard_check_direct(key)){
		variable_global_set("laststats_"+string(key),keyboard_check_direct(key))
		return true;
	}else{
		variable_global_set("laststats_"+string(key),keyboard_check_direct(key))
		return false;
	}	
}
return false;