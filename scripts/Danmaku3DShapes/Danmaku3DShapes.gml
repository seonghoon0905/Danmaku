#region 3D shapes

function make_sphere_danmaku(_x, _y, _z, _circle_amount, _bullets_per_circle, _size, _layer, _obj){
    if(!object_is_ancestor(_obj, obj_danmaku_parents)){
        return;
    }
    
    var _insts = [];
    for(var _i = 0; _i < _circle_amount; _i++){
        var _dir = lerp(90, -90, _i / (_circle_amount - 1));
        var _yy = dsin(_dir);
        _yy *= _size;
        _yy += _y;
        var _radius = dcos(_dir) * _size;
        var _n = (_i == 0 || _i == _circle_amount - 1) ? 1 : _bullets_per_circle;
        for(var _j = 0; _j < _n; _j++){
            var _xx = lengthdir_x(_radius, lerp(0, 360, _j / _n));
            var _zz = lengthdir_y(_radius, lerp(0, 360, _j / _n));
            var _inst = instance_create_layer(_xx + _x, _yy, _layer, _obj);
            _inst.z = _zz + _z;
            array_push(_insts, _inst);
        }
    }
    
    return new Danmaku3D(_x, _y, _z, _insts);
}

function make_finonacchi_sphere_danmaku(_x, _y, _z, _n, _size, _layer, _obj){
    if(_n < 2 || !object_is_ancestor(_obj, obj_danmaku_parents)){
        return;
    }
    
    var _insts = [];
    var _phi = pi * (sqrt(5) - 1);
    for(var _i = 0; _i < _n; _i++){
        var _yy = 1 - (_i / (_n - 1)) * 2;
        var _radius = sqrt(1 - _yy * _yy) * _size;
        var _dir = _phi * _i;
        var _xx = cos(_dir) * _radius;
        var _zz = sin(_dir) * _radius;
        var _inst = instance_create_layer(_x + _xx, _y + _yy * _size, _layer, _obj);
        _inst.z = _z + _zz;
        array_push(_insts, _inst);
    }
    
    return new Danmaku3D(_x, _y, _z, _insts);
}

function make_tetrahedron_danmaku(_x, _y, _z, _bullets_per_line, _size, _layer, _obj){
    if(!object_is_ancestor(_obj, obj_danmaku_parents)){
        return;
    }
    
    var _insts = [];
    var _sub_size = _size * dsin(30);
    
    for(var _i = 0; _i < 3; _i++){
        var _start_dir = _i * 120;
        var _end_dir = _i * 120 + 120;
        var _start_x = lengthdir_x(_size, _start_dir);
        var _start_z = lengthdir_y(_size, _start_dir);
        var _end_x = lengthdir_x(_size, _end_dir);
        var _end_z = lengthdir_y(_size, _end_dir);
        
        for(var _j = 0; _j < _bullets_per_line; _j++){
            var _xx = lerp(_start_x, _end_x, _j / (_bullets_per_line - 1));
            var _zz = lerp(_start_z, _end_z, _j / (_bullets_per_line - 1));
            var _inst = instance_create_layer(_xx + _x, _sub_size + _y, _layer, _obj);
            _inst.z = _zz + _z;
            array_push(_insts, _inst);
        }
        
        for(var _j = 0; _j < _bullets_per_line; _j++){
            var _xx = lerp(_start_x, 0, _j / (_bullets_per_line - 1));
            var _yy = lerp(_sub_size, -_size, _j / (_bullets_per_line - 1));
            var _zz = lerp(_start_z, 0, _j / (_bullets_per_line - 1));
            var _inst = instance_create_layer(_xx + _x, _yy + _y, _layer, _obj);
            _inst.z = _zz + _z;
            array_push(_insts, _inst);
        }
    }
    
    return new Danmaku3D(_x, _y, _z, _insts);
}

