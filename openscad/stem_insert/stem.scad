
stem_length = 60;
stem_width = 3.8;
// pixel = 0.85;
pixel = stem_width / 5;

pocket_offset = 0.0;
pocket_length = 8.0;
pocket_width = 1.4;

top_pocket = pocket_length / 2.0;

p0 = 0 * pixel;
p1 = 1 * pixel;
p2 = 2 * pixel;
p3 = 3 * pixel;
p4 = 4 * pixel;

function addv(dims, variance=0.005) = [dims[0]+variance, dims[1]+variance, dims[2]+variance];

difference() {
  union() {
    color([0,1,0]) translate([p0,p0,p0]) cube(addv([p2, stem_length, p1]));
    color([0,0,1]) translate([p0,p0,p1]) cube(addv([p1, stem_length, p1]));

    color([1,0,0]) translate([p0,p0,p0]) cube(addv([p3, pocket_length, p3]));
  }
  translate([p3/2-pocket_width/2,p0-0.1,p3/2-pocket_width/2]) cube(addv([pocket_width, pocket_length/2, pocket_width]));
}

//color([1,1,0]) translate([p2,p0,p0]) cube(addv([p1, pocket_length, p3]));
//color([0,1,1]) translate([p0,p0,p2]) cube(addv([p2, pocket_length, p1]));
