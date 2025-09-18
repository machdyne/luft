/*
 * Luft Case
 * Copyright (c) 2025 Lone Dynamics Corporation. All rights reserved.
 *
 * required hardware:
 *  - 4 x M3 x 6mm bolts
 *  - 4 x M3 x 25mm bolts
 *  - 8 x M3 nuts
 *
 */

$fn = 100;

board_width = 25;
board_thickness = 1.5;
board_length = 125;
board_height = 1.6;
board_spacing = 2;

case_width = 50;

wall = 2;

top_height = 50;
bottom_height = 6;

translate([wall,wall,0]) mta_board();
translate([28,5-10,45]) mta_fan();

translate([0,0,15])
	mta_case_top();

translate([0,0,-15])
	mta_case_bottom();

translate([45,-4,-20])
    mta_din_clip();
 
translate([45,-25,-20])
	mta_din_endclip();

module mta_board() {
	
	difference() {
		color([0,0.5,0])
			roundedcube(board_width,board_length,board_thickness,3);
		translate([4, 4, -1]) cylinder(d=3.2, h=10);
		translate([4, 121, -1]) cylinder(d=3.2, h=10);
		translate([21, 5, -1]) cylinder(d=3.2, h=10);
		translate([21, 121, -1]) cylinder(d=3.2, h=10);
	}	
	
}

module mta_fan() {
    color([0,0,1]) cube([30,10,30], center=true);
}

module mta_case_top() {

    translate([case_width-8,22.5,40]) cube([10,4,9.5]);

	difference() {
				
		color([0.5,0.5,0.5]) union() {
			roundedcube(case_width+(wall*2),board_length+(wall*2),top_height+1,2.5);
            
            
            
            translate([(case_width+(wall*2))/2+18.5,0,0])
                cylinder(d=17, h=bottom_height);
            rotate([30,0,0]) translate([(case_width+(wall*2))/2+18.5,4,4.25])
                cylinder(d=17, h=bottom_height);
            
            
            
            translate([(case_width+(wall*2))/2+18.5,board_length+(wall*2),0])
                cylinder(d=17, h=bottom_height);
            rotate([-30,0,0]) translate([(case_width+(wall*2))/2+18.5,board_length+(wall*2)-21.5,68.25])
                cylinder(d=17, h=bottom_height);

        }
        
		// cutouts
			
		translate([wall,wall,-1])
			roundedcube(case_width,board_length,50,2.5);

			
		translate([wall, wall, 0]) {

			// vents
            for (i = [5:5:120]) {
                translate([-5,i,20]) cube([20,1,50]);
			}
            for (i = [5:5:120]) {
                translate([35,i,20]) cube([30,1,50]);
			}			

    		// USBC
			translate([-10,board_length-24-(9.5/2),-1]) cube([30,9.5,3.5+1]);

    		// power
			translate([board_width/2-(9.5/2),124,-1]) cube([9.5,5,11.25+1]);

            // key switch
            translate([case_width/2,10,45]) cylinder(d=12, h=15);

            // fan port
            rotate([90,0,0]) translate([case_width/2,30,-1]) cylinder(d=25, h=100);

            // fan bolt holes
            rotate([90,0,0]) translate([case_width/2-12,30-12,-1]) cylinder(d=3.2, h=100);
            rotate([90,0,0]) translate([case_width/2+12,30+12,-1]) cylinder(d=3.2, h=100);
            rotate([90,0,0]) translate([case_width/2-12,30+12,-1]) cylinder(d=3.2, h=100);

            rotate([90,0,0]) translate([case_width/2+10,30-10,-1]) cylinder(d=8, h=100);

            // bolt holes
            translate([case_width/2+18.5, -6, -11]) cylinder(d=3.5, h=25);
            translate([case_width/2+18.5, board_length+6, -11]) cylinder(d=3.5, h=25);
            
			// text
            rotate(270) translate([-(board_length/2),case_width/2-(5/2),top_height+0.5])
                linear_extrude(1)
                    text("L U F T", size=5, halign="center",
                        font="Lato:style=Bold");

		}
		
	}	
}

module mta_case_bottom() {
	
	difference() {
        color([0.5,0.5,0.5]) union() {
            roundedcube(case_width+(wall*2),board_length+(wall*2),bottom_height,2.5);
            translate([(case_width+(wall*2))/2+18.5,0,0])
                cylinder(d=17, h=bottom_height);
            translate([(case_width+(wall*2))/2+18.5,board_length+(wall*2),0])
                cylinder(d=17, h=bottom_height);
        }
        
		// cutouts
		translate([3,9,1.5])
			roundedcube(board_width-3,board_length-15,10,2.5);
				
		translate([9,2.5,1.5])
			roundedcube(board_width-15,board_length-2,10,2.5);

		translate([3,60,1.5])
			roundedcube(case_width-wall,board_length-70,10,2.5);

        // SEN5x compartment
		translate([27+10,wall,1.5])
			cube([14,53,10]);


		translate([wall, wall, 0]) {
			
		// board cutout
		translate([0,0,bottom_height-board_height])
			roundedcube(board_width+0.25,board_length+0.25,board_height+1,2.5);

		translate([wall, wall, 0]) {

    		// USBC
			translate([-1.5,board_length-24-(11/2),1.5]) cube([20,11,3.5+1]);
			
		}

		// bolt holes
		translate([4, 4, -11]) cylinder(d=3.2, h=25);
		translate([4, 121, -11]) cylinder(d=3.2, h=25);
		translate([21, 4, -11]) cylinder(d=3.2, h=25);
		translate([21, 121, -11]) cylinder(d=3.2, h=25);
        
        translate([case_width/2+18.5, -6, -11]) cylinder(d=3.5, h=25);
		translate([case_width/2+18.5, board_length+6, -11]) cylinder(d=3.5, h=25);

		// nut holes
		translate([4, 4, -1]) cylinder(d=7, h=4, $fn=6);
		translate([4, 121, -1]) cylinder(d=7, h=4, $fn=6);
		translate([21, 4, -1]) cylinder(d=7, h=4, $fn=6);
		translate([21, 121, -1]) cylinder(d=7, h=4, $fn=6);

		}
		
	}	
}

module mta_din_clip() {
    
    difference() {
        translate([0,0,-3]) rcube(42,20,6,2.5);
        translate([0,0,-2]) cube([35-3,50,5], center=true);
        translate([0,0,-0.25]) cube([35+1,50,1.5], center=true);
        cylinder(d=3.5, h=50);
        translate([10,0,0]) cylinder(d=3.5, h=50);
        translate([-10,0,0]) cylinder(d=3.5, h=50);
    }
    
}

module mta_din_endclip() {
    
    difference() {
        translate([0,0,-3]) rcube(42,10,6,2.5);
        translate([0,0,-2]) cube([35-3,50,5], center=true);
        translate([0,5,-0.25]) cube([35+1,15,1.5], center=true);
    }
    
}

// https://gist.github.com/tinkerology/ae257c5340a33ee2f149ff3ae97d9826
module roundedcube(xx, yy, height, radius)
{
    translate([0,0,height/2])
    hull()
    {
        translate([radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,yy-radius,0])
        cylinder(height,radius,radius,true);

        translate([radius,yy-radius,0])
        cylinder(height,radius,radius,true);
    }
}

 module rcube(xx, yy, height, radius)
{
    translate([-xx/2,-yy/2,height/2])
    hull()
    {
        translate([radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,yy-radius,0])
        cylinder(height,radius,radius,true);

        translate([radius,yy-radius,0])
        cylinder(height,radius,radius,true);
    }
}
