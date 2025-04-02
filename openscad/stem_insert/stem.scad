
stem_length = 60;
stem_width = 4;
// pixel = 0.85;f
pixel = stem_width / 5;

far_pocket_offset = 0.0;
near_pocket_offset = 23.0;
pocket_length = 12.0;

top_pocket = pocket_length / 2.0;

p0 = 0 * pixel;
p1 = 1 * pixel;
p2 = 2 * pixel;
p3 = 3 * pixel;
p4 = 4 * pixel;

function addv(dims, variance=0.005) = [dims[0]+variance, dims[1]+variance, dims[2]+variance];

// left pocket
pocket1 = stem_length - near_pocket_offset;

translate([p0, pocket1 - top_pocket, p0])    cube(addv([pixel, top_pocket, 3 * pixel]));

translate([p1, pocket1 - pocket_length, p0]) cube(addv([pixel, pocket_length, pixel]));
translate([p1, pocket1 - top_pocket, p2])    cube(addv([pixel, top_pocket, pixel]));

// center

translate([p1,p0,p0]) cube(addv([3*pixel, pocket1, pixel]));

translate([p2,p0,p0]) cube(addv([pixel, stem_length, 3*pixel]));

translate([p3,p0,p0]) cube(addv([pixel, stem_length, pixel]));

// right pocket
pocket2 = stem_length - far_pocket_offset;

translate([p3, pocket2 - pocket_length,p0]) cube(addv([pixel,pocket_length, pixel]));
translate([p3, pocket2 - top_pocket, p2])   cube(addv([pixel,top_pocket, pixel]));

translate([p4, pocket2 - top_pocket, p0])   cube(addv([pixel,top_pocket, 3 * pixel]));
