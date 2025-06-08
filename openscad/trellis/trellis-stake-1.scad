$fn=60;

stake_len = 180;
stake_radius = 5.4 / 2;
stake2_radius = 6.0 / 2;
stake_iterations = 15;

neck_len = 10;
neck_radius = stake_radius;

peg_len = 4;
peg_radius = 1.1;

module floor()
{
	max_len = 10000;
	translate([ -max_len / 2, -max_len / 2, -max_len / 2 ])
	cube([ max_len, max_len, max_len / 2 ]);
};

module stake()
{
    rotate([90,0,0]) union() {
        translate([0,0,-0.01]) cylinder(r=peg_radius, h=peg_len+0.02);

        offset0 = peg_len;
        translate([0,0,offset0-0.01]) cylinder(r=neck_radius, h=neck_len);

        segment_h = stake_len / stake_iterations / 2;
        for ( i = [0:stake_iterations-1] ) {
            offset1 = peg_len + neck_len + (2*i + 0) * segment_h;
            offset2 = peg_len + neck_len + (2*i + 1) * segment_h;
            translate([0,0,offset1-0.01]) cylinder(r=stake2_radius, h=segment_h+0.02);
            translate([0,0,offset2-0.01]) cylinder(r=stake_radius, h=segment_h+0.02);
        }
    };
}

difference() {
    stake();
    floor();
};
