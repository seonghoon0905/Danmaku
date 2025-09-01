function explode_circle_danmaku(_x, _y, _spd, _n, _dir_offset, _layer, _obj, _tag = "default"){
	var _start_dir = _dir_offset;
	var _end_dir = _dir_offset + 360;
	for(var _dir = _start_dir; _dir < _end_dir; _dir += 360 / _n){
		var _inst = instance_create_layer(_x, _y, _layer, _obj);
		_inst.direction = _dir;
		_inst.speed = _spd;
        
        if(object_is_ancestor(_inst.object_index, obj_danmaku_parents)){
            _inst.outsidekill = true;
        }
        
        if(_tag != "default"){
            _inst.tag = _tag;
        }
	}
}

function explode_polygon_danmaku(_x, _y, _spd, _n, _bullets_per_line, _dir_offset, _layer, _obj, _tag = "default"){
	var _start_dir = _dir_offset;
	var _end_dir = _dir_offset + 360;
	for(var _dir = _start_dir; _dir < _end_dir; _dir += 360 / _n){
		var _start_x = _x + lengthdir_x(1, _dir);
		var _end_x = _x + lengthdir_x(1, _dir + 360 / _n);
		var _start_y = _y + lengthdir_y(1, _dir);
		var _end_y = _y + lengthdir_y(1, _dir + 360 / _n);
		for(var _i = 0; _i < _bullets_per_line; _i++){
			var _xx = lerp(_start_x, _end_x, _i / _bullets_per_line);
			var _yy = lerp(_start_y, _end_y, _i / _bullets_per_line);
			var _inst = instance_create_layer(_x, _y, _layer, _obj);
			_inst.speed = point_distance(_x, _y, _xx, _yy) * _spd;
			_inst.direction = point_direction(_x, _y, _xx, _yy);
            
            if(object_is_ancestor(_inst.object_index, obj_danmaku_parents)){
                _inst.outsidekill = true;
            }
            
            if(_tag != "default"){
                _inst.tag = _tag;
            }
		}
	}
}

function explode_star_danmaku(_x, _y, _spd, _bullets_per_line, _dir_offset, _layer, _obj, _tag = "default"){
	var _start_dir = _dir_offset;
	var _end_dir = _dir_offset + 720;
	for(var _dir = _start_dir; _dir < _end_dir; _dir += 720 / 5){
		var _start_x = _x + lengthdir_x(1, _dir);
		var _end_x = _x + lengthdir_x(1, _dir + 720 / 5);
		var _start_y = _y + lengthdir_y(1, _dir);
		var _end_y = _y + lengthdir_y(1, _dir + 720 / 5);
		for(var _i = 0; _i < _bullets_per_line; _i++){
			var _xx = lerp(_start_x, _end_x, _i / _bullets_per_line);
			var _yy = lerp(_start_y, _end_y, _i / _bullets_per_line);
			var _inst = instance_create_layer(_x, _y, _layer, _obj);
			_inst.speed = point_distance(_x, _y, _xx, _yy) * _spd;
			_inst.direction = point_direction(_x, _y, _xx, _yy);
            
            if(object_is_ancestor(_inst.object_index, obj_danmaku_parents)){
                _inst.outsidekill = true;
            }
                
            if(_tag != "default"){
                _inst.tag = _tag;
            }
		}
	}
}

function explode_heart_danmaku(_x, _y, _spd, _n, _dir_offset, _layer, _obj, _tag = "default"){
	var _start_dir = _dir_offset;
	var _end_dir = _dir_offset + 360;
	for(var _dir = _start_dir; _dir < _end_dir; _dir += 360 / _n){
		var _xx = 16 * power(dsin(_dir), 3);
		var _yy = 13 * dcos(_dir) - 5 * dcos(2 * _dir) - 2 * dcos(3 * _dir) - dcos(4 * _dir);
		_yy *= -1;
		_xx += _x;
		_yy += _y;
		var _inst = instance_create_layer(_x, _y, _layer, _obj);
		_inst.speed = point_distance(_x, _y, _xx, _yy) * _spd / 5;
		_inst.direction = point_direction(_x, _y, _xx, _yy);
        
        if(object_is_ancestor(_inst.object_index, obj_danmaku_parents)){
            _inst.outsidekill = true;
        }
        
        if(_tag != "default"){
            _inst.tag = _tag;
        }
	}
}

