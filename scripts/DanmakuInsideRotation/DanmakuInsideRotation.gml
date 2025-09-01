function rotate_inside_polygon_danmaku(_danmaku, _inside_rotation){
    var _n = _danmaku.inside_rotation_param.n;
    var _bullets_per_line = _danmaku.inside_rotation_param.bullets_per_line;
    var _dir_offset = _danmaku.inside_rotation_param.dir_offset;
    var _start_dir = _dir_offset;
    var _end_dir = _dir_offset + 360;
    var _cnt = 0;
    
    for(var _dir = _start_dir; _dir < _end_dir; _dir += 360 / _n){
        for(var _i = 0; _i < _bullets_per_line; _i++){
            var _start_x = lengthdir_x(_danmaku.inside_rotation_param.size, _dir);
            var _end_x = lengthdir_x(_danmaku.inside_rotation_param.size, _dir + 360 / _n);
            var _start_y = lengthdir_y(_danmaku.inside_rotation_param.size, _dir);
            var _end_y = lengthdir_y(_danmaku.inside_rotation_param.size, _dir + 360 / _n);
            var _amount = ((_i + _inside_rotation / _bullets_per_line / _n) % _bullets_per_line) / _bullets_per_line; 
            if(_amount < 0){
                _amount = 1 + _amount;
            }
            var _xx = lerp(_start_x, _end_x, _amount);
            var _yy = lerp(_start_y, _end_y, _amount);
            _danmaku.insts[_cnt].x = _xx;
            _danmaku.insts[_cnt].y = _yy;

            _cnt++;
        }
    }
}
    
function rotate_inside_star_danmaku(_danmaku, _inside_rotation){
    var _bullets_per_line = _danmaku.inside_rotation_param.bullets_per_line;
    var _dir_offset = _danmaku.inside_rotation_param.dir_offset;
    var _start_dir = _dir_offset;
    var _end_dir = _dir_offset + 720;
    var _cnt = 0;
    
    for(var _dir = _start_dir; _dir < _end_dir; _dir += 720 / 5){
        var _start_x = lengthdir_x(_danmaku.inside_rotation_param.size, _dir);
        var _end_x = lengthdir_x(_danmaku.inside_rotation_param.size, _dir + 720 / 5);
        var _start_y = lengthdir_y(_danmaku.inside_rotation_param.size, _dir);
        var _end_y = lengthdir_y(_danmaku.inside_rotation_param.size, _dir + 720 / 5);
        for(var _i = 0; _i < _bullets_per_line; _i++){
            var _amount = ((_i + _inside_rotation / _bullets_per_line) % _bullets_per_line) / _bullets_per_line;
            
            if(_amount < 0){
                _amount = 1 + _amount;
            }
            
            var _xx = lerp(_start_x, _end_x, _amount);
            var _yy = lerp(_start_y, _end_y, _amount);

            _danmaku.insts[_cnt].x = _xx;
            _danmaku.insts[_cnt].y = _yy;
            _cnt++;
        }
    }
}
    
function rotate_inside_heart_danmaku(_danmaku, _inside_rotation){
    var _n = _danmaku.inside_rotation_param.n;
    var _dir_offset = _danmaku.inside_rotation_param.dir_offset;
    var _start_dir = _dir_offset + _inside_rotation;
    var _end_dir = _dir_offset + 360 + _inside_rotation;
    var _cnt = 0;
    for(var _dir = _start_dir; _dir < _end_dir; _dir += 360 / _n){
        var _xx = 16 * power(dsin(_dir), 3);
        var _yy = 13 * dcos(_dir) - 5 * dcos(2 * _dir) - 2 * dcos(3 * _dir) - dcos(4 * _dir);
        
        _xx *= _danmaku.inside_rotation_param.size;
        _yy *= -_danmaku.inside_rotation_param.size;
        
        var _direction = point_direction(_danmaku.x, _danmaku.y, _xx, _yy);
        var _distance = point_distance(_danmaku.x, _danmaku.y, _xx, _yy);
        
        _danmaku.insts[_cnt].x = _danmaku.x + lengthdir_x(_distance, _direction);
        _danmaku.insts[_cnt].y = _danmaku.y + lengthdir_y(_distance, _direction);

        _cnt++;
    }
}

