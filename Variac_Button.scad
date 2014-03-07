//Variac Button 3D model
//(c) 2014 juca@members.fsf.org
//
//Licensed under the terms of the GNU General Public License version 3 or 
//at your option, any later version, as published by the Free Software Foundation


$fn=120;
H=50;
R=50;
r=40;
disc_r = 20;
disc_h1 = 2;
disc_h2 = 10;
cut_r = 15;
N=10;
sphere_r = 100;

difference(){
	cylinder(r2=r, r1=R, h=H);

	for (i=[1:N]){
		rotate(i*360/N)
		translate([r+cut_r+1,0])
		cylinder(r=cut_r, h=H);
	}

	translate([0,0,sphere_r+H-7])
	sphere(r=sphere_r);
}


difference(){
	union(){
		cylinder(r=R+disc_r, h=disc_h1);

		translate([0,0,disc_h1])
		cylinder(r2=r, r1=R+disc_r, h=disc_h2-disc_h1);
	}


	for (i=[1:N]){
		rotate(i*180/N)
		translate([0,0,disc_h1])
		linear_extrude(height=disc_h2)
		square([2*(R+disc_r),3], center=true);
	}
}

union(){
		cylinder(r=R+disc_r, h=disc_h1);

		translate([0,0,disc_h1-1])
		cylinder(r2=r, r1=R+disc_r, h=disc_h2-disc_h1);
}

