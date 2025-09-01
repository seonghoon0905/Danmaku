function danmaku_pseudo_random(_x, _seed){
	return abs(frac(sin(_x) * _seed));
}

function danmaku_smoothstep(_edge1, _edge2, _x){
	var _y = clamp(0, (_x - _edge1) / (_edge2 - _edge1), 1);
	return _y * _y * _y * (_y * (_y * 6 - 15) + 10);
}

function danmaku_noise(_x, _seed){
	var _a = pseudo_random(floor(_x), _seed);
	var _b = pseudo_random(floor(_x + 1), _seed);
	return lerp(_a, _b, danmaku_smoothstep(0, 1, frac(_x)));
}