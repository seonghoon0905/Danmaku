function Danmaku(_x, _y, _insts, _inside_rotation_param = undefined) : DanmakuBase() constructor {
    x = _x;
    y = _y;
    
    xscale = 1;
    yscale = 1;
    
    right = {x : 1, y : 0};
    up = {x : 0, y : 1};
    roll = 0;
	
    inside_rotation_param = variable_clone(_inside_rotation_param);
    
    static add_inst = function(_inst){
        array_push(insts, {
            id : _inst.id,
            x : _inst.x - x, 
            y : _inst.y - y,
        });
        add_inst_base(_inst, x, y); 
    }
    
    for(var _i = 0, _len = array_length(_insts); _i < _len; _i++){
        add_inst(_insts[_i]);
    }

    static set_position = function(_x, _y){
        x = _x; y = _y;
    }

    static add_position = function(_dx, _dy){
        x += _dx; y += _dy;
    }
    
    static set_center = function(_x, _y){
        for(var _i = 0, _len = array_length(insts); _i < _len; _i++){
            var _inst = insts[_i];
            _inst.x += x - _x; 
            _inst.y += y - _y;
        }
        x = _x; y = _y;
    }
    
    static add_center = function(_dx, _dy){
        for(var _i = 0, _len = array_length(insts); _i < _len; _i++){
            var _inst = insts[_i];
            _inst.x -= _dx; 
            _inst.y -= _dy;
        }
        x += _dx; y += _dy;
    }

    static set_scale = function(_scale){
        xscale = _scale;
        yscale = _scale;
    }
    
    static add_scale = function(_dscale){
        xscale += _dscale; yscale += _dscale;
    }
    
    static set_xscale = function(_xscale){ xscale = _xscale; }
    static add_xscale = function(_dxscale){ xscale += _dxscale; }
    static set_yscale = function(_yscale){ yscale = _yscale; }
    static add_yscale = function(_dyscale){ yscale += _dyscale; }

    static set_rotation = function(_roll){
        roll = _roll;
        update_local_axes();
    }
    
    static add_rotation = function(_droll){
        roll += _droll;
        update_local_axes();
    }
    
    static update_local_axes = function(){
        var _cr = dcos(roll); 
        var _sr = dsin(roll); 
        
        right.x = _cr;
        right.y = _sr;
        
        up.x = -_sr;
        up.y = _cr;
    }

    static update_danmaku = function(){
        var _len = array_length(insts);
        for(var _i = 0; _i < _len; _i++){
            var _inst_data = insts[_i];
            var _real_inst = _inst_data.id; 
            
            if(!instance_exists(_real_inst)) continue;

            _real_inst.x = right.x * xscale * _inst_data.x + up.x * yscale * _inst_data.y + x;
            _real_inst.y = right.y * xscale * _inst_data.x + up.y * yscale * _inst_data.y + y;
            
            if(image_angle_sync){
                var _dir = point_direction(x, y, _real_inst.x, _real_inst.y) + image_angle_sync_angle_adjust;
                _real_inst.image_angle = _dir;
            }
        }    
    }
	
	static explode = function(_spd, _inherit_particle = false, _tag = "default"){
        for(var _i = 0, _len = array_length(insts); _i < _len; _i++){
            var _inst = insts[_i].id;
    
            var _dir = point_direction(x, y, _inst.x, _inst.y);
            
            var _sub_inst = instance_create_layer(_inst.x, _inst.y, _inst.layer, _inst.object_index);
            
            _sub_inst.xscale = _inst.xscale;
            _sub_inst.yscale = _inst.yscale;
            _sub_inst.alpha = _inst.alpha;
            _sub_inst.additive = _inst.additive;
            _sub_inst.additive_ext = _inst.additive_ext;
            
            _sub_inst.image_index = _inst.image_index;
            _sub_inst.image_speed = _inst.image_speed;
            _sub_inst.image_xscale = _inst.image_xscale;
            _sub_inst.image_yscale = _inst.image_yscale;
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
               _sub_inst.is_from_pool = false; // 플래그 해제
           }
            
            if(object_is_ancestor(_sub_inst.object_index, obj_danmaku_parents)){
                _sub_inst.outsidekill = true;
                
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