$fn=60;

llama_leg_diameter = 18;
cast_diameter = 30;
llama_stump_height = 33;
cast_height = 42;

llama_stump_length = cast_height - llama_stump_height;

module legpart() {
    translate([0,0,-cast_height/20])
        rotate([0,-5,0])
            cylinder(cast_height,cast_diameter/2,cast_diameter/2);
}

module footpart() {
    translate([cast_diameter*0.75,0,0])
        rotate([0,-75,0])
            cylinder(cast_diameter/1.5,cast_diameter/3,cast_diameter/2);
}

module llama() {
    translate([0,0,cast_height])
        cylinder(125,25,25);
    translate([-2,0,cast_height+0.1])
        rotate([0,180,0])
            cylinder(h=llama_stump_length+0.1,r1=llama_leg_diameter/1.8,r2=llama_leg_diameter/2.5);
}

module pedestal() {
    rotate([0,180,0])
        cylinder(125,25,25);
}

module llama_cast() {
    difference() {
        union() {
            legpart();
            footpart();
        };
        llama();
        pedestal();
    }
}

llama_cast();