function rotate_inside_flower_danmaku(_danmaku, _inside_rotation){
    var _n = _danmaku.inside_rotation_param.n;
    var _dir_offset = _danmaku.inside_rotation_param.dir_offset;
    var _bullets_per_leaf = _danmaku.inside_rotation_param.bullets_per_leaf;
    var _channel = animcurve_get_channel(ac_danmaku_flower, 0);
    var _cnt = 0;
    for(var _i = 0; _i < _n; _i++){
        var _start_dir = lerp(_dir_offset, _dir_offset + 360, _i / _n);
        var _end_dir = _start_dir + 360 / _n;
        for(var _j = 1; _j < _bullets_per_leaf; _j++){
            var _nn = _bullets_per_leaf - 1;
            var _amount = ((_j + _inside_rotation / _nn / _n) % _nn) / _nn;
            if(_amount < 0){
                _amount = 1 + _amount;
            }
            var _len = lerp(0, _danmaku.inside_rotation_param.size / 2, animcurve_channel_evaluate(_channel, _amount));
            var _dir = lerp(_start_dir, _end_dir, _amount);
            _danmaku.insts[_cnt].x = lengthdir_x(_danmaku.inside_rotation_param.size + _len, _dir);
            _danmaku.insts[_cnt].y = lengthdir_y(_danmaku.inside_rotation_param.size + _len, _dir);
            _cnt++;
        }
    }
}

function rotate_inside_shuriken_danmaku(_danmaku, _inside_rotation){
    var _n = _danmaku.inside_rotation_param.n;
    var _dir_offset = _danmaku.inside_rotation_param.dir_offset;
    var _bullets_per_line = _danmaku.inside_rotation_param.bullets_per_line;
    
    var _cnt = 0;
    for(var _i = 0; _i < _n; _i++){
        var _start_dir = lerp(_dir_offset, _dir_offset + 360, _i / _n);
        var _end_dir = _start_dir + (360 / _n) / 2;
        var _start_x = lengthdir_x(_danmaku.inside_rotation_param.size, _start_dir);
        var _start_y = lengthdir_y(_danmaku.inside_rotation_param.size, _start_dir);
        var _end_x = lengthdir_x(_danmaku.inside_rotation_param.size * 2, _end_dir);
        var _end_y = lengthdir_y(_danmaku.inside_rotation_param.size * 2, _end_dir);
        
        for(var _j = 1; _j < _bullets_per_line; _j++){
            var _nn = _bullets_per_line - 1;
            var _amount = ((_j + _inside_rotation / _nn / _n) % _nn) / _nn;
            _danmaku.insts[_cnt].x = lerp(_start_x, _end_x, _amount);
            _danmaku.insts[_cnt].y = lerp(_start_y, _end_y, _amount);
            _cnt++;
        }
        
        _start_dir = _end_dir;
        _end_dir = _start_dir + (360 / _n) / 2;
        _start_x = lengthdir_x(_danmaku.inside_rotation_param.size * 2, _start_dir);
        _start_y = lengthdir_y(_danmaku.inside_rotation_param.size * 2, _start_dir);
        _end_x = lengthdir_x(_danmaku.inside_rotation_param.size, _end_dir);
        _end_y = lengthdir_y(_danmaku.inside_rotation_param.size, _end_dir);
        
        for(var _j = 1; _j < _bullets_per_line; _j++){
            var _nn = _bullets_per_line - 1;
            var _amount = ((_j + _inside_rotation / _nn / _n) % _nn) / _nn;
            _danmaku.insts[_cnt].x = lerp(_start_x, _end_x, _amount);
            _danmaku.insts[_cnt].y = lerp(_start_y, _end_y, _amount);
            _cnt++;
        }
    }
}

function rotate_inside_danmaku(_danmaku, _inside_rotation){
    if(_danmaku.inside_rotation_param == undefined){
        return;
    }
    
    switch(_danmaku.inside_rotation_param.type){
        case "polygon":
            rotate_inside_polygon_danmaku(_danmaku, _inside_rotation);
            break;
        case "star":
            rotate_inside_star_danmaku(_danmaku, _inside_rotation);
            break;
        case "heart":
            rotate_inside_heart_danmaku(_danmaku, _inside_rotation);
            break;
        case "flower":
            rotate_inside_flower_danmaku(_danmaku, _inside_rotation);
            break;
        case "shuriken":
            rotate_inside_shuriken_danmaku(_danmaku, _inside_rotation);
            break;
    }
}