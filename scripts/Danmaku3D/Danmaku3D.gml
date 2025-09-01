function Danmaku3D(_x, _y, _z, _insts, _z_focal_length = true, _inside_rotation_param = undefined) constructor{
    enable_projection = true;
    enable_collision_over_focal_length = true;
    // When you make it true, bullets of danmaku never fadeout though their z positions cross over the focal_length
    
    focal_length = DANMAKU_SCREEN_WIDTH / (2 * dtan(DANMAKU_FOV / 2));
    
    x = _x; 
    y = _y; 
    z = _z_focal_length ? focal_length : _z;
    
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
    
    for(var _i = 0; _i < array_length(_insts); _i++){
        var _inst = _insts[_i];
        _inst.enable_3d = true;
        _inst.z = focal_length;
        
        array_push(insts, {
            id : _inst.id,
            x : _inst.x - x, 
            y : _inst.y - y,
            z : _inst.z - z
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
    
    function set_outsidekill(_outsidekill){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.outsidekill = _outsidekill;
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
    
    function set_image_scale(_scale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.image_xscale = _scale;
            _inst.image_yscale = _scale;
        }
        
        image_scale = _scale;
    }
    
    function add_image_scale(_dscale){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            _inst.image_xscale += _dscale;
            _inst.image_yscale += _dscale;
        }
        
        image_scale += _dscale;
    }
    
    function set_particle(_dynamic_update, _fadeout, _size_decrease, _position_noise, _additive, _scale = 1, _interval = 5, _life = 25, _col = c_white){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
            set_danmaku_particle(_inst, _dynamic_update, _fadeout, _size_decrease, _position_noise, _additive, _scale, _interval, _life, _col);
        }
    }
    
    function set_position(_x, _y, _z){
		x = _x;
		y = _y;
        z = _z;
	}

	function add_position(_dx, _dy, _dz){
		x += _dx;
		y += _dy;
        z += _dz;
	}

    function set_scale(_scale){
		xscale = _scale;
		yscale = _scale;
        zscale = _scale;
	}
    
    function add_scale(_dscale){
		xscale += _dscale;
		yscale += _dscale;
        zscale += _dscale;
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
    
    function set_zscale(_zscale){
		zscale = _zscale;
	}
    
    function add_zscale(_dzscale){
		zscale += _dzscale;
	}

    function update_local_axes(){
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
	
	function get_axis_clamped_value(_value){
		_value = _value % 360;
		if(_value < 0){
			_value += 360;
		}
		return _value;
	}
	
    function set_rotation(_yaw, _pitch, _roll){
        yaw = get_axis_clamped_value(_yaw);
        pitch = get_axis_clamped_value(_pitch);
		roll = get_axis_clamped_value(_roll);
		update_local_axes();
	}
	
	function add_rotation(_dyaw, _dpitch, _droll){
        yaw = get_axis_clamped_value(yaw + _dyaw);
        pitch = get_axis_clamped_value(pitch + _dpitch);
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
            
            _inst.id.x = _inst.x * right.x * xscale + _inst.y * up.x * yscale + _inst.z * forward.x * zscale + x;
            _inst.id.y = _inst.x * right.y * xscale + _inst.y * up.y * yscale + _inst.z * forward.y * zscale + y;
            _inst.id.z = _inst.x * right.z * xscale  + _inst.y * up.z * yscale + _inst.z * forward.z * zscale + z;
            
            _inst = _inst.id;
            
            if(image_angle_sync){
                var _dir = point_direction(x, y, _inst.x, _inst.y) + image_angle_sync_angle_adjust;
                _inst.image_angle = _dir;
            }
            
            if(enable_projection && _inst.z > DANMAKU_ZNEAR && _inst.z < DANMAKU_ZFAR){
                var _scale = focal_length / _inst.z;
                
                _inst.image_xscale = _scale * image_scale;
                _inst.image_yscale = _scale * image_scale;
            }
            
            if(!enable_collision_over_focal_length){
                var _epsilon = 1;
                var _alpha = _inst.z > focal_length + _epsilon ? DANMAKU_INCOLLIDABLE_BULLET_ALPHA : 1;
                
                if(_inst.z > focal_length + _epsilon){
                    _inst.mask_index = spr_danmaku_noone;
                }    
                else{
                    _inst.mask_index = _inst.sprite_index;
                }
                
                _inst.image_alpha += (_alpha - _inst.image_alpha) / 10;
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
                
                if(_inherit_particle && _sub_inst.particle_emitter != undefined){
                    var _f = _sub_inst.particle_fadeout;
                    var _sd = _sub_inst.particle_size_decrease;
                    var _fn = _sub_inst.particle_position_noise;
                    var _a = _sub_inst.particle_additive;
                    var _s = _sub_inst.particle_scale;
                    var _i = _sub_inst.particle_interval;
                    var _l = _sub_inst.particle_life;
                    var _sy = _sub_inst.particle_sync;
                    var _col = _sub_inst.particle_color;
                    set_danmaku_particle(_sub_inst, _f, _sd, _fn, _a, _s, _i, _l, _sy, _col);
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