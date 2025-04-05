
control_length = 67.05;
control_width = 67.05;
control_height = 20;

back_length = 40;
top_height = 10;

relay_length = 70.4;
relay_width = 17.07;
relay_height = 20;

buck_length = 43.3;
buck_width = 21.0;
buck_height = 12;

$fn = 50;

corner_radius = 4;
wall_thickness = 4;
inner_wall_thickness = 1.7;
post_diameter = 10;
hole_diameter = 3;
lid_thickness = 2;
lid_lip = 2;
lid_tolerance = .5;

rim_height = 6;
lid_offset = 15;

hslot_length = control_length / 6;
hslot_width = 8;
hslot_height = 15;
hslot_angle = 45;

// outside dimensions for enclosure box
width = relay_length + 2 * corner_radius;
length = 2 * relay_width + 2 * inner_wall_thickness + back_length + 2 * corner_radius;
// length = control_length + back_length + 2 * corner_radius;
height = control_height + relay_height + 2 * hslot_height;

module posts(x, y, z, h, r)
{
	translate([ x, y, z ])
	{
		cylinder(r = r, h = h);
	}
	translate([ -x, y, z ])
	{
		cylinder(r = r, h = h);
	}
	translate([ -x, -y, z ])
	{
		cylinder(r = r, h = h);
	}
	translate([ x, -y, z ])
	{
		cylinder(r = r, h = h);
	}
}

module enclosure()
{
	difference()
	{ // box
		hull()
		{
			posts(x = (width / 2 - corner_radius), y = (length / 2 - corner_radius), z = 0, h = height,
			      r = corner_radius);
		}
		// hollow
		hull()
		{
			posts(x = (width / 2 - corner_radius - wall_thickness), y = (length / 2 - corner_radius - wall_thickness),
			      z = wall_thickness, h = height, r = corner_radius);
		}
		// wire port
		translate([-10,length/2-corner_radius-1,height-10])
		{
			cube([20,3*wall_thickness+2,10+0.1]);
		}
	}
}

// lip inside box
*hull()
{
	posts(x = (width / 2 - corner_radius - lid_lip), y = (length / 2 - corner_radius - lid_lip),
			z = (height - lid_thickness), h = lid_thickness + 1, r = corner_radius);
}

*difference()
{
	// support posts
	posts(x = (width / 2 - wall_thickness / 2 - post_diameter / 2),
			y = (length / 2 - wall_thickness / 2 - post_diameter / 2), z = wall_thickness - .5,
			h = height - wall_thickness, r = post_diameter / 2);
	// support post holes
	posts(x = (width / 2 - wall_thickness / 2 - post_diameter / 2),
			y = (length / 2 - wall_thickness / 2 - post_diameter / 2), z = wall_thickness,
			h = height - wall_thickness + 0.1, r = hole_diameter / 2);
}

// this is the flat internal lid rather than the overflowing lid
*difference()
{
	hull()
	{
		posts(x = (width / 2 - corner_radius - wall_thickness / 2 - lid_tolerance),
				y = (length / 2 - corner_radius - wall_thickness / 2 - lid_tolerance),
				z = height - lid_thickness + lid_offset, h = lid_thickness, r = corner_radius);
	}
	// lid holes
	posts(x = (width / 2 - wall_thickness / 2 - post_diameter / 2),
			y = (length / 2 - wall_thickness / 2 - post_diameter / 2),
			z = height - lid_thickness + lid_offset - 0.1, h = height - wall_thickness - lid_thickness + 5,
			r = hole_diameter / 2 + .5);
}	

module slot()
{
	cube([ width - corner_radius + corner_radius / 2, inner_wall_thickness, height / 4 ]);
}

module hslot()
{
	difference() {
		cube([ hslot_width, hslot_length-0.4, hslot_height ]);
		
		rotate([0,hslot_angle,0])
		translate([-0.1,-0.1,0])
		cube([hslot_width,hslot_length+0.2, 2*hslot_height]);
	}
}

module enclosure_internals()
{
	// bottom fins
	translate([ -width / 2 + corner_radius / 2, -length / 2 + 2 * corner_radius + relay_width + wall_thickness, 0 ])
	slot();

	translate([
		-width / 2 + corner_radius / 2, -length / 2 + 2 * corner_radius + 2 * relay_width + 2 * wall_thickness, 0
	])
	slot();

	// control mounts

	translate([ -width / 2 + corner_radius / 2, -length / 2 + 3 / 4 * corner_radius, relay_height ])
	hslot();

	translate([ -width / 2 + corner_radius / 2, -length / 2 + control_length - hslot_length, relay_height ])
	hslot();

	translate([ width / 2 - corner_radius / 2, -length / 2 + 3 / 4 * corner_radius, relay_height ])
	mirror([1,0,0])
	hslot();

	translate(
		[ width / 2 - corner_radius / 2, -length / 2 + control_length - hslot_length, relay_height ])
	mirror([1,0,0])
	hslot();

	// lid mounts

	translate([
		-width / 2 + corner_radius / 2,
		-length / 2 + 3 / 4 * corner_radius,
		height - hslot_height
	])
	hslot();

	translate([
		-width / 2 + corner_radius / 2,
		length / 2 - hslot_length - corner_radius/2,
		height - hslot_height
	])
	hslot();

	translate([
		width / 2 - corner_radius / 2,
		-length / 2 + 3 / 4 * corner_radius,
		height - hslot_height
	])
	mirror([1,0,0])
	hslot();

	translate([
		width / 2 - corner_radius / 2,
		length / 2 - hslot_length - corner_radius /2,
		height - hslot_height
	])
	mirror([1,0,0])
	hslot();
}

module enclosure_lid()
{
	difference()
	{
		// outside lid
		hull()
		{
			posts(x = (width / 2 - corner_radius + wall_thickness / 2 + lid_tolerance),
					y = (length / 2 - corner_radius + wall_thickness / 2 + lid_tolerance), z = height + lid_offset,
					h = lid_thickness + rim_height, r = corner_radius);
		}
		// inside box within lid
		hull()
		{
			posts(x = (width / 2 - corner_radius - lid_tolerance), y = (length / 2 - corner_radius - lid_tolerance),
					z = height + lid_offset - 0.1, h = rim_height, r = corner_radius);
		}
		// lid post holes
		posts(x = (width / 2 - wall_thickness / 2 - post_diameter / 2),
				y = (length / 2 - wall_thickness / 2 - post_diameter / 2), z = height + lid_offset - 0.1,
				h = height - wall_thickness + 0.1, r = hole_diameter / 2);
	}
}

enclosure();
enclosure_internals();
//enclosure_lid();
