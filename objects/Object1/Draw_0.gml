var sur = surface_create(1000,1000)
surface_set_target(sur)
draw_text(10,10,"This is another window")
surface_reset_target()
windows_draw_surface(testWindow,sur,0,0)