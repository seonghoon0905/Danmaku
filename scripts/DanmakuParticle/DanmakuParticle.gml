function set_danmaku_particle(_inst, _dynamic_update, _fadeout, _size_decrease, _position_noise, _additive, _scale = 1, _interval = 5, _life = 25, _col = c_white){
    if(!ENABLE_PARTICLE_SYSTEM){
        return;
    }
    
    part_system_draw_order(global.danmaku_particle_system, true);
    
    with(_inst){
        var _type = part_type_create();
        
        part_type_sprite(_type, sprite_index, false, true, false);
        var _decrease_spd = _size_decrease ? -image_xscale / _life: 0;
        part_type_size_x(_type, image_xscale * _scale, image_xscale * _scale, _decrease_spd, 0);
        _decrease_spd = _size_decrease ? -image_yscale / _life: 0;
        part_type_size_y(_type, image_yscale * _scale, image_yscale * _scale, _decrease_spd, 0);
        part_type_orientation(_type, image_angle, image_angle, 0, 0, 0);
        part_type_colour1(_type, _col == c_white ? image_blend : _col);
        part_type_alpha2(_type, image_alpha, _fadeout ? 0 : image_alpha);
        part_type_blend(_type, _additive);
        part_type_life(_type, _life, _life);
        
        particle_emitter = part_emitter_create(global.danmaku_particle_system);
        
        var _dx = _position_noise ? sprite_width / 8 : 0.5;
        var _dy = _position_noise ? sprite_height / 8 : 0.5;
        part_emitter_region(global.danmaku_particle_system, particle_emitter, x - _dx, x + _dx, y - _dy, y + _dy, ps_shape_ellipse, ps_distr_linear);
        part_emitter_stream(global.danmaku_particle_system, particle_emitter, _type, 1);
        part_emitter_interval(global.danmaku_particle_system, particle_emitter, _interval, _interval, time_source_units_frames);
        
        particle_sync = _dynamic_update;
        particle_type = _dynamic_update ? variable_clone(_type) : undefined;
        particle_fadeout = _fadeout;
        particle_size_decrease = _size_decrease;
        particle_position_noise = _position_noise;
        particle_additive = _additive;
        particle_scale = _scale;
        particle_interval = _interval;
        particle_life = _life;   
        particle_color = _col;
    }
}