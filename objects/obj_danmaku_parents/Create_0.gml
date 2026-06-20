// Please set its parent as the player killer object in your engine

// Default Settings
tag = "default";

// --- 1. Rendering---
enable_projection = false;
enable_collision_over_focal_length = true;
xscale = 1;
yscale = 1;
alpha = 1;

// --- 2. Physics---
z = DANMAKU_FOCAL_LENGTH;
zspeed = 0;          
zgrav = 0;         

direction_inc = 0;   


// --- 3. Homing---
homing_target = noone;
homing_speed = 0;     
homing_limit_time = -1;


// --- 4. Bounce---
bounce = true;  

// --- 5. Others---
additive = false;
additive_ext = false;
outsidekill = false;
particle_emitter = undefined;
collision = true;
destroy = false;

mask_index = sprite_index;