function make_cuboid_danmaku(_x, _y, _z, _width_num, _height_num, _depth_num, _dist_per_bullets, _layer, _obj){
    if(!object_is_ancestor(_obj, obj_danmaku_parents)){
        return;
    }
    
    var _insts = [];
    var _width = _width_num * _dist_per_bullets;
    var _height = _height_num * _dist_per_bullets;
    var _depth = _depth_num * _dist_per_bullets;
    
    for(var _i = 0; _i < 2; _i++){
        var _zz = _depth / 2;
        _zz = _i < 1 ? _zz : -_zz;
        for(var _j = 0; _j < 2; _j++){
            var _yy = _height / 2;
            _yy = _j < 1 ? _yy : -_yy;
            for(var _k = 0; _k < _width_num; _k++){
                var _xx = lerp(-_width / 2, _width / 2, _k / (_width_num - 1));
                var _inst = instance_create_layer(_xx + _x, _yy + _y, _layer, _obj);
                _inst.z = _zz + _z;
                array_push(_insts, _inst);
            }
        }
    }
    
    for(var _i = 0; _i < 2; _i++){
        var _zz = _depth / 2;
        _zz = _i < 1 ? _zz : -_zz;
        for(var _j = 0; _j < 2; _j++){
            var _xx = _width / 2;
            _xx = _j < 1 ? _xx : -_xx;
            for(var _k = 1; _k < _height_num - 1; _k++){
                var _yy = lerp(-_height / 2, _height / 2, _k / (_height_num - 1));
                var _inst = instance_create_layer(_xx + _x, _yy + _y, _layer, _obj);
                _inst.z = _zz + _z;
                array_push(_insts, _inst);
            }
        }
    }
    
    for(var _i = 0; _i < 2; _i++){
        var _xx = _width / 2;
        _xx = _i < 1 ? _xx : -_xx;
        for(var _j = 0; _j < 2; _j++){
            var _yy = _height / 2;
            _yy = _j < 1 ? _yy : -_yy;
            for(var _k = 1; _k < _depth_num - 1; _k++){
                var _zz = lerp(-_depth / 2, _depth / 2, _k / (_depth_num - 1));
                var _inst = instance_create_layer(_xx + _x, _yy + _y, _layer, _obj);
                _inst.z = _zz + _z;
                array_push(_insts, _inst);
            }
        }
    }
    
    return new Danmaku3D(_x, _y, _z, _insts);
}

function make_full_cuboid_danmaku(_x, _y, _z, _width_num, _height_num, _depth_num, _dist_per_bullets, _layer, _obj){
    if(!object_is_ancestor(_obj, obj_danmaku_parents)){
        return;
    }
    
    var _insts = [];
    var _width = _width_num * _dist_per_bullets;
    var _height = _height_num * _dist_per_bullets;
    var _depth = _depth_num * _dist_per_bullets;
    
    for(var _i = 0; _i < 2; _i++){
        var _zz = _depth / 2;
        _zz = _i < 1 ? _zz : -_zz;
        for(var _j = 0; _j < _height_num; _j++){
            var _yy = lerp(-_height / 2, _height / 2, _j / (_height_num - 1));
            for(var _k = 0; _k < _width_num; _k++){
                var _xx = lerp(-_width / 2, _width / 2, _k / (_width_num - 1));
                var _inst = instance_create_layer(_xx + _x, _yy + _y, _layer, _obj);
                _inst.z = _zz + _z;
                array_push(_insts, _inst);
            }
        }
    }
    
    for(var _i = 0; _i < 2; _i++){
        var _yy = _height / 2;
        _yy = _i < 1 ? _yy : -_yy;
        for(var _j = 1; _j < _depth_num - 1; _j++){
            var _zz = lerp(-_depth / 2, _depth / 2, _j / (_depth_num - 1));
            for(var _k = 1; _k < _width_num - 1; _k++){
                var _xx = lerp(-_width / 2, _width / 2, _k / (_width_num - 1));
                var _inst = instance_create_layer(_xx + _x, _yy + _y, _layer, _obj);
                _inst.z = _zz + _z;
                array_push(_insts, _inst);
            }
        }
    }
    
    for(var _i = 0; _i < 2; _i++){
        var _xx = _width / 2;
        _xx = _i < 1 ? _xx : -_xx;
        for(var _j = 0; _j < _height_num; _j++){
            var _yy = lerp(-_height / 2, _height / 2, _j / (_height_num - 1));
            for(var _k = 1; _k < _depth_num - 1; _k++){
                var _zz = lerp(-_depth / 2, _depth / 2, _k / (_depth_num - 1));
                var _inst = instance_create_layer(_xx + _x, _yy + _y, _layer, _obj);
                _inst.z = _zz + _z;
                array_push(_insts, _inst);
            }
        }
    }
    
    return new Danmaku3D(_x, _y, _z, _insts);
}

function make_cube_danmaku(_x, _y, _z, _bullets_per_line, _size, _layer, _obj){
    if(_bullets_per_line < 2){
        return;
    }
    
    var _dist_per_bullets = _size / (_bullets_per_line - 1);
    return make_cuboid_danmaku(_x, _y, _z, _bullets_per_line, _bullets_per_line, _bullets_per_line, _dist_per_bullets, _layer, _obj);
}

