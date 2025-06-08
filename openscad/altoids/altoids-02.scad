// Altoids tin insert

$fn = 100;

length = 90;
width = 55;
height = 20;
corner_radius = 12;
scoop_radius = 15;
thickness = 2.5;
wall_scale = (length - 2 * thickness) / length;

module roundedRect(x, y, z, radius)
{
	// http://www.thingiverse.com/thing:9347
	linear_extrude(height = z) hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([ (-x / 2) + (radius), (-y / 2) + (radius), 0 ])
		circle(r = radius);

		translate([ (x / 2) - (radius), (-y / 2) + (radius), 0 ])
		circle(r = radius);

		translate([ (-x / 2) + (radius), (y / 2) - (radius), 0 ])
		circle(r = radius);

		translate([ (x / 2) - (radius), (y / 2) - (radius), 0 ])
		circle(r = radius);
	}
}

difference()
{
	// Main tin
	roundedRect(length, width, height, corner_radius);

	difference()
	{
		translate([ 0, 0, thickness ])
		roundedRect(wall_scale * length - 0.01, wall_scale * width - 0.01, height - 0.01, wall_scale * corner_radius);

		// allow slightly bigger outside pockets to account for rounded corners of tin
		factor = 0.23;
		translate([ -length * factor - thickness / 2, -width / 2, thickness ])
		cube([ thickness, width, height ]);

		translate([ -thickness / 2, -width / 2, thickness ])
		cube([ thickness, width, height ]);

		translate([ length * factor - thickness / 2, -width / 2, thickness ])
		cube([ thickness, width, height ]);

		translate([ -length / 2, -width / 2, thickness - 0.01 ])
		intersection()
		{
			cube([ length, scoop_radius, scoop_radius ]);

			difference()
			{
				cube([ length - 0.01, scoop_radius * 2, scoop_radius * 2 ]);
				translate([ 0, scoop_radius, scoop_radius ])
				rotate([ 0, 90, 0 ])
				cylinder(h = length, r = scoop_radius);
			}
		}

		translate([ -length / 2, width / 2 - scoop_radius, thickness - 0.01 ])
		intersection()
		{
			cube([ length, scoop_radius, scoop_radius ]);

			difference()
			{
				cube([ length - 0.01, scoop_radius * 2, scoop_radius * 2 ]);
				translate([ 0, 0, scoop_radius ])
				rotate([ 0, 90, 0 ])
				cylinder(h = length, r = scoop_radius);
			}
		}
	}
}
