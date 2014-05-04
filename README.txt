READ ME:

This script is initiated by running the TrussAnalyzerMain.m file

This matlab script will ask the user to load an input file. 
This input file should be formatted as in the included 550.m file.

The Sx and Sy Matrices say the amount of [horizontal vertical 45degDiagonal] force applied to each member. For the conditions in our sample scenario, only the 1st member (left side) of the Truss has a vertical and horizontal force.

The X and Y vectors represent the coordinates of each vertex of the Truss. In essence
the script will graph the coordinate "dots" first, and then use the C matrix to figure out
which vertex connects to which other vertices. 

If given correct input parameters the program will calculate the Torsion forces on each member and then graphically output the Truss along with a graphical representation of the Torsional forces.

The colors represent how close a member is to failure.

Blue = member is very safe
Yellow = member is okay
Orange = getting closer to failure
Red = very close to failure
BOLD = member has failed


For sample output open gfx_output.jpg