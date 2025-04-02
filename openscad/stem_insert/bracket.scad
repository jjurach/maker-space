
length = 8;

bottom_wall = 0.5;
lower_wall = 0.4;
lower_hole = 1.0;
inner_wall = 0.4;
top_wall = 0.5;

x0 = 0;
x1 = x0 + lower_wall;
x2 = x1 + lower_hole;
x3 = x2 + inner_wall;
x4 = x3 + lower_hole;
x5 = x4 + lower_wall;
lower_width = x5;

y0 = 0;

z0 = 0;
z1 = z0 + bottom_wall;
z2 = z1 + lower_hole;
z3 = z2 + top_wall;

variance = 0.005;
function addv(dims) = [ dims[0]+variance, dims[1]+variance, dims[2]+variance ];

translate([x0, y0, z0]) cube(addv([lower_width, length, bottom_wall]));

translate([x0, y0, z1]) cube(addv([lower_wall, length, lower_hole]));
translate([x2, y0, z1]) cube(addv([inner_wall, length, lower_hole]));
translate([x4, y0, z1]) cube(addv([lower_wall, length, lower_hole]));

translate([x0, y0, z2]) cube(addv([lower_width, length, top_wall]));









