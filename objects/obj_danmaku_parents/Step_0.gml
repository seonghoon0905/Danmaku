if(direction_speed != 0){
    direction += direction_speed;
}

if(ENABLE_PARTICLE_SYSTEM && particle_emitter != undefined){
    if(particle_sync){
        var _decrease_spd = particle_size_decrease ? -image_xscale / particle_life : 0;
        part_type_size_x(particle_type, image_xscale * particle_scale, image_xscale * particle_scale, _decrease_spd, 0);
        _decrease_spd = particle_size_decrease ? -image_yscale / particle_life : 0;
        part_type_size_y(particle_type, image_yscale * particle_scale, image_yscale * particle_scale, _decrease_spd, 0);
        part_type_orientation(particle_type, image_angle, image_angle, 0, 0, 0);
        part_type_color1(particle_type, particle_color == c_white ? image_blend : particle_color);
        part_type_alpha2(particle_type, image_alpha * particle_alpha, particle_fadeout ? 0 : image_alpha * particle_alpha);
    }
    
    var _dx = particle_position_noise ? sprite_width / 8 : 0.5;
    var _dy = particle_position_noise ? sprite_height / 8 : 0.5;
    part_emitter_region(global.danmaku_particle_system, particle_emitter, x - _dx, x + _dx, y - _dy, y + _dy, ps_shape_ellipse, ps_distr_linear);
}

if(enable_projection && z != DANMAKU_FOCAL_LENGTH){
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
    