
spacing = 2.54;
numpins = 15;
pinwidth = 0.5;

length = numpins * (spacing + 2);
width = 4 * spacing;
height = 2 * spacing;

x0 = -width / 2;
y0 = -length / 2;

difference()
{
	translate([ x0, y0, 0 ])
	cube([ width, length, height ]);

	// translate([ 0, 0, 10 ])
	for (i = [1:1:numpins])
	{
		translate([ -pinwidth / 2, y0 + (1 + i) * spacing - pinwidth / 2, spacing ])
		cube([ pinwidth, pinwidth, spacing + 0.1 ]);
	}
}
