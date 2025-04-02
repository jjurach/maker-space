$fn = 50;

//outside dimensions for enclosure box
width = 180;
length = 120;
height = 50;

corner_radius = 5;
wall_thickness = 4;
post_diameter = 10;
hole_diameter = 3;
lid_thickness = 2;
lid_lip = 2;
lid_tolerance = .5;

module posts(x,y,z,h,r) {
    translate([x,y,z]) {
        cylinder(r=r, h=h);
    }
    translate([-x,y,z]) {
        cylinder(r=r, h=h);
    }
    translate([-x,-y,z]) {
        cylinder(r=r, h=h);
    }
    translate([x,-y,z]) {
        cylinder(r=r, h=h);
    }
}

difference() {
    //box
    hull() {
        posts(
        x=(width/2 - corner_radius),
        y=(length/2 - corner_radius),
        z=0,
        h=height,
        r=corner_radius);
    }
    //hollow
    hull() {
        posts(
        x=(width/2 - corner_radius - wall_thickness),
        y=(length/2 - corner_radius - wall_thickness),
        z=wall_thickness,
        h=height,
        r=corner_radius);
    }
    //lip inside box
    hull() {
        posts(
        x=(width/2 - corner_radius - lid_lip),
        y=(length/2 - corner_radius - lid_lip),
        z=(height - lid_thickness),
        h=lid_thickness+1,
        r=corner_radius);
    }
}

difference() {
    //support posts
    posts(
    x=(width/2 - wall_thickness/2 - post_diameter/2),
    y=(length/2 - wall_thickness/2 - post_diameter/2),
    z=wall_thickness-.5,
    h=height - wall_thickness - lid_thickness + .5,
    r=post_diameter/2);
    //support post holes
    posts(
    x=(width/2 - wall_thickness/2 - post_diameter/2),
    y=(length/2 - wall_thickness/2 - post_diameter/2),
    z=wall_thickness,
    h=height - wall_thickness - lid_thickness + .5,
    r=hole_diameter/2);
}

difference() {
    //lid
    hull() {
        posts(
        x=(width/2 - corner_radius - wall_thickness/2 - lid_tolerance),
        y=(length/2 - corner_radius - wall_thickness/2 - lid_tolerance),
        z=height - lid_thickness + 5,
        h=lid_thickness,
        r=corner_radius);

    }
    //lid holes
    posts(
    x=(width/2 - wall_thickness/2 - post_diameter/2),
    y=(length/2 - wall_thickness/2 - post_diameter/2),
    z=height - lid_thickness + .5,
    h=height - wall_thickness - lid_thickness + 5,
    r=hole_diameter/2 + .5);
}
































