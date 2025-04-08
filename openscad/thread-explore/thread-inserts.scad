$fn = 100;

hole_depth = 6;
hole_spacing = 7;
hole_count = 8;
hole_initial = 4.0;
hole_increment = 0.1;

rack_length = (hole_count+1)*hole_spacing;
rack_width = 2*hole_initial;
rack_height = 8;

x0 = -rack_length / 2;
y0 = -rack_width / 2;

difference() {

  translate([x0, y0, 0])
  cube([rack_length, rack_width, rack_height]);

  for ( i = [0:1:hole_count] ) {
    translate([x0 + (i+0.5)*hole_spacing, 0, rack_height-hole_depth])
      cylinder(h=hole_depth+0.1, r=(hole_initial + i*hole_increment)/2);
  }
}
