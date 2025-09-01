if(z > DANMAKU_ZNEAR && z < DANMAKU_ZFAR){
    if(additive){
        gpu_set_blendmode(bm_add);
        draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
        
        if(additive_ext){
            draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
        }
        
        gpu_set_blendmode(bm_normal);
    }
    else{
        if(enable_3d){
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(true);
            gpu_set_alphatestenable(true);
            gpu_set_depth(z);
        }
         
        draw_self();
        
        if(enable_3d){
            gpu_set_ztestenable(false);
            gpu_set_zwriteenable(false);
            gpu_set_alphatestenable(false);
        }
    }
}