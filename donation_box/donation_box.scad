// A laser-cut donation box for Garoa Hacker Clube
//
// (c) 2014 Felipe Correa da Silva Sanches <juca@members.fsf.org>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.



//=====================================================
// Comment out the following line in order to export
// the laser cutter plate of this design:
//
// !laser_cut_wood();
//
//=====================================================


use <tslot.scad>;

thickness = 6; //we'll use 6mm wood sheets
N=5; //number of interlaced tabs

// these are the overal dimensions of the parametric box
// TODO: known-issue: the hackerspace logo still does not scale properly
L = 250; //units: mm
H = 300; //units: mm

module face(){
	difference(){
		square([L, H]);
		for (i=[0:N]){
			translate([0,i*H/N])
			square([L/7.5, H/(2*N)], center=true);
		}

		for (j=[-1,1])
			for (k=[0,1])
				translate([L/2 + j*L/4,thickness + k*(H-2*thickness)])
				rotate(90)
				translate([0, -20])
				t_slot_holes(width=40, thickness=thickness, joint_size=5);

		translate([L, 0])
		difference(){
			translate([-L/(7.5*2), 0])
				square([L/7.5, H]);
			for (i=[0:N]){
				translate([0,i*H/N])
				square([L/7.5, H/(2*N)], center=true);
			}
		}
	}
}

module base_2d(){
	difference(){
		rotate(-30)
		circle(r=L/2 - 0.2, $fn=3);

		for (i=[1:3])
			rotate(120*i)
			translate([0,-L/4 - thickness/2 + 0.3])
			for (j=[-1,1])
				translate([j*L/4,0])
				t_slot_shape(3, 16);
	}

	for (i=[1:3])
		rotate(120*i)
		translate([0,-L/4 - thickness/2 + 0.3])
		for (j=[-1,1])
			translate([j*L/4,0])
			rotate(90)
			translate([0,-20])
			t_slot_joints(40, thickness, joint_size=5);
}

module base(){
	translate([0,0,thickness/2])
	linear_extrude(height=thickness)
	base_2d();
}

module cantos_2d(){
	difference(){
		base_2d();

		rotate(60)
		base_2d();		
	}
}

module canto_2d(){
	intersection(){
		cantos_2d();

		rotate(-90 -60)
		translate([L/3, 0])
		circle(r=L/5);
	}
}

module cantos(){
	translate([0,0,H - thickness*(3/2)])
	linear_extrude(height=thickness)
	for (i=[1:3])
		rotate(120*i)
		canto_2d();
}

module face_2d(n){
	difference(){
		face();
		scale(3) translate([0,-205]) import("logo_garoa.dxf");
	}
}

module sheet(n=0){
	rotate(120*n)
	translate([-L/2,-L/4])
	rotate([90,0])
	linear_extrude(height=thickness)
	face_2d(n);
}

sheet(1);
sheet(2);
sheet(3);
base();
cantos();


module laser_cut_wood(){
	face_2d(1);
	translate([L+1,0]) face_2d(2);
	translate([2*(L+1),0]) face_2d(3);
	translate([L/2, H + L/4 + thickness + 1]) base_2d();
	for (i=[0:2])
		translate([L/2 + L + L/3*i, H + L/4 + thickness + 1]) canto_2d();
}

