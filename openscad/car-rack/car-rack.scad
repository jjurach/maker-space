
fwd_width = 21.0;
bwd_width = 24.4;
bwd_skew = 1;
fwd_skew = 0;
slot_length = 140;
slot_depth = 34;
fwd_side_skew = 1.2;
bwd_side_skew = 1.2;
fwd_top_skew = 2.5;
bwd_top_skew = 9.5;

module base()
{
	polyhedron(points =
	               [
		               [ 0, 0, 0 ],                                  // pt 0
		               [ -bwd_side_skew, -bwd_top_skew, slot_depth ], // pt 1

		               [ bwd_width + bwd_side_skew, bwd_skew - bwd_top_skew, slot_depth ], // pt 2
		               [ bwd_width, bwd_skew, 0 ],                                        // pt 3

		               [ fwd_width, slot_length + fwd_skew, 0 ],                                        // pt 4
		               [ fwd_width + fwd_side_skew, slot_length + fwd_skew + fwd_top_skew, slot_depth ], // pt 5

		               [ -fwd_side_skew, slot_length + fwd_top_skew, slot_depth ], // pt 6
		               [ 0, slot_length, 0 ],                                     // pt 7

	               ],
	           faces = [
		           [ 0, 1, 2, 3 ],
		           [ 2, 5, 4, 3 ],
		           [ 5, 6, 7, 4 ],
		           [ 6, 1, 0, 7 ],
		           [ 1, 6, 5, 2 ],
		           [ 0, 3, 4, 7 ],
	           ]);
}

difference()
{
	base();

	translate([ fwd_width / 5, slot_length / 20, -slot_depth ])
	cube([ fwd_width * 3 / 5, slot_length * 9 / 10, 4 * slot_depth ]);

	//translate([-500, -500, -1]) cube([1000,1000, slot_depth-2]);
};

module triangle_prism()
{
	polyhedron(points =
	               [
		               [ 0, 0, 0 ],                                  // pt 0
		               [ fwd_width, 0, 0 ],                          // pt 1
		               [ fwd_width, 0, slot_depth ],                 // pt 2
		               [ 0, 0, slot_depth ],                         // pt 3
		               [ fwd_width, -slot_length_skew, 0 ],          // pt 4
		               [ fwd_width, -slot_length_skew, slot_depth ], // pt 5
	               ],
	           faces = [ [ 0, 1, 2, 3 ], [ 1, 4, 5, 2 ], [ 3, 5, 4, 0 ], [ 1, 0, 4 ], [ 2, 5, 3 ] ]);
}
