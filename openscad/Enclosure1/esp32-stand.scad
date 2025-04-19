
spacing = 2.54;
numpins = 15;
pinwidth = 1.2;

length = ( numpins + 2) * spacing;
width = 2 * spacing;
height = 3 * spacing;

x0 = -width / 2;
y0 = -length / 2;

difference()
{
	translate([ x0, y0, 0 ])
	cube([ width, length, height ]);

	// translate([ 0, 0, 10 ])
	for (i = [1:1:numpins])
	{
		translate([ -pinwidth / 2, y0 - pinwidth / 2 + (i + 0.5) * spacing, spacing-0.3 ])
		cube([ pinwidth, pinwidth, 2*spacing + 0.4 ]);
	}
}
