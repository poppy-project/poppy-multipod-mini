include <poppy_multipod_mini_def.scad>

use <robotis-scad/dynamixel/xl320.scad>

use <robotis-scad/ollo/ollo_tools.scad>


use <robotis-scad/frames/side_to_side_frame.scad>
use <robotis-scad/frames/U_horn_to_U_horn_frame.scad>
use <robotis-scad/frames/U_horn_frame.scad>

use <MCAD/rotate.scad>

function compute_leg_angle(legNumber, nLegs) = (legNumber-1)*(360/nLegs);

module add_support(nLegs, legMotorsRadius, supportType) {

  if (supportType=="ring") {

    difference () {
      union() {
        cylinder(h=OlloSegmentWidth, r=legMotorsRadius-ringSupportMotorAppendixLength, center=true);
        for (i=[1:nLegs]) {
          rotate([0,0,compute_leg_angle(i, nLegs)])
            translate([legMotorsRadius,0,0])
            rotate([0,0,90])
              side_to_side_frame(legMotorsRadius-1.5*OlloSpacing);
        }
      }
      cylinder(h=OlloSegmentWidth, r=legMotorsRadius-ringSupportMotorAppendixLength-ollo_segment_thickness(1), center=true);
    }
  }

  if (supportType=="circle") {

    shift = MotorHeight/2+ollo_segment_thickness(1)/2;

    translate([0,0,shift])
      circle_support(nLegs, legMotorsRadius);
    translate([0,0,-shift])
      circle_support(nLegs, legMotorsRadius);
  }

}

module circle_support(nLegs, legMotorsRadius) {
  difference() {
    cylinder(h=ollo_segment_thickness(1), r=legMotorsRadius-(MotorLength-MotorAxisOffset-OlloSpacing)+circleSupportMargin, center=true);
    for (i=[1:nLegs]) {
      rotate([0,0,compute_leg_angle(i, nLegs)])
        translate([legMotorsRadius-(MotorLength-MotorAxisOffset-OlloSpacing/2),0,0])
          rotate([0,0,90])
            threeOlloHoles();
    }
  }
}

module add_leg(legType, feetType) {

  if (legType=="default") {
    xl320_two_horns();
    add_U_horn_to_U_horn_frame(defaultUhornUhornLength)
      rotate([0,0,135]){
        xl320_two_horns();
        rotate([0,0,180])
          add_side_to_side_frame(defaultLegLength-3*OlloSpacing){
            xl320_two_horns();
            rotate([0,0,135])
            add_feet(feetType);
          }
      }
  }
}

module add_feet(feetType){

  if (feetType=="default") {
    U_horn_frame(defaultFeetLength);
  }

}

module poppy_multipod_mini(nLegs=nLegs, legMotorsRadius=legMotorsRadius, supportType="ring", legType="default", feetType="default"){

  add_support(nLegs, legMotorsRadius, supportType);
  for (i=[1:nLegs]) {
    rotate([0,0,compute_leg_angle(i, nLegs)])
      translate([legMotorsRadius,0,0])
        rotate([0,0,-90])
          add_leg(legType, feetType);
  }
}



// Testing
echo("##########");
echo("In poppy_multipod_mini.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 1;
if (p==1) {

  poppy_multipod_mini(nLegs=3, supportType="circle", legType="default", feetType="default");

  translate([500,0,0])
    poppy_multipod_mini(nLegs=4, supportType="ring", legType="default", feetType="default");


}
