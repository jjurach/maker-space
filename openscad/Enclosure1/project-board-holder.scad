
board_width = 20;
board_depth = 1.45;
stand_height = 20;
stand_width = board_width;
stand_depth = 10;

base_length = 70;
base_height = 5;

//component_height = 8.6;
component_height = 10.1;
notch_offset = component_height + base_height;
notch_depth = 5;

module pb_stand() {
    // verticle back
    translate([0,0,0])
        cube([stand_height,stand_width,stand_depth-notch_depth]);
    // verticle top
    translate([notch_offset+board_depth,0,0])
        cube([stand_height-notch_offset-board_depth,stand_width,stand_depth]);
    // verticle bottom 
    translate([0,0,0])
        cube([notch_offset,stand_width,stand_depth]);
    // horizontal base
    cube([base_height,stand_width,base_length]);
    
    // x -> z, z -> x
}

pb_stand();