function make_full_cube_danmaku(_x, _y, _z, _bullets_per_line, _size, _layer, _obj){
    if(_bullets_per_line < 2){
        return;
    }
    
    var _dist_per_bullets = _size / (_bullets_per_line - 1);
    return make_full_cuboid_danmaku(_x, _y, _z, _bullets_per_line, _bullets_per_line, _bullets_per_line, _dist_per_bullets, _layer, _obj);
}


#endregion

#region 2D shapes

function make_circle_danmaku3d(_x, _y, _z, _n, _dir_offset, _size, _layer, _obj){
	var _insts = [];
	var _start_dir = _dir_offset;
	var _end_dir = _dir_offset + 360;
	for(var _dir = _start_dir; _dir < _end_dir; _dir += 360 / _n){
		var _xx = _x + lengthdir_x(_size, _dir);
		var _yy = _y + lengthdir_y(_size, _dir);
		var _inst = instance_create_layer(_xx, _yy, _layer, _obj);
        _inst.z = _z;
		array_push(_insts, _inst);
	}
    
	return new Danmaku3D(_x, _y, _z, _insts, {
		type : "circle",
		n : _n,
		dir_offset : _dir_offset,
        size : _size
	});
}

function make_polygon_danmaku3d(_x, _y, _z, _n, _bullets_per_line, _dir_offset, _size, _layer, _obj){
	var _insts = [];
	var _start_dir = _dir_offset;
	var _end_dir = _dir_offset + 360;
	for(var _dir = _start_dir; _dir < _end_dir; _dir += 360 / _n){
		var _start_x = _x + lengthdir_x(_size, _dir);
		var _end_x = _x + lengthdir_x(_size, _dir + 360 / _n);
		var _start_y = _y + lengthdir_y(_size, _dir);
		var _end_y = _y + lengthdir_y(_size, _dir + 360 / _n);
		for(var _i = 0; _i < _bullets_per_line; _i++){
			var _xx = lerp(_start_x, _end_x, _i / _bullets_per_line);
			var _yy = lerp(_start_y, _end_y, _i / _bullets_per_line);
			var _inst = instance_create_layer(_xx, _yy, _layer, _obj);
            _inst.z = _z;
			array_push(_insts, _inst);
		}
	}
    
	return new Danmaku3D(_x, _y, _z, _insts, {
		type : "polygon",
		n : _n,
		bullets_per_line : _bullets_per_line,
		dir_offset : _dir_offset,
        size : _size
	});
}

function make_star_danmaku3d(_x, _y, _z, _bullets_per_line, _dir_offset, _size, _layer, _obj){
	var _insts = [];
	var _start_dir = _dir_offset;
	var _end_dir = _dir_offset + 720;
	for(var _dir = _start_dir; _dir < _end_dir; _dir += 720 / 5){
		var _start_x = _x + lengthdir_x(_size, _dir);
		var _end_x = _x + lengthdir_x(_size, _dir + 720 / 5);
		var _start_y = _y + lengthdir_y(_size, _dir);
		var _end_y = _y + lengthdir_y(_size, _dir + 720 / 5);
		for(var _i = 0; _i < _bullets_per_line; _i++){
			var _xx = lerp(_start_x, _end_x, _i / _bullets_per_line);
			var _yy = lerp(_start_y, _end_y, _i / _bullets_per_line);
			var _inst = instance_create_layer(_xx, _yy, _layer, _obj);
            _inst.z = _z;
			array_push(_insts, _inst);
		}
	}
    
	return new Danmaku3D(_x, _y, _z, _insts, {
		type : "star",
		bullets_per_line : _bullets_per_line,
		dir_offset : _dir_offset,
        size :_size
	});
}

function make_heart_danmaku3d(_x, _y, _z, _n, _dir_offset, _size, _layer, _obj){
	var _insts = [];
	var _start_dir = _dir_offset;
	var _end_dir = _dir_offset + 360;
	for(var _dir = _start_dir; _dir < _end_dir; _dir += 360 / _n){
		var _xx = 16 * power(dsin(_dir), 3);
		var _yy = 13 * dcos(_dir) - 5 * dcos(2 * _dir) - 2 * dcos(3 * _dir) - dcos(4 * _dir);
		_xx *= _size;
		_yy *= -_size;
		_xx += _x;
		_yy += _y;
		var _inst = instance_create_layer(_xx, _yy, _layer, _obj);
        _inst.z = _z;
		array_push(_insts, _inst);
	}
    
	return new Danmaku3D(_x, _y, _z, _insts, {
		type : "heart",
		n : _n,
		dir_offset : _dir_offset,
		size : _size
	});
}

