
control_length = 67.05;
control_width = 67.05;
control_height = 20;

back_length = 20;
top_height = 10;

relay_length = 70.4;
relay_width = 17.07;
relay_height = 20;

buck_length = 43.3;
buck_width = 21.0;
buck_height = 12;

$fn = 50;

corner_radius = 5;
wall_thickness = 4;
post_diameter = 10;
hole_diameter = 3;
lid_thickness = 2;
lid_lip = 2;
lid_tolerance = .5;

rim_height = 6;
lid_offset = 15;

// outside dimensions for enclosure box
width = relay_length + 2 * wall_thickness;
length = control_length + back_length + 2 * wall_thickness;
height = control_height + relay_height + top_height + 2 * wall_thickness;

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

difference()
{
	// box
	hull()
	{
		posts(x = (width / 2 - corner_radius), y = (length / 2 - corner_radius), z = 0, h = height, r = corner_radius);
	}
	// hollow
	hull()
	{
		posts(x = (width / 2 - corner_radius - wall_thickness), y = (length / 2 - corner_radius - wall_thickness),
		      z = wall_thickness, h = height, r = corner_radius);
	}
}

module junk()
{
	// lip inside box
	*hull()
	{
		posts(x = (width / 2 - corner_radius - lid_lip), y = (length / 2 - corner_radius - lid_lip),
		      z = (height - lid_thickness), h = lid_thickness + 1, r = corner_radius);
	}
}
difference()
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

*difference()
{
	hull()
	{
		posts(x = (width / 2 - corner_radius - wall_thickness / 2 - lid_tolerance),
		      y = (length / 2 - corner_radius - wall_thickness / 2 - lid_tolerance), z = height - lid_thickness + lid_offset,
		      h = lid_thickness, r = corner_radius);
	} 
    // lid holes
	posts(x = (width / 2 - wall_thickness / 2 - post_diameter / 2),
	      y = (length / 2 - wall_thickness / 2 - post_diameter / 2), z = height - lid_thickness + lid_offset - 0.1,
	      h = height - wall_thickness - lid_thickness + 5, r = hole_diameter / 2 + .5);
}

difference()
{
	hull()
	{
		posts(x = (width / 2 - corner_radius + wall_thickness / 2 + lid_tolerance),
		      y = (length / 2 - corner_radius + wall_thickness / 2 + lid_tolerance), z = height + lid_offset,
		      h = lid_thickness + rim_height, r = corner_radius);
	}
	// box
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
