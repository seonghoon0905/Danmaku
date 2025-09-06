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