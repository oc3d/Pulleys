Pulleys
=======

OpenSCAD pulley library for timing belts

This library defines modules that generate various pulleys, including several modules that define presets for 
standard belt sizes. By using the 'include' command, you can import this library into other SCAD files without
copying it over (this works just like C's #include: it's just an automatic copy-paste). 

DISCLAIMER: The models produced have never been printed or tested, so they may well not work at all. Or they
might. However, with suitable tweaking of the parameters, something workable should be obtainable if the presets
don't work.

The predefined belt standards are MXL, XL, L, M, H, and XH, which are various sizes of belts, from small to large.
There are modules mxl_pulley, xl_pulley, etc. that take these parameters:

  h                  height (belt width) of the pulley
  nteeth             number of teeth
  fancy              do fancy calculations (boolean). You should probably leave this at its default 'true'
  flange_r           amount of radius (above the tops of the teeth) to use for the flange (default 0 (no flange))
  flange_angle       angle of the flange (default 45 deg); 90 is straight out overhanging, 0 doesn't make sense
  flange_extrude     height of the extruded part of the flange.
  
   _______________
  |_______________|   <-- this is the extruded part of the flange
   \_____________/    <-- this is the angled part
    |||||||||||||     <-- this is the main part of the pulley
    |||||||||||||
    -------------
   /_____________\
  |_______________|
  
  
You can also use the more general 'pulley' module (which is what all of the other ones use; they just fill in
some of the parameters). This requires you to know some dimensions of the belt.
  
The parameters include (in addition to the ones already described):
  
  h1           height of the trapezoids
  angle        angle formed by the sides of the trapezoids
  toothwd      width of the protrudy trapezoid bit 
  pitch        'wavelength' of the belt teeth
  
    |<----- pitch ------>|
    |< toothwd >|
       ________             _______           ___
      /        \           /       \           ^
     /          \         /         \          h1
-----            ---------           ------   _v_
         BELT           .             .
-------------------------------------------
                      .                 .
                     .  .   angle    .   .
                    .      .  .   .       .
                     
                     
                     
    
    