function make_flower_danmaku3d(_x, _y, _z, _n, _bullets_per_leaf, _dir_offset, _size, _layer, _obj){
    var _insts = [];
    var _channel = animcurve_get_channel(ac_danmaku_flower, 0);
    for(var _i = 0; _i < _n; _i++){
        var _start_dir = lerp(_dir_offset, _dir_offset + 360, _i / _n);
        var _end_dir = _start_dir + 360 / _n;
        for(var _j = 1; _j < _bullets_per_leaf; _j++){
            var _amount = animcurve_channel_evaluate(_channel, _j / (_bullets_per_leaf - 1));
            var _len = lerp(0, _size / 2, _amount);
            var _dir = lerp(_start_dir, _end_dir, _j / (_bullets_per_leaf - 1));
            var _xx = _x + lengthdir_x(_size + _len, _dir);
            var _yy = _y + lengthdir_y(_size + _len, _dir);
            var _inst = instance_create_layer(_xx, _yy, _layer, _obj);
            _inst.z = _z;
    		array_push(_insts, _inst);
        }
    }
    
    return new Danmaku3D(_x, _y, _z, _insts, {
        type : "flower",  
        n : _n,
        bullets_per_leaf : _bullets_per_leaf,
        dir_offset : _dir_offset,
        size : _size,
    });
}

function make_shuriken_danmaku3d(_x, _y, _z, _n, _bullets_per_line, _dir_offset, _size, _layer, _obj){
    var _insts = [];
    for(var _i = 0; _i < _n; _i++){
        var _start_dir = lerp(_dir_offset, _dir_offset + 360, _i / _n);
        var _end_dir = _start_dir + (360 / _n) / 2;
        var _start_x = _x + lengthdir_x(_size, _start_dir);
        var _start_y = _y + lengthdir_y(_size, _start_dir);
        var _end_x = _x + lengthdir_x(_size * 2, _end_dir);
        var _end_y = _y + lengthdir_y(_size * 2, _end_dir);
        
        for(var _j = 1; _j < _bullets_per_line; _j++){
            var _xx = lerp(_start_x, _end_x, _j / (_bullets_per_line - 1));
            var _yy = lerp(_start_y, _end_y, _j / (_bullets_per_line - 1));
            var _inst = instance_create_layer(_xx, _yy, _layer, _obj);
            _inst.z = _z;
            array_push(_insts, _inst);
        }
        
        _start_dir = _end_dir;
        _end_dir = _start_dir + (360 / _n) / 2;
        _start_x = _x + lengthdir_x(_size * 2, _start_dir);
        _start_y = _y + lengthdir_y(_size * 2, _start_dir);
        _end_x = _x + lengthdir_x(_size, _end_dir);
        _end_y = _y + lengthdir_y(_size, _end_dir);
        
        for(var _j = 1; _j < _bullets_per_line; _j++){
            var _xx = lerp(_start_x, _end_x, _j / (_bullets_per_line - 1));
            var _yy = lerp(_start_y, _end_y, _j / (_bullets_per_line - 1));
            var _inst = instance_create_layer(_xx, _yy, _layer, _obj);
            _inst.z = _z;
            array_push(_insts, _inst);
        }
    }
    
    return new Danmaku3D(_x, _y, _z, _insts, {
        type : "shuriken",  
        n : _n,
        bullets_per_line : _bullets_per_line,
        dir_offset : _dir_offset,
        size : _size,
    });
}

function make_lines_danmaku3d(_x, _y, _z, _n, _bullets_per_line, _dir_offset, _size, _layer, _obj){
    var _insts = [];
    for(var _i = 0; _i < _n; _i++){
        var _dir = lerp(_dir_offset, _dir_offset + 360, _i / _n);
        for(var _j = 0; _j < _bullets_per_line; _j++){
            if(_i != 0 && _j == 0){
                continue;
            }
            var _len = lerp(0, _size, _j / (_bullets_per_line - 1));
            var _xx = _x + lengthdir_x(_len, _dir);
            var _yy = _y + lengthdir_y(_len, _dir);
            var _inst = instance_create_layer(_xx, _yy, _layer, _obj);
            _inst.z = _z;
            array_push(_insts, _inst);
        }
    }
    
    return new Danmaku3D(_x, _y, _z, _insts);
}

#endregion