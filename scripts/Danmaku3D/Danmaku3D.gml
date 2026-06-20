function Danmaku3D(_x, _y, _z, _insts, _inside_rotation_param = undefined) : DanmakuBase() constructor {
    x = _x; 
    y = _y; 
    z = _z;
    
    xscale = 1;
    yscale = 1;
    zscale = 1;
    
    right = {x : 1, y : 0, z : 0};
    up = {x : 0, y : 1, z : 0};
    forward = {x : 0, y : 0, z : 1};
    
    quat = [0, 0, 0, 1]; 
    
    inside_rotation_param = variable_clone(_inside_rotation_param);
    
    static add_inst = function(_inst){
        _inst.enable_projection = true;
        _inst.enable_collision_over_focal_length = false;
        
        array_push(insts, {
            id : _inst.id,
            x : _inst.x - x, 
            y : _inst.y - y,
            z : _inst.z - z
        });
        add_inst_base(_inst, x, y, z);
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
    
    static set_position = function(_x, _y, _z){
        x = _x; y = _y; z = _z;
    }

    static add_position = function(_dx, _dy, _dz){
        x += _dx; y += _dy; z += _dz;
    }
    
    static set_center = function(_x, _y, _z){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i];
            _inst.x += x - _x; 
            _inst.y += y - _y;
            _inst.z += z - _z;
        }
        x = _x; y = _y; z = _z;
    }
    
    static add_center = function(_dx, _dy, _dz){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i];
            _inst.x -= _dx; 
            _inst.y -= _dy;
            _inst.z -= _dz;
        }
        x += _dx; y += _dy; z += _dz;
    }
    
    static set_scale = function(_scale){
        xscale = _scale; yscale = _scale; zscale = _scale;
    }
    
    static add_scale = function(_dscale){
        xscale += _dscale; yscale += _dscale; zscale += _dscale;
    }
    
    static set_xscale = function(_xscale){ xscale = _xscale; }
    static add_xscale = function(_dxscale){ xscale += _dxscale; }
    static set_yscale = function(_yscale){ yscale = _yscale; }
    static add_yscale = function(_dyscale){ yscale += _dyscale; }
    static set_zscale = function(_zscale){ zscale = _zscale; }
    static add_zscale = function(_dzscale){ zscale += _dzscale; }

    static _euler_to_quat = function(_yaw, _pitch, _roll) {
        var _c1 = dcos(_yaw / 2);
        var _c2 = dcos(_pitch / 2);
        var _c3 = dcos(_roll / 2);
        var _s1 = dsin(_yaw / 2);
        var _s2 = dsin(_pitch / 2);
        var _s3 = dsin(_roll / 2);

        var _q = array_create(4);
        _q[0] = _s1 * _s2 * _c3 + _c1 * _c2 * _s3; // X
        _q[1] = _s1 * _c2 * _c3 + _c1 * _s2 * _s3; // Y
        _q[2] = _c1 * _s2 * _c3 - _s1 * _c2 * _s3; // Z
        _q[3] = _c1 * _c2 * _c3 - _s1 * _s2 * _s3; // W
        return _q;
    }

    static _quat_multiply = function(_q1, _q2) {
        var _x =  _q1[0] * _q2[3] + _q1[1] * _q2[2] - _q1[2] * _q2[1] + _q1[3] * _q2[0];
        var _y = -_q1[0] * _q2[2] + _q1[1] * _q2[3] + _q1[2] * _q2[0] + _q1[3] * _q2[1];
        var _z =  _q1[0] * _q2[1] - _q1[1] * _q2[0] + _q1[2] * _q2[3] + _q1[3] * _q2[2];
        var _w = -_q1[0] * _q2[0] - _q1[1] * _q2[1] - _q1[2] * _q2[2] + _q1[3] * _q2[3];
        return [_x, _y, _z, _w];
    }

    static update_local_axes = function(){
        var _x = quat[0];
        var _y = quat[1];
        var _z = quat[2];
        var _w = quat[3];

        var _x2 = _x * _x; var _y2 = _y * _y; var _z2 = _z * _z;
        var _xy = _x * _y; var _xz = _x * _z; var _yz = _y * _z;
        var _wx = _w * _x; var _wy = _w * _y; var _wz = _w * _z;

        right.x = 1 - 2 * (_y2 + _z2);
        right.y = 2 * (_xy + _wz);     
        right.z = 2 * (_xz - _wy);

        up.x = 2 * (_xy - _wz);
        up.y = 1 - 2 * (_x2 + _z2);
        up.z = 2 * (_yz + _wx);

        forward.x = 2 * (_xz + _wy);
        forward.y = 2 * (_yz - _wx);
        forward.z = 1 - 2 * (_x2 + _y2);
    }
    
    static set_rotation = function(_yaw, _pitch, _roll){
        quat = _euler_to_quat(_yaw, _pitch, _roll);
        update_local_axes();
    }
    
    static add_rotation = function(_dyaw, _dpitch, _droll){
        var _delta_quat = _euler_to_quat(_dyaw, _dpitch, _droll);
        quat = _quat_multiply(quat, _delta_quat);
        
        var _norm = sqrt(sqr(quat[0]) + sqr(quat[1]) + sqr(quat[2]) + sqr(quat[3]));
        if (_norm > 0) {
            quat[0] /= _norm; quat[1] /= _norm; quat[2] /= _norm; quat[3] /= _norm;
        }
        
        update_local_axes();
    }
    
    static update_danmaku = function(){
        var _len = array_length(insts);
        
        for(var _i = 0; _i < _len; _i++){
            insts[_i].id.x = insts[_i].x * right.x * xscale + insts[_i].y * up.x * yscale + insts[_i].z * forward.x * zscale + x;
            insts[_i].id.y = insts[_i].x * right.y * xscale + insts[_i].y * up.y * yscale + insts[_i].z * forward.y * zscale + y;
            insts[_i].id.z = insts[_i].x * right.z * xscale + insts[_i].y * up.z * yscale + insts[_i].z * forward.z * zscale + z;
            
            if(image_angle_sync){
                var _dir = point_direction(x, y, insts[_i].id.x, insts[_i].id.y) + image_angle_sync_angle_adjust;
                insts[_i].id.image_angle = _dir;
            }
        }    
    }

    static explode = function(_spd, _inherit_particle = false, _tag = "default"){
        for(var _i = 0; _i < array_length(insts); _i++){
            var _inst = insts[_i].id;
    
            var _dir = point_direction(x, y, _inst.x, _inst.y);
            
            var _sub_inst = instance_create_layer(_inst.x, _inst.y, _inst.layer, _inst.object_index);
            
            _sub_inst.z = _inst.z; 
            
            _sub_inst.xscale = _inst.image_xscale;
            _sub_inst.yscale = _inst.image_yscale;
            
            _sub_inst.alpha = _inst.alpha;
            _sub_inst.additive = _inst.additive;
            _sub_inst.additive_ext = _inst.additive_ext;
    
            _sub_inst.image_index = _inst.image_index;
            _sub_inst.image_speed = _inst.image_speed;
            _sub_inst.image_blend = _inst.image_blend;
            _sub_inst.image_angle = _inst.image_angle;
            _sub_inst.image_alpha = _inst.image_alpha;
            _sub_inst.mask_index = _inst.mask_index;
            
            _sub_inst.direction = _dir;
            
            var _dist = point_distance(x, y, _inst.x, _inst.y);
            _sub_inst.speed = (far_dist != 0) ? (_dist / far_dist) * _spd : _spd;
            
            if (variable_instance_exists(_sub_inst, "is_from_pool") && _sub_inst.is_from_pool) {
                   _sub_inst.x += lengthdir_x(_sub_inst.speed, _sub_inst.direction);
                   _sub_inst.y += lengthdir_y(_sub_inst.speed, _sub_inst.direction);
                   _sub_inst.is_from_pool = false; 
               }
            
            if(object_is_ancestor(_sub_inst.object_index, obj_danmaku_parents)){
                _sub_inst.outsidekill = true; 
                _sub_inst.enable_projection = false; 
                
                if(_inherit_particle && variable_instance_exists(_inst, "particle_emitter") && _inst.particle_emitter != undefined){
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
}