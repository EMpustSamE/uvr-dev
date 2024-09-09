#define input_point
/// input_point(x:int, y:int)->bool
var _buf = InputPointer_prepare_buffer(8);
buffer_write(_buf, buffer_s32, argument0);
buffer_write(_buf, buffer_s32, argument1);
return input_point_raw(buffer_get_address(_buf));

