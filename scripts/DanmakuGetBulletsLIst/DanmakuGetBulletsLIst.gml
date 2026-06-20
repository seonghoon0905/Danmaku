function get_danmaku_list_by_name(_suffix) {
    var _colors = [
        "red", "orange", "yellow", "chartreuse", "green", "emerald",
        "cyan", "azure", "blue", "violet", "magenta", "pink",
        "white", "gray", "black"
    ];
    
    var _list = [];
    
    for (var _i = 0; _i < array_length(_colors); _i++) {
        var _col_name = _colors[_i];
        
        var _obj_name = "obj_danmaku_" + _col_name + "_" + _suffix;
        
        var _obj_index = asset_get_index(_obj_name);
        
        if (_obj_index > -1) {
            array_push(_list, _obj_index);
        }
    }
    
    return _list;
}

function get_danmaku_cherry_list() {
    return get_danmaku_list_by_name("cherry");
}

function get_danmaku_bullet_list(_type_number) {
    return get_danmaku_list_by_name("bullet_" + string(_type_number));
}