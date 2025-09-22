function Danmaku3D(_x, _y, _z, _insts, _inside_rotation_param = undefined) constructor{
    x = _x; 
    y = _y; 
    z = _z;
    
	xscale = 1;
    yscale = 1;
    zscale = 1;
    
	right = {x : 1, y : 0, z : 0};
	up = {x : 0, y : 1, z : 0};
    forward = {x : 0, y : 0, z : 1};
    
    yaw = 0;
	pitch = 0;
	roll = 0;
    
    inside_rotation_param = variable_clone(_inside_rotation_param);
    inside_rotation = 0;
    
    insts = [];
    image_scale = 1;
    image_angle_sync = false;
    image_angle_sync_angle_adjust = 0;
    
    far_dist = -infinity;
    
    static add_inst = function(_inst){
        _inst.enable_projection = true;
        _inst.enable_collision_over_focal_length = false;
        
        array_push(insts, {
            id : _inst.id,
            x : _inst.x - x, 
            y : _inst.y - y,
            z : _inst.z - z
        });
        
        var _dist = point_distance(x, y, _inst.x, _inst.y);
        far_dist = _dist > far_dist ? _dist : far_dist;
    }
    
    for(var _i = 0; _i < array_length(_insts); _i++){
        add_inst(_insts[_i]);
    }
    
    static enable_projection = function(_bool){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.enable_projection = _bool;
        }
    }
    
    static enable_collision_over_focal_length = function(_bool){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.enable_collision_over_focal_length = _bool;
        }
    }
    
    static set_tag = function(_tag){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.tag = _tag;
        }
    }
    
    static set_additive = function(_additive){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.additive = _additive;
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
    
    static set_image_blend = function(_color){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.image_blend = _color;
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
            var _inst = insts[_i].id;
            _inst.alpha = _alpha;
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
            var _inst = insts[_i].id;
            _inst.collision = _collision;
        }
    }
    
    static set_particle = function(_dynamic_update, _fadeout, _size_decrease, _position_noise, _additive, _scale = 1, _alpha = 1, _interval = 5, _life = 25, _col = c_white, _sprite = undefined){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            set_danmaku_particle(_inst, _dynamic_update, _fadeout, _size_decrease, _position_noise, _additive, _scale, _alpha, _interval, _life, _col, _sprite);
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
            set_danmaku_particle_color2(_inst, _color1, _color2, _color3);
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
    
    static set_position = function(_x, _y, _z){
		x = _x;
		y = _y;
        z = _z;
	}

	static add_position = function(_dx, _dy, _dz){
		x += _dx;
		y += _dy;
        z += _dz;
	}
    
    static set_center = function(_x, _y, _z){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i];
            _inst.x += x - _x; 
            _inst.y += y - _y;
            _inst.z += z - _z;
        }
        
        x = _x;
        y = _y;
        z = _z;
    }
    
    static add_center = function(_dx, _dy, _dz){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i];
            _inst.x -= _dx; 
            _inst.y -= _dy;
            _inst.z -= _dz;
        }
        
        x += _dx;
        y += _dy;
        z += _dz;
    }
    
    static set_scale = function(_scale){
		xscale = _scale;
		yscale = _scale;
        zscale = _scale;
	}
    
    static add_scale = function(_dscale){
		xscale += _dscale;
		yscale += _dscale;
        zscale += _dscale;
	}
    
    static set_xscale = function(_xscale){
		xscale = _xscale;
	}
    
    static add_xscale = function(_dxscale){
		xscale += _dxscale;
	}
    
    static set_yscale = function(_yscale){
		yscale = _yscale;
	}
    
    static add_yscale = function(_dyscale){
		yscale += _dyscale;
	}
    
    static set_zscale = function(_zscale){
		zscale = _zscale;
	}
    
    static add_zscale = function(_dzscale){
		zscale += _dzscale;
	}

    static update_local_axes = function(){
		var _cy = dcos(yaw);
		var _sy = dsin(yaw);
		var _cp = dcos(pitch); 
		var _sp = dsin(pitch); 
		var _cr = dcos(roll); 
		var _sr = dsin(roll); 
		
		right.x = _cy * _cr + _sy * _sp * _sr;
		right.y = _cp * _sr;
		right.z = -_sy * _cr + _cy * _sp * _sr;
		
		up.x = -_cy * _sr + _sy * _sp * _cr;
		up.y = _cp * _cr;
		up.z = _sy * _sr + _cy * _sp * _cr;
		
		forward.x = _sy * _cp;
		forward.y = -_sp;
		forward.z = _cy * _cp;
	}
	
	static get_axis_clamped_value = function(_value){
		_value = _value % 360;
		if(_value < 0){
			_value += 360;
		}
		return _value;
	}
	
    static set_rotation = function(_yaw, _pitch, _roll){
        yaw = get_axis_clamped_value(_yaw);
        pitch = get_axis_clamped_value(_pitch);
		roll = get_axis_clamped_value(_roll);
		update_local_axes();
	}
	
	static add_rotation = function(_dyaw, _dpitch, _droll){
        yaw = get_axis_clamped_value(yaw + _dyaw);
        pitch = get_axis_clamped_value(pitch + _dpitch);
		roll = get_axis_clamped_value(roll + _droll);
        update_local_axes();
	}
    
    static set_inside_rotation = function(_inside_rotation){
		inside_rotation = _inside_rotation;
        rotate_inside_danmaku(self, inside_rotation);
	}
	
	static add_inside_rotation = function(_inside_rotation){
		inside_rotation += _inside_rotation;
        rotate_inside_danmaku(self, inside_rotation);
	}
    
    static update_danmaku = function(){
        var _len = array_length(insts);
        
        for(var _i = 0; _i < _len; _i++){
            var _inst = insts[_i];
            
            _inst.id.x = _inst.x * right.x * xscale + _inst.y * up.x * yscale + _inst.z * forward.x * zscale + x;
            _inst.id.y = _inst.x * right.y * xscale + _inst.y * up.y * yscale + _inst.z * forward.y * zscale + y;
            _inst.id.z = _inst.x * right.z * xscale + _inst.y * up.z * yscale + _inst.z * forward.z * zscale + z;
            
            _inst = _inst.id;
            
            if(image_angle_sync){
                var _dir = point_direction(x, y, _inst.x, _inst.y) + image_angle_sync_angle_adjust;
                _inst.image_angle = _dir;
            }
        }    
    }
    
    static explode = function(_spd, _inherit_particle = false, _tag = "default"){
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
                    var _spr = _inst.particle_sprite;
                    set_danmaku_particle(_sub_inst, _sy, _f, _sd, _pn, _a, _s, _ap, _it, _l, _col, _spr);
                }
            }
            
            if(_tag != "default"){
                _sub_inst.tag = _tag;
            }
        }
    }
    
    static destroy = function(){
        for(var _i = 0; _i < array_length(insts); _i++){
            instance_destroy(insts[_i].id);
        }
    }
    
    static destroy_fadeout = function(_destroy_time = 30){
        for(var _i = 0; _i < array_length(insts); _i++){
            destroy_danmaku_fadeout(_inst[_i].id, _destroy_time);
        }
    }
    
    static destroy_burst = function(_inst, _fadeout, _size_decrease, _additive, _min_spd = 3, _max_spd = 5, _scale = 1, _alpha = 1, _life = 5, _col = c_white, _sprite = undefined){
        for(var _i = 0; _i < array_length(insts); _i++){
            destroy_danmaku_burst(_inst[_i].id, _fadeout, _size_decrease, _additive, _min_spd, _max_spd, _scale, _alpha, _life, _col, _sprite);
        }
    }
}