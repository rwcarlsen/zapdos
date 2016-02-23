l1pm = 1e-12;
l10pm = 1e-11;
l100pm = 1e-10;
l1nm = 1e-9;
l10nm = 1e-8;
l100nm = 1e-7;
l1um = 1e-6;
l10um = 1e-5;
l50um = 5e-5;
l100um = 1e-4;
l1mm = 1e-3;
locInt = 1e-3;
locEnd = 1.0001e-3;
z = 0;

// Left gas boundary. Top to bottom
Point(1) = {z, z, z, 2e-9};
Point(2) = {l10um, z, z, l1um/2};
Line(1) = {1,2};
Point(3) = {l100um, z, z, l10um/2};
Line(2) = {2,3};
Point(4) = {locInt - l100um, z, z, l10um/4};
Line(3) = {3,4};
Point(5) = {locInt - l10um, z, z, l1um/2};
Line(4) = {4,5};
Point(6) = {locInt - l1um, z, z, l100nm/2};
Line(5) = {5,6};
Point(7) = {locInt - l100nm, z, z, l10nm/2};
Line(6) = {6,7};
Point(8) = {locInt, z, z, l100pm/8};
Line(7) = {7,8};

// Left liquid boundary. Top to bottom
Point(9) = {locInt + l1nm, z, z, l100pm};
Line(8) = {8,9};
Point(10) = {locEnd, z, z, l1nm};
Line(9) = {9,10};
Physical Line(0) = {1,2,3,4,5,6,7};
Physical Line(1) = {8,9};

// Top boundary. Left to right.
Point(11) = {0, l1mm, 0, l10um};
Line(10) = {1, 11};
Physical Line(2) = {10};

// Interface. Left to right.
Point(12) = {locInt, l1mm, 0, l10um};
Line(11) = {8, 12};
Physical Line(3) = {11};

// Bottom bounday. Left to right
Point(13) = {locEnd, l1mm, 0, l10um};
Line(12) = {10, 13};
Physical Line(4) = {12};

// Right dish wall. Bottom to top
Line(13) = {13, 12};
Physical Line(5) = {13};

// Right gas boundary. Bottom to top.
Line(14) = {12, 11};
Physical Line(6) = {14};

// Gas domain
Line Loop(15) = {1, 2, 3, 4, 5, 6, 7, 11, 14, -10};
Plane Surface(16) = {15};

// Liquid domain
Line Loop(17) = {8, 9, 12, 13, -11};
Plane Surface(18) = {17};