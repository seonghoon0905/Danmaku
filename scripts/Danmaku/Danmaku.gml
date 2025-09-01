function Danmaku(_x, _y, _insts, _inside_rotation_param = undefined) constructor{
    x = _x;
    y = _y;
    
	xscale = 1;
    yscale = 1;
    
	right = {x : 1, y : 0};
	up = {x : 0, y : 1};
    
	roll = 0;
    
    inside_rotation_param = variable_clone(_inside_rotation_param);
    inside_rotation = 0;

    insts = [];
    image_alpha = 1;
    image_scale = 1;
    image_angle_sync = false;
    image_angle_sync_angle_adjust = 0;
    
    far_dist = -infinity;
    
    for(var _i = 0; _i < array_length(_insts); _i++){
        var _inst = _insts[_i];
        
        array_push(insts, {
            id : _inst.id,
            x : _inst.x - x, 
            y : _inst.y - y,
        });
        
        var _dist = point_distance(x, y, _inst.x, _inst.y);
        far_dist = _dist > far_dist ? _dist : far_dist;
    }
    
    function set_tag(_tag){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.tag = _tag;
        }
    }
    
    function set_additive(_additive){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.additive = _additive;
        }
    }
    
    function set_image_angle_sync(_angle_adjust){
        image_angle_sync = true;
        image_angle_sync_angle_adjust = _angle_adjust;
        
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            var _dir = point_direction(x, y, _inst.x, _inst.y) + image_angle_sync_angle_adjust;
            _inst.image_angle = _dir;
        }
    }
    
    function set_image_blend(_color){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.image_blend = _color;
        }
    }
    
    function set_image_blend_circular_mapping(_angle = 0, _min_hue = 0, _max_hue= 255, _sat = 255, _val = 255){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            var _dir = point_direction(x, y, _inst.x, _inst.y) + _angle;
            var _hue = lerp(_min_hue, _max_hue, _dir / 360);
            _inst.image_blend = make_color_hsv(_hue, _sat, _val);
        }
    }
    
    function set_image_xscale(_xscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.xscale = _xscale;
        }
    }
    
    function add_image_xscale(_dxscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.xscale += _dxscale;
        }
    }
    
    function set_image_yscale(_yscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.yscale = _yscale;
        }
    }
    
    function add_image_yscale(_dyscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.yscale += _dyscale;
        }
    }
    
    function set_image_scale(_scale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.xscale = _scale;
            _inst.yscale = _scale;
        }
    }
    
    function add_image_scale(_dscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.xscale += _dscale;
            _inst.yscale += _dscale;
        }
    }
    
    function set_particle(_dynamic_update, _fadeout, _size_decrease, _position_noise, _additive, _scale = 1, _alpha = 1, _interval = 5, _life = 25, _col = c_white){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            set_danmaku_particle(_inst, _dynamic_update, _fadeout, _size_decrease, _position_noise, _additive, _scale, _alpha, _interval, _life, _col);
        }
    }
	
	function set_position(_x, _y){
		x = _x;
		y = _y;
	}

	function add_position(_dx, _dy){
		x += _dx;
		y += _dy;
	}

    function set_scale(_scale){
		xscale = _scale;
		yscale = _scale;
	}
    
    function add_scale(_dscale){
		xscale += _dscale;
		yscale += _dscale;
	}
    
    function set_xscale(_xscale){
		xscale = _xscale;
	}
    
    function add_xscale(_dxscale){
		xscale += _dxscale;
	}
    
    function set_yscale(_yscale){
		yscale = _yscale;
	}
    
    function add_yscale(_dyscale){
		yscale += _dyscale;
	}
	
    function update_local_axes(){
		var _cr = dcos(roll); 
		var _sr = dsin(roll); 
		
		right.x = _cr;
		right.y = _sr;
		
		up.x = -_sr;
		up.y = _cr;
	}
	
	function get_axis_clamped_value(_value){
		_value = _value % 360;
		if(_value < 0){
			_value += 360;
		}
		return _value;
	}
	
	function set_rotation(_roll){
		roll = get_axis_clamped_value(_roll);
		update_local_axes();
	}
	
	function add_rotation(_droll){
		roll = get_axis_clamped_value(roll + _droll);
		update_local_axes();
	}
    
    function set_inside_rotation(_inside_rotation){
		inside_rotation = _inside_rotation;
        rotate_inside_danmaku(self, inside_rotation);
	}
	
	function add_inside_rotation(_inside_rotation){
		inside_rotation += _inside_rotation;
        rotate_inside_danmaku(self, inside_rotation);
	}
    
    function update_danmaku(){
        var _len = array_length(insts);
        for(var _i = 0; _i < _len; _i++){
            var _inst = insts[_i];
            _inst.id.x = right.x * xscale * _inst.x + up.x * yscale * _inst.y + x;
            _inst.id.y = right.y * xscale * _inst.x + up.y * yscale * _inst.y + y;
            
            _inst = _inst.id;
            
            if(image_angle_sync){
                var _dir = point_direction(x, y, _inst.x, _inst.y) + image_angle_sync_angle_adjust;
                _inst.image_angle = _dir;
            }
        }    
    }
    
    function explode(_spd, _inherit_particle = false, _tag = "default"){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            var _dir = point_direction(x, y, _inst.x, _inst.y);
            var _sub_inst = instance_create_layer(_inst.x, _inst.y, _inst.layer, _inst.object_index);
            
            _sub_inst.image_index = _inst.image_index;
            _sub_inst.image_xscale = _inst.image_xscale;
            _sub_inst.image_yscale = _inst.image_yscale;
            _sub_inst.image_blend = _inst.image_blend;
            _sub_inst.image_angle = _inst.image_angle;
            _sub_inst.image_blend = _inst.image_blend;    
            _sub_inst.image_alpha = _inst.image_alpha;
            _sub_inst.mask_index = _inst.mask_index;
            _sub_inst.direction = _dir;
            
            var _dist = point_distance(x, y, _inst.x, _inst.y);
            _sub_inst.speed = (_dist / far_dist) * _spd;
            
            if(object_is_ancestor(_sub_inst.object_index, obj_danmaku_parents)){
                _sub_inst.outsidekill = true;
                
                if(_inherit_particle && _inst.particle_emitter != undefined){
                    var _sy = _inst.particle_sync;
                    var _f = _inst.particle_fadeout;
                    var _sd = _inst.particle_size_decrease;
                    var _pn = _inst.particle_position_noise;
                    var _a = _inst.particle_additive;
                    var _s = _inst.particle_scale;
                    var _ap = _inst.particle_alpha;
                    var _it = _inst.particle_interval;
                    var _l = _inst.particle_life;
                    var _col = _inst.particle_color;
                    set_danmaku_particle(_sub_inst, _sy, _f, _sd, _pn, _a, _s, _ap, _it, _l, _col);
                }
            }
            
            if(_tag != "default"){
                _sub_inst.tag = _tag;
            }
        }
    }
    
    function destroy(){
        for(var _i = 0; _i < array_length(insts); _i++){
            instance_destroy(insts[_i].id);
        }
    }
}