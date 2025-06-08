
slot_width = 30;
slot_length = 180;
slot_length_skew = 20;
slot_depth = 20;

cube([slot_width, slot_length, slot_depth]);

polyhedron(points=[
  [0,0,0], // pt 0
  [0,0,slot_depth], // pt 1
  [slot_width,0,slot_depth], // pt 2
  [slot_width,0,0], // pt 3
  [], // pt 4
  [], // pt 5

], faces=[
]);


