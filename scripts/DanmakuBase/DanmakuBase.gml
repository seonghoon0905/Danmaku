function DanmakuBase() constructor {
    insts = [];
    
    image_scale = 1;
    image_angle_sync = false;
    image_angle_sync_angle_adjust = 0;
    far_dist = -infinity;
    
    inside_rotation = 0;
    inside_rotation_param = undefined;

    static add_inst_base = function(_inst, _x, _y, _z = 0) {
        var _dist = point_distance(x, y, _inst.x, _inst.y);
        far_dist = _dist > far_dist ? _dist : far_dist;
    }

    static set_tag = function(_tag) {
        for (var _i = 0, _len = array_length(insts); _i < _len; _i++) {
            insts[_i].id.tag = _tag;
        }
    }

    static set_additive = function(_additive) {
        for (var _i = 0, _len = array_length(insts); _i < _len; _i++) {
            insts[_i].id.additive = _additive;
        }
    }
	
	static set_image_angle_sync = function(_angle_adjust){
        image_angle_sync = true;
        image_angle_sync_angle_adjust = _angle_adjust;
        
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            var _dir = point_direction(x, y, _inst.x, _inst.y) + image_angle_sync_angle_adjust;
            _inst.image_angle = _dir;
        }
    }

    static set_image_blend = function(_color) {
        for (var _i = 0, _len = array_length(insts); _i < _len; _i++) {
            insts[_i].id.image_blend = _color;
        }
    }
    
	static set_image_blend_circular_mapping = function(_angle = 0, _min_hue = 0, _max_hue= 255, _sat = 255, _val = 255){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            var _dir = point_direction(x, y, _inst.x, _inst.y) + _angle;
            var _hue = lerp(_min_hue, _max_hue, _dir / 360);
            _inst.image_blend = make_color_hsv(_hue, _sat, _val);
        }
    }
	
	
    static set_image_xscale = function(_xscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.xscale = _xscale;
        }
    }
    
    static add_image_xscale = function(_dxscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.xscale += _dxscale;
        }
    }
    
    static set_image_yscale = function(_yscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.yscale = _yscale;
        }
    }
    
    static add_image_yscale = function(_dyscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.yscale += _dyscale;
        }
    }
    
    static set_image_scale = function(_scale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.xscale = _scale;
            _inst.yscale = _scale;
        }
    }
    
    static add_image_scale = function(_dscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.xscale += _dscale;
            _inst.yscale += _dscale;
        }
    }
    
	
    static set_image_alpha = function(_alpha){
       for(var _i = 0; _i < array_length(insts); _i++){
           insts[_i].id.alpha = _alpha;
       }
    }
	
	static add_image_alpha = function(_dalpha){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.alpha += _dalpha;
        }
    }

    static set_collision = function(_collision){
       for(var _i = 0; _i < array_length(insts); _i++){
           insts[_i].id.collision = _collision;
       }
    }
    
    static set_particle = function(_dynamic_update, _fadeout, _size_decrease, _position_noise, _additive, _scale = 1, _alpha = 1, _interval = 5, _life = 25, _col = c_white, _sprite = undefined){
        for(var _i = 0; _i < array_length(insts); _i++){
            set_danmaku_particle(insts[_i].id, _dynamic_update, _fadeout, _size_decrease, _position_noise, _additive, _scale, _alpha, _interval, _life, _col, _sprite);
        }
    }
	
	static set_particle_color2 = function(_color1, _color2){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            set_danmaku_particle_color2(_inst, _color1, _color2);
        }
    }
	
	static set_particle_color3 = function(_color1, _color2, _color3){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            set_danmaku_particle_color3(_inst, _color1, _color2, _color3);
        }
    }
    
	static set_particle_horizontal_gradient = function(_min_x = 0, _max_x = DANMAKU_SCREEN_WIDTH, _min_hue = 0, _max_hue = 255, _sat = 255, _val = 255){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            set_danmaku_particle_horizontal_gradient(_inst, _min_x, _max_x, _min_hue, _max_hue, _sat, _val);
        }
    }
    
    static set_particle_vetrtical_gradient = function(_min_y = 0, _max_y = DANMAKU_SCREEN_HEIGHT, _min_hue = 0, _max_hue = 255, _sat = 255, _val = 255){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            set_danmaku_particle_vertical_gradient(_inst, _min_y, _max_y, _min_hue, _max_hue, _sat, _val);
        }
    }
    
    static set_particle_circular_gradient = function(_x = 400, _y = 304, _min_hue = 0, _max_hue = 255, _sat = 255, _val = 255, _dir_offset = 0){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            set_danmaku_particle_circular_gradient(_inst, _x, _y, _min_hue, _max_hue, _sat, _val, _dir_offset);
        }
    }
    
    static set_particle_sprite = function(_sprite){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            set_danmaku_particle_sprite(_inst, _sprite);
        }
    }
	
	static get_axis_clamped_value = function(_value){
		_value = _value % 360;
		if(_value < 0){
			_value += 360;
		}
		return _value;
	}
	
	static set_inside_rotation = function(_inside_rotation){
		inside_rotation = _inside_rotation;
        rotate_inside_danmaku(self, inside_rotation);
	}
	
	static add_inside_rotation = function(_inside_rotation){
		inside_rotation += _inside_rotation;
        rotate_inside_danmaku(self, inside_rotation);
	}
    
    static destroy = function(){
        for(var _i = 0; _i < array_length(insts); _i++){
            instance_destroy(insts[_i].id);
        }
    }
    
    static destroy_fadeout = function(_destroy_time = 30){
        for(var _i = 0; _i < array_length(insts); _i++){
            destroy_danmaku_fadeout(insts[_i].id, _destroy_time);
        }
    }
    
    static destroy_burst = function(_inst, _fadeout, _size_decrease, _additive, _min_spd = 3, _max_spd = 5, _scale = 1, _alpha = 1, _life = 5, _col = c_white, _sprite = undefined){
        for(var _i = 0; _i < array_length(insts); _i++){
            destroy_danmaku_burst(insts[_i].id, _fadeout, _size_decrease, _additive, _min_spd, _max_spd, _scale, _alpha, _life, _col, _sprite);
        }
    }
}