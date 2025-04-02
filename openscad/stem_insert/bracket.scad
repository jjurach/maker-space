
length = 8;

bottom_wall = 0.3;
lower_wall = 0.3;
lower_hole = 1.0;
inner_wall = 0.80;
upper_wall = 0.3;
upper_hole = 1.6;
top_wall = 0.3;

x0 = 0;
x1 = x0 + lower_wall;
x2 = x1 + lower_hole;
x3 = x2 + inner_wall;
x4 = x3 + lower_hole;
x5 = x4 + lower_wall;
lower_width = x5;

w1 = 0.5*lower_width - 0.5*upper_hole - upper_wall;
w2 = w1 + upper_wall;
w3 = w2 + upper_hole;
w4 = w3 + upper_wall;
upper_width = w4 - w1;

y0 = 0;

z0 = 0;
z1 = z0 + bottom_wall;
z2 = z1 + lower_hole;
z3 = z2 + bottom_wall;
z4 = z3 + upper_hole;
z5 = z4 + top_wall;

variance = 0.005;
function addv(dims) = [ dims[0]+variance, dims[1]+variance, dims[2]+variance ];

translate([x0, y0, z0]) cube(addv([lower_width, length, bottom_wall]));

translate([x0, y0, z1]) cube(addv([lower_wall, length, lower_hole]));
translate([x2, y0, z1]) cube(addv([inner_wall, length, lower_hole]));
translate([x4, y0, z1]) cube(addv([lower_wall, length, lower_hole]));

translate([x0, y0, z2]) cube(addv([lower_width, length, bottom_wall]));

translate([w1, y0, z3]) cube(addv([upper_wall, length, upper_hole]));
translate([w2, length/2, z3]) cube(addv([upper_hole, length/2, upper_hole]));
translate([w3, y0, z3]) cube(addv([upper_wall, length, upper_hole]));

translate([w1, y0, z4]) cube(addv([upper_width, length, top_wall]));









