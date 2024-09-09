#define windows_create
/// windows_create(title:string, windowWidth:int, windowHeight:int)->int 
var _buf = MuiltWindow_prepare_buffer(9);
buffer_write(_buf, buffer_s32, argument1);
buffer_write(_buf, buffer_s32, argument2);
return windows_create_raw(buffer_get_address(_buf), argument0);

#define windows_show
/// windows_show(windowID:int)->int
var _buf = MuiltWindow_prepare_buffer(4);
buffer_write(_buf, buffer_s32, argument0);
return windows_show_raw(buffer_get_address(_buf));

#define windows_get_x
/// windows_get_x(windowID:int)->int
var _buf = MuiltWindow_prepare_buffer(4);
buffer_write(_buf, buffer_s32, argument0);
return windows_get_x_raw(buffer_get_address(_buf));

#define windows_get_y
/// windows_get_y(windowID:int)->int
var _buf = MuiltWindow_prepare_buffer(4);
buffer_write(_buf, buffer_s32, argument0);
return windows_get_y_raw(buffer_get_address(_buf));

#define windows_get_width
/// windows_get_width(windowID:int)->int
var _buf = MuiltWindow_prepare_buffer(4);
buffer_write(_buf, buffer_s32, argument0);
return windows_get_width_raw(buffer_get_address(_buf));

#define windows_get_height
/// windows_get_height(windowID:int)->int
var _buf = MuiltWindow_prepare_buffer(4);
buffer_write(_buf, buffer_s32, argument0);
return windows_get_height_raw(buffer_get_address(_buf));

#define windows_set_pos
/// windows_set_pos(windowID:int, x:int, y:int)->int
var _buf = MuiltWindow_prepare_buffer(12);
buffer_write(_buf, buffer_s32, argument0);
buffer_write(_buf, buffer_s32, argument1);
buffer_write(_buf, buffer_s32, argument2);
return windows_set_pos_raw(buffer_get_address(_buf));

#define windows_set_size
/// windows_set_size(windowID:int, width:int, height:int)->int
var _buf = MuiltWindow_prepare_buffer(12);
buffer_write(_buf, buffer_s32, argument0);
buffer_write(_buf, buffer_s32, argument1);
buffer_write(_buf, buffer_s32, argument2);
return windows_set_size_raw(buffer_get_address(_buf));

#define windows_set_surface_raw
/// windows_set_surface_raw(windowID:int, _pBuffer:int, width:int, height:int, x:int, y:int)->int
var _buf = MuiltWindow_prepare_buffer(24);
buffer_write(_buf, buffer_s32, argument0);
buffer_write(_buf, buffer_s32, argument1);
buffer_write(_buf, buffer_s32, argument2);
buffer_write(_buf, buffer_s32, argument3);
buffer_write(_buf, buffer_s32, argument4);
buffer_write(_buf, buffer_s32, argument5);
return windows_set_surface_raw_raw(buffer_get_address(_buf));

#define windows_returnMain
/// windows_returnMain()->int
var _buf = MuiltWindow_prepare_buffer(1);
return windows_returnMain_raw(buffer_get_address(_buf));

#define windows_get_screen_width
/// windows_get_screen_width()->int
var _buf = MuiltWindow_prepare_buffer(1);
return windows_get_screen_width_raw(buffer_get_address(_buf));

#define windows_get_screen_height
/// windows_get_screen_height()->int
var _buf = MuiltWindow_prepare_buffer(1);
return windows_get_screen_height_raw(buffer_get_address(_buf));

