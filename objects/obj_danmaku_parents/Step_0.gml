if(zspeed != 0){
    z += zspeed;
}

if(direction_speed != 0){
    direction += direction_speed;
}

if(ENABLE_PARTICLE_SYSTEM && particle_emitter != undefined){
    if(particle_sync){
        var _decrease_spd = particle_size_decrease ? -image_xscale / particle_life : 0;
        part_type_size_x(particle_type, image_xscale * particle_scale, image_xscale * particle_scale, _decrease_spd, 0);
        _decrease_spd = particle_size_decrease ? -image_yscale / particle_life : 0;
        part_type_size_y(particle_type, image_yscale * particle_scale, image_yscale * particle_scale, _decrease_spd, 0);
        part_type_orientation(particle_type, image_angle * alpha, image_angle * alpha, 0, 0, 0);
        part_type_alpha2(particle_type, image_alpha * particle_alpha, particle_fadeout ? 0 : image_alpha * particle_alpha);
        if(particle_color_type == 0){
            part_type_color1(particle_type, particle_color == c_white ? image_blend : particle_color);
        }
    }
    
    switch(particle_color_type){
        case 1:
            part_type_color2(particle_type, particle_sub_color1, particle_sub_color2);
            break;
        case 2:
            part_type_color3(particle_type, particle_sub_color1, particle_sub_color2, particle_sub_color3);
            break;
        case 3:
            var _amount = clamp(x, particle_min_x, particle_max_x) - particle_min_x;
            _amount /= particle_max_x - particle_min_x;
            var _hue = lerp(particle_min_hue, particle_max_hue, _amount);
            part_type_color1(particle_type, make_color_hsv(_hue, particle_sat, particle_val));
            break;
        case 4:
            var _amount = clamp(y, particle_min_y, particle_max_y) - particle_min_y;
            _amount /= particle_max_y - particle_min_y;
            var _hue = lerp(particle_min_hue, particle_max_hue, _amount);
            part_type_color1(particle_type, make_color_hsv(_hue, particle_sat, particle_val));
            break;
        case 5:
            var _dir = point_direction(particle_center_x, particle_center_y, x, y);
            var _hue = lerp(particle_min_hue, particle_max_hue, danmaku_get_axis_clamped_value(_dir + particle_dir_offset) / 360);
            part_type_color1(particle_type, make_color_hsv(_hue, particle_sat, particle_val));
            break;
    }
    
    var _dx = particle_position_noise ? sprite_width / 8 : 0.5;
    var _dy = particle_position_noise ? sprite_height / 8 : 0.5;
    part_emitter_region(global.danmaku_particle_system, particle_emitter, x - _dx, x + _dx, y - _dy, y + _dy, ps_shape_ellipse, ps_distr_linear);
}

if(enable_projection && z != DANMAKU_FOCAL_LENGTH && z > DANMAKU_ZNEAR && z < DANMAKU_ZFAR){
    var _scale = DANMAKU_FOCAL_LENGTH / z;
    
    image_xscale = _scale * xscale;
    image_yscale = _scale * yscale;
}
else{
    image_xscale = xscale;
    image_yscale = yscale;
}
    
if(!enable_collision_over_focal_length){
    var _epsilon = 1;
    
    if(z > DANMAKU_FOCAL_LENGTH + _epsilon){
        mask_index = spr_danmaku_noone;
    }    
    else{
        mask_index = sprite_index;
    }

    var _alpha = z > DANMAKU_FOCAL_LENGTH + _epsilon ? DANMAKU_INCOLLIDABLE_BULLET_ALPHA : 1;
    image_alpha += (_alpha - image_alpha) / 10;
}

if(!collision){
    mask_index = spr_danmaku_noone;
}

if(destroy){
    if(destroy_time > 0){
        destroy_time--;
    }
    else{
        instance_destroy();
    }
    alpha = lerp(0, destroy_alpha, destroy_time / destroy_time_limit);
}