function explode_flower_danmaku(_x, _y, _spd, _n, _bullets_per_leaf, _dir_offset, _layer, _obj, _tag = "default"){
    var _channel = animcurve_get_channel(ac_danmaku_flower, 0);
    for(var _i = 0; _i < _n; _i++){
        var _start_dir = lerp(_dir_offset, _dir_offset + 360, _i / _n);
        var _end_dir = _start_dir + 360 / _n;
        for(var _j = 1; _j < _bullets_per_leaf; _j++){
            var _amount = animcurve_channel_evaluate(_channel, _j / (_bullets_per_leaf - 1));
            var _len = lerp(0, 1, _amount);
            var _dir = lerp(_start_dir, _end_dir, _j / (_bullets_per_leaf - 1));
            var _xx = _x + lengthdir_x(1 + _len, _dir);
            var _yy = _y + lengthdir_y(1 + _len, _dir);
            var _inst = instance_create_layer(_x, _y, _layer, _obj);
            _inst.speed = point_distance(_x, _y, _xx, _yy) * _spd / 2;
            _inst.direction = point_direction(_x, _y, _xx, _yy);
            
            if(object_is_ancestor(_inst.object_index, obj_danmaku_parents)){
                _inst.outsidekill = true;
            }
            
            if(_tag != "default"){
                _inst.tag = _tag;
            }
        }
    }
}

function explode_shuriken_danmaku(_x, _y, _spd, _n, _bullets_per_line, _dir_offset, _layer, _obj, _tag = "default"){
    for(var _i = 0; _i < _n; _i++){
        var _start_dir = lerp(_dir_offset, _dir_offset + 360, _i / _n);
        var _end_dir = _start_dir + (360 / _n) / 2;
        var _start_x = _x + lengthdir_x(1, _start_dir);
        var _start_y = _y + lengthdir_y(1, _start_dir);
        var _end_x = _x + lengthdir_x(2, _end_dir);
        var _end_y = _y + lengthdir_y(2, _end_dir);
        
        for(var _j = 1; _j < _bullets_per_line; _j++){
            var _xx = lerp(_start_x, _end_x, _j / (_bullets_per_line - 1));
            var _yy = lerp(_start_y, _end_y, _j / (_bullets_per_line - 1));
            
            var _inst = instance_create_layer(_x, _y, _layer, _obj);
            _inst.speed = point_distance(_x, _y, _xx, _yy) * _spd / 2;
            _inst.direction = point_direction(_x, _y, _xx, _yy);
            
            if(object_is_ancestor(_inst.object_index, obj_danmaku_parents)){
                _inst.outsidekill = true;
            }
            
            if(_tag != "default"){
                _inst.tag = _tag;
            }
        }
        
        _start_dir = _end_dir;
        _end_dir = _start_dir + (360 / _n) / 2;
        _start_x = _x + lengthdir_x(2, _start_dir);
        _start_y = _y + lengthdir_y(2, _start_dir);
        _end_x = _x + lengthdir_x(1, _end_dir);
        _end_y = _y + lengthdir_y(1, _end_dir);
        
        for(var _j = 1; _j < _bullets_per_line; _j++){
            var _xx = lerp(_start_x, _end_x, _j / (_bullets_per_line - 1));
            var _yy = lerp(_start_y, _end_y, _j / (_bullets_per_line - 1));
            
            var _inst = instance_create_layer(_x, _y, _layer, _obj);
            _inst.speed = point_distance(_x, _y, _xx, _yy) * _spd / 2;
            _inst.direction = point_direction(_x, _y, _xx, _yy);
            
            if(object_is_ancestor(_inst.object_index, obj_danmaku_parents)){
                _inst.outsidekill = true;
            }
            
            if(_tag != "default"){
                _inst.tag = _tag;
            }
        }
    }
}

