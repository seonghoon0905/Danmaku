if(ENABLE_PARTICLE_SYSTEM && particle_emitter != undefined){ 
    if(particle_sync){
        part_type_destroy(particle_type);
    }
    
    part_emitter_destroy(global.danmaku_particle_system, particle_emitter);
    part_particles_clear(global.danmaku_particle_system);
}