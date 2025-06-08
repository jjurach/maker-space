$fn=60;

rail_length = 180;
rail_height = 32;
rail_base = 22.5;
rail_depth = 2.4;
screw_diameter = 3.0;

module posts(x, y, z, r)
{
    translate([ r,   r,   0 ])  cylinder(r = r, h = z);
    translate([ r,   y-r, 0 ])  cylinder(r = r, h = z);
    translate([ x-r, r,   0 ])  cylinder(r = r, h = z);
    translate([ x-r, y-r, 0 ])  cylinder(r = r, h = z);
}

difference() {
  translate([0, -rail_base, -rail_depth])
    hull()
    posts(x=rail_length, y=rail_base, z=rail_depth, r=rail_depth);

  translate([rail_length*1/3, -rail_base/2, -rail_depth-0.01])
    cylinder(r=screw_diameter/2, h=rail_depth+0.02);

  translate([rail_length*2/3, -rail_base/2, -rail_depth-0.01])
    cylinder(r=screw_diameter/2, h=rail_depth+0.02);
}

translate([rail_length*1/5, 0, -rail_depth])
  cube([rail_length*1/5, rail_height*1/2, rail_depth]);

translate([rail_length*3/5, 0, -rail_depth])
  cube([rail_length*1/5, rail_height*1/2, rail_depth]);

translate([0, rail_height*1/2, -rail_depth])
  hull()
  posts(x=rail_length, y=rail_height/2, z=rail_depth, r=rail_depth);
