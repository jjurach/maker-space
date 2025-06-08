// Altoids tin insert

height = 20;
tin = [ 90, 55, height-0.01, 12 ]; // length, width, depth, corner radius

pockets = [
	[
		// Handle
		[ 85, 15, 17, 3 ], // L, W, D, R
		[ 0, 20, 0 ]       // Translation (x,y,z)
	],
	[
		// Top
		[ 38, 30, 17, 3 ], [ 22, -12, 0 ]
	],
	[
		// Bottom
		[ 38, 30, 17, 3 ], [ -22, -12, 0 ]
	],
	[
		// Thumb 1
		[ 25, 20, 10, 1 ], [ -22, 5, 0 ]
	],
	[
		// Thumb 2
		[ 25, 20, 10, 1 ], [ 22, 5, 0 ]
	],
];

difference()
{
	// Main tin
	roundedRect(tin);

	// Subtract pockets
	for (pocket = pockets)
	{
		pos = pocket[1];
		size = pocket[0];
		translate([ pos[0], pos[1], pos[2] + height - size[2] ])
		roundedRect(size);
	}
}

module roundedRect(size)
{
	// http://www.thingiverse.com/thing:9347
	x = size[0];
	y = size[1];
	z = size[2];
	radius = size[3];
	linear_extrude(height = z) hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([ (-x / 2) + (radius / 2), (-y / 2) + (radius / 2), 0 ])
		circle(r = radius);

		translate([ (x / 2) - (radius / 2), (-y / 2) + (radius / 2), 0 ])
		circle(r = radius);

		translate([ (-x / 2) + (radius / 2), (y / 2) - (radius / 2), 0 ])
		circle(r = radius);

		translate([ (x / 2) - (radius / 2), (y / 2) - (radius / 2), 0 ])
		circle(r = radius);
	}
}
