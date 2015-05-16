include <robotis-scad/ollo/ollo_def.scad>
include <robotis-scad/dynamixel/xl320_def.scad>
include <robotis-scad/frames/frame_def.scad>
include <robotis-scad/ollo_segments/ollo_segments_def.scad>
include <robotis-scad/specific_frames/specific_frame_def.scad>

nLegs = 4;
legMotorsRadius = 50;

defaultUhornUhornLength = 40;
defaultLegLength = 2*(MotorLength-MotorAxisOffset);
defaultFeetLength = 20 + defaultLegLength + MotorHeight/2 + 2*ollo_segment_thickness(1);

ringSupportMotorAppendixLength = MotorLength-MotorAxisOffset;
circleSupportMargin = OlloSpacing/2;
