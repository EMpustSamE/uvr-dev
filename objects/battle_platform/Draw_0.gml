if (out = 0) {
    depth = DEPTH_BATTLE.BULLET;
    surface_set_target(Battle_GetBoardSurface()); {
        draw_sprite_ext(sprite_index, 1, x, y, width / 2, 1, angle, c_white, 1);
        draw_sprite_ext(sprite_index, 0, x - lengthdir_x(width / 2, angle), y - lengthdir_y(width / 2, angle), 0.5, 1, angle, c_white, 1);
        draw_sprite_ext(sprite_index, 0, x + lengthdir_x(width / 2, angle), y + lengthdir_y(width / 2, angle), 0.5, 1, angle, c_white, 1);
    }
    surface_reset_target();
} else {
    depth = DEPTH_BATTLE.BULLET_OUTSIDE_LOW;
    draw_sprite_ext(sprite_index, 1, x, y, width / 2, 1, angle, c_white, 1);
    draw_sprite_ext(sprite_index, 0, x - lengthdir_x(width / 2, angle), y - lengthdir_y(width / 2, angle), 0.5, 1, angle, c_white, 1);
    draw_sprite_ext(sprite_index, 0, x + lengthdir_x(width / 2, angle), y + lengthdir_y(width / 2, angle), 0.5, 1, angle, c_white, 1);
}