function set_danmaku_particle_system_depth(_depth){
    part_system_depth(global.danmaku_particle_system, _depth);
}

function set_danmaku_particle_system_layer(_layer_id){
    part_system_depth(global.danmaku_particle_system, layer_get_depth(_layer_id));
}

function set_danmaku_particle(_inst, _dynamic_update, _fadeout, _size_decrease, _position_noise, _additive, _scale = 1, _alpha = 1, _interval = 5, _life = 25, _col = c_white, _sprite = undefined){
    if(!ENABLE_PARTICLE_SYSTEM){
        return;
    }
    
    if(!object_is_ancestor(_inst.object_index, obj_danmaku_parents)){
        return;
    }
    
    part_system_draw_order(global.danmaku_particle_system, true);
    
    with(_inst){
        var _type = part_type_create();
        
        part_type_sprite(_type, _sprite == undefined ? sprite_index : _sprite, false, true, false);
        var _decrease_spd = _size_decrease ? -image_xscale / _life: 0;
        part_type_size_x(_type, image_xscale * _scale, image_xscale * _scale, _decrease_spd, 0);
        _decrease_spd = _size_decrease ? -image_yscale / _life: 0;
        part_type_size_y(_type, image_yscale * _scale, image_yscale * _scale, _decrease_spd, 0);
        part_type_orientation(_type, image_angle, image_angle, 0, 0, 0);
        part_type_colour1(_type, _col == c_white ? image_blend : _col);
        part_type_alpha2(_type, image_alpha * alpha * _alpha, _fadeout ? 0 : image_alpha * alpha * _alpha);
        part_type_blend(_type, _additive);
        part_type_life(_type, _life, _life);
        
        particle_emitter = part_emitter_create(global.danmaku_particle_system);
        
        var _dx = _position_noise ? sprite_width / 8 : 0.5;
        var _dy = _position_noise ? sprite_height / 8 : 0.5;
        part_emitter_region(global.danmaku_particle_system, particle_emitter, x - _dx, x + _dx, y - _dy, y + _dy, ps_shape_ellipse, ps_distr_linear);
        part_emitter_stream(global.danmaku_particle_system, particle_emitter, _type, 1);
        part_emitter_interval(global.danmaku_particle_system, particle_emitter, _interval, _interval, time_source_units_frames);
        
        particle_sync = _dynamic_update;
        particle_type = variable_clone(_type);
        particle_fadeout = _fadeout;
        particle_size_decrease = _size_decrease;
        particle_position_noise = _position_noise;
        particle_additive = _additive;
        particle_scale = _scale;
        particle_alpha = _alpha;
        particle_interval = _interval;
        particle_life = _life;   
        particle_color = _col;
        particle_color_type = 0;
        particle_sprite = _sprite;
    }
}

function set_danmaku_particle_color2(_inst, _color1, _color2){
    if(_inst.particle_emitter == undefined){
        return;    
    }    
    
    with(_inst){
        particle_color_type = 1;
        particle_sub_color1 = _color1;
        particle_sub_color2 = _color2;
    }
}

function set_danmaku_particle_color3(_inst, _color1, _color2, _color3){
    if(_inst.particle_emitter == undefined){
        return;    
    }    
    
    with(_inst){
        particle_color_type = 2;
        particle_sub_color1 = _color1;
        particle_sub_color2 = _color2;
        particle_sub_color3 = _color3;
    }
}


function set_danmaku_particle_horizontal_gradient(_inst, _min_x = 0, _max_x = DANMAKU_SCREEN_WIDTH, _min_hue = 0, _max_hue = 255, _sat = 255, _val = 255){
    if(_inst.particle_emitter == undefined){
        return;    
    }    
    
    with(_inst){ 
        particle_color_type = 3; 
        particle_min_x = _min_x; 
        particle_max_x = _max_x;
        particle_min_hue = _min_hue;
        particle_max_hue = _max_hue;
        particle_sat = _sat;
        particle_val = _val;
    }
}

function set_danmaku_particle_vertical_gradient(_inst, _min_y = 0, _max_y = DANMAKU_SCREEN_HEIGHT, _min_hue = 0, _max_hue = 255, _sat = 255, _val = 255){
    if(_inst.particle_emitter == undefined){
        return;    
    }    
    
    with(_inst){
        particle_color_type = 4;
        particle_min_y = _min_y;
        particle_max_y = _max_y;
        particle_min_hue = _min_hue;
        particle_max_hue = _max_hue;
        particle_sat = _sat;
        particle_val = _val;
    }
}

function set_danmaku_particle_circular_gradient(_inst, _x = DANMAKU_SCREEN_WIDTH / 2, _y = DANMAKU_SCREEN_HEIGHT / 2, _min_hue = 0, _max_hue = 255, _sat = 255, _val = 255, _dir_offset = 0){
    if(_inst.particle_emitter == undefined){
        return;
    }
    
    with(_inst){
        particle_color_type = 5;
        particle_center_x = _x;
        particle_center_y = _y;
        particle_min_hue = _min_hue;
        particle_max_hue = _max_hue;
        particle_sat = _sat;
        particle_val = _val;
        particle_dir_offset = _dir_offset;
    }
}
