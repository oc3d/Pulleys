fudge_ir = -0.01;
fudge_or = 0.0;
fudge_botwd = 0.0;
fudge_topwd = 0.0;

module mxl_pulley (h, nteeth, fancy=true, flange_r=0, flange_angle=45, flange_extrude=0){
	pulley(h=h, nteeth=nteeth, h1=0.02, pitch=0.08, angle=40, toothwd=0.045, fancy=fancy, flange_r=flange_r, flange_angle=flange_angle, flange_extrude=flange_extrude);
}

module xl_pulley (h, nteeth, fancy=true, flange_r=0, flange_angle=45, flange_extrude=0){
	pulley(h=h, nteeth=nteeth, h1=0.05, thick=0.04, pitch=0.2, angle=50, toothwd=0.101, fancy=fancy, flange_r=flange_r, flange_angle=flange_angle, flange_extrude=flange_extrude);
}

module l_pulley (h, nteeth, fancy=true, flange_r=0, flange_angle=45, flange_extrude=0){
	pulley(h=h, nteeth=nteeth, h1=0.075, pitch=0.375, angle=40, toothwd=0.183, fancy=fancy, flange_r=flange_r, flange_angle=flange_angle, flange_extrude=flange_extrude);
}

module h_pulley (h, nteeth, fancy=true, flange_r=0, flange_angle=45, flange_extrude=0){
	pulley(h=h, nteeth=nteeth, h1=0.09, pitch=0.5, angle=40, toothwd=0.241, fancy=fancy, flange_r=flange_r, flange_angle=flange_angle, flange_extrude=flange_extrude);
}

module xh_pulley (h, nteeth, fancy=true, flange_r=0, flange_angle=45, flange_extrude=0){
	pulley (h=h, nteeth=nteeth, h1=0.25, pitch=0.875, angle=40, toothwd=0.495, fancy=fancy, flange_r=flange_r, flange_angle=flange_angle, flange_extrude=flange_extrude);
}
	
module pulley (h, nteeth, h1, thick, pitch, angle, toothwd, fancy, flange_r, flange_angle, flange_extrude){
	flange_ht = flange_r / tan(flange_angle);
	echo(flange_angle);
	echo(flange_r);
	echo(flange_extrude);
	a = pitch - toothwd;
	z_orig = 90 - (angle/2);
	t_orig = a + 2 * h1/tan(z_orig);

	phi = ((fancy==true)? 360.0/nteeth : 0);
	angle = angle - phi/2;
	pr = (nteeth * pitch)/(2*3.1415926);	// pitch radius
	or = pr - thick/2 + fudge_or;			// outer radius
	ir = pr - thick/2 - h1 + fudge_ir;	// inner radius
	z = 90 - (angle/2);
	t = a + 2 * h1/tan(z);
	tdiff = t_orig - t;
	b = a + tdiff;
	for (i=[0:nteeth-1]){
		rotate([0,0,i*(360.0/nteeth)]){
			translate([-t/2,0,flange_ht+flange_extrude]){
				linear_extrude(height=h){
					polygon(points=[[0,0],[0,ir],[(t-b)/2, or], [b + (t-b)/2, or], [t, ir], [t, 0]]);
				}
			}
		}
	}
/*
	cylinder(r=flange_r + r_base + h1, h=flange_extrude, $fn=64);	// lower extrude
	translate([0,0,flange_extrude]){	// lower sloped
		cylinder(r1=flange_r + r_base + h1, r2=r_base + h1, h=flange_ht, $fn=64);
	}
*/

	translate([0,0,flange_ht + flange_extrude]){	// main cylinder
		cylinder(r=ir, h=h, $fn=64);
	}

/*
	translate([0,0,flange_ht+h+flange_extrude]){	// upper sloped
		cylinder(r1=r_base + h1, r2=r_base + flange_r + h1, h=flange_ht, $fn=64);
	}
	translate([0,0,2*flange_ht+h+flange_extrude]){	// upper extrude
		cylinder(r=flange_r + r_base + h1, h=flange_extrude, $fn=64);
	}
*/
}

function tan (theta) = sin(theta)/cos(theta);

//translate([0,0,10]) clyinder (r=7.86/2, h=20, center=true, $fn=6);
nholes=5;
difference (){
	scale(25.4){ xl_pulley(h=0.25, nteeth=20, flange_r=0.1, flange_angle=45, flange_extrude=0.05, fancy=true);
	}

	cylinder(r=2.1, h=100, center=true, $fn=32);
	translate([0,0,16.5]) cylinder(r=4, h=10, center=true, $fn=6);
	for (i=[0:nholes-1]) {
		rotate([0,0,i*(360/nholes)]) {
			translate([8,0,0]) cylinder(r=3.5, h=100, center=true, $fn=32);
		}
	}

}