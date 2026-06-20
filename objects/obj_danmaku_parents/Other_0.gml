if(outsidekill){
    if(particle_emitter != undefined){
        var _call_back = function(){
            instance_destroy();
        };
        call_later(particle_life, time_source_units_frames, _call_back);
        outsidekill = false;
    }
    else{
        instance_destroy();
    }
}