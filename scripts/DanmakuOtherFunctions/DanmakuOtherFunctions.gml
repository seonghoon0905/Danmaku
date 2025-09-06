function destroy_danmaku_fadeout(_inst, _destroy_time = 30){
    if(!object_is_ancestor(_inst.object_index, obj_danmaku_parents)){
        return;
    }
    
    with(_inst){
        outsidekill = false;
        destroy = true;
        destroy_time = _destroy_time;
        destroy_time_limit = _destroy_time;
        destroy_alpha = alpha;
    }
}

function destroy_danmaku_burst(_inst, _fadeout, _size_decrease, _additive, _amount = 7, _min_spd = 0.5, _max_spd = 2.5, _scale = 1, _alpha = 1, _life = 25, _col = c_white, _sprite = undefined){
    if(!ENABLE_PARTICLE_SYSTEM){
        return;
    }
    
    if(!object_is_ancestor(_inst.object_index, obj_danmaku_parents)){
        return;
    }
    
    with(_inst){
        outsidekill = false;
        
        if(particle_emitter != undefined){ 
            part_emitter_destroy(global.danmaku_particle_system, particle_emitter);
        }
        
        var _type = part_type_create();
        part_type_sprite(_type, _sprite == undefined ? sprite_index : _sprite, false, true, false);
        var _decrease_spd = _size_decrease ? -image_xscale / _life: 0;
        part_type_size_x(_type, image_xscale * _scale, image_xscale * _scale, _decrease_spd, 0);
        _decrease_spd = _size_decrease ? -image_yscale / _life: 0;
        part_type_size_y(_type, image_yscale * _scale, image_yscale * _scale, _decrease_spd, 0);
        part_type_speed(_type, _min_spd, _max_spd, 0, 0);
        part_type_direction(_type, 0, 360, 0, 0);
        
        part_type_colour1(_type, _col == c_white ? image_blend : _col);
        part_type_alpha2(_type, image_alpha * alpha * _alpha, _fadeout ? 0 : image_alpha * alpha * _alpha);
        part_type_blend(_type, _additive);
        part_type_life(_type, _life, _life);
        
        particle_emitter = part_emitter_create(global.danmaku_particle_system);
        part_emitter_region(global.danmaku_particle_system, particle_emitter, x - 0.5, x + 0.5, y - 0.5, y + 0.5, ps_shape_ellipse, ps_distr_linear);
        part_emitter_burst(global.danmaku_particle_system, particle_emitter, _type, _amount);
        
        instance_destroy();
    }
}

function danmaku_pseudo_random(_x, _seed){
	return abs(frac(sin(_x) * _seed));
}

function danmaku_smoothstep(_edge1, _edge2, _x){
	var _y = clamp(0, (_x - _edge1) / (_edge2 - _edge1), 1);
	return _y * _y * _y * (_y * (_y * 6 - 15) + 10);
}

function danmaku_noise(_x, _seed){
	var _a = pseudo_random(floor(_x), _seed);
	var _b = pseudo_random(floor(_x + 1), _seed);
	return lerp(_a, _b, danmaku_smoothstep(0, 1, frac(_x)));
}

function danmaku_get_axis_clamped_value(_value){
    _value = _value % 360;
    if(_value < 0){
        _value += 360;
    }
    return _value;
}