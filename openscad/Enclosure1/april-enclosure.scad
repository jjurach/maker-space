
control_length = 67.05;
control_width = 67.05;
control_height = 15;

power_length = 20;
back_length = 40;

relay_length = 70.4 + 2;
relay_width = 17.07;
relay_height = 16;

control_shim = (relay_length - control_width) / 2;

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
hslot_height = 12;
hslot_angle = 45;

mount_length = hslot_length / 2;
mount_width = hslot_width / 2;
mount_height = hslot_height / 2;

shim_height = hslot_height / 4;

port_width = 30;
port_height = 15;

jack_offset = 15;
jack_height = 15;
jack_diameter = 11.5;

switch_offset = 8;
switch_height = 10;
switch_width = 12.4;
switch_length = 18.8;

rack_width = 10;

// outside dimensions for enclosure box
width = relay_length + 2 * corner_radius;
length = power_length + 2 * relay_width + 2 * inner_wall_thickness + back_length + 2 * corner_radius;
// length = control_length + back_length + 2 * corner_radius;
height = control_height + relay_height + mount_height;

// internal boundaries
int_x0 = -width / 2 + corner_radius;
int_y0 = -length / 2 + corner_radius;
int_x1 = width / 2 - corner_radius;
int_y1 = length / 2 - corner_radius;

usb_width = 4;
usb_length = 10;
usb_height = height - mount_height - usb_width;

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
		translate([-port_width / 2, int_y1-0.1, height-port_height])
		cube([port_width, wall_thickness+0.2, port_height+0.1]);

		// jack hole
		translate([int_x0 + jack_offset, int_y0-wall_thickness-0.1, jack_height])
		rotate([-90,0,0])
		cylinder(h=wall_thickness+0.2, r=jack_diameter/2);

		// switch hole
		translate([int_x1 - switch_offset - switch_length, int_y0-wall_thickness-0.1, switch_height])
		cube([switch_length, wall_thickness+0.2, switch_width]);

	    // usb hole
		translate([-usb_length/2, int_y0-wall_thickness-0.1, usb_height])
		cube([usb_length, wall_thickness+0.2, usb_width+0.2]);
	}
}

module fin()
{
	cube([ width - corner_radius, inner_wall_thickness, height / 4 ]);
}

module hslot(hlength=hslot_length, hwidth=hslot_width,hheight=hslot_height)
{
	difference() {
		cube([ hwidth, hlength, hheight ]);
		
		rotate([0,hslot_angle,0])
		translate([-0.1,-0.1,0])
		cube([hwidth, hlength+0.2, 2*hheight]);
	}
}

module enclosure_internals()
{
    // bottom fins
	translate([ int_x0, int_y0 + power_length, 0 ])
	fin();

	translate([ int_x0, int_y0 + power_length + inner_wall_thickness + relay_width, 0 ])
	fin();

	translate([ int_x0, int_y0 + power_length + 2 * inner_wall_thickness + 2 * relay_width, 0 ])
	fin();

    // wire rack
	translate([int_x0, int_y1-rack_width, 0])
	cube([width - corner_radius, rack_width, height-port_height]);


	// control mounts

    // back left
	translate([ int_x0, int_y0, relay_height ])
	hslot(hslot_length);

	translate([ int_x0, int_y0, relay_height + hslot_height ])
	cube([control_shim, hslot_length, shim_height ]);

    // front left
	translate([ int_x0, int_y0 + control_length - hslot_length + inner_wall_thickness, relay_height ])
	hslot(hslot_length);

	translate([ int_x0, int_y0 + control_length - hslot_length + inner_wall_thickness, relay_height + hslot_height ])
	cube([control_shim, hslot_length, shim_height ]);

	translate([ int_x0, int_y0 + control_length, relay_height + hslot_height ])
	cube([hslot_width, inner_wall_thickness, shim_height ]);

	// back right
	translate([ int_x1, int_y0, relay_height ])
	mirror([1,0,0])
	hslot(hslot_length);

	translate([ int_x1-control_shim, int_y0, relay_height + hslot_height ])
	cube([control_shim, hslot_length, shim_height ]);

	// front right
	translate([ int_x1, int_y0 + control_length - hslot_length + inner_wall_thickness, relay_height ])
	mirror([1,0,0])
	hslot(hslot_length);

	translate([ int_x1-control_shim, int_y0 + control_length - hslot_length + inner_wall_thickness, relay_height + hslot_height ])
	cube([control_shim, hslot_length, shim_height ]);

	translate([ int_x1-hslot_width, int_y0 + control_length, relay_height + hslot_height ])
	cube([hslot_width, inner_wall_thickness, shim_height ]);

	// lid mounts

	translate([ int_x0, int_y0, height-1.5*mount_height ])
	hslot(mount_length, mount_width, 1.5*mount_height);

	translate([ int_x1, int_y0, height-1.5*mount_height ])
	mirror([1,0,0])
	hslot(mount_length, mount_width, 1.5*mount_height);

	translate([ int_x0, int_y1-mount_width, height-1.5*mount_height ])
	hslot(mount_length, mount_width, 1.5*mount_height);

	translate([ int_x1, int_y1-mount_width, height-1.5*mount_height ])
	mirror([1,0,0])
	hslot(mount_length, mount_width, 1.5*mount_height);
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
