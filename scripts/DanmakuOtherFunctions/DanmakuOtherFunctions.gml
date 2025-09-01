function set_bullet_afterimage(_bullet_obj, _fadeout, _size_decrease, _dark, _position_noise, _glow, _scale = 1, _delay = 5, _life = 20, _tag = "default"){
    if(!object_is_ancestor(_bullet_obj, obj_danmaku_parents)){
        return;
    }
    
    with(_bullet_obj){
        if(_tag != tag){
            return;
        }
        
        enable_afterimage = true;
        
        afterimage_fadeout = _fadeout;
        afterimage_size_decrease = _size_decrease;
        afterimage_dark = _dark;
        afterimage_position_noise = _position_noise;
        afterimage_glow = _glow; 
        
        afterimage_scale = _scale;
        afterimage_delay = _delay;
        afterimage_life_limit = _life; 
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