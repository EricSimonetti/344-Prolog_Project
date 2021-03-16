# 344-Prolog_Project
A prolog project for my programming languages class that finds the location and orientation of mirrors that would redirect a laser while avoiding obstacles
The size of the grid where lasers and objects can be places is 10 by 12, the laser always starts on the wall (x coordinate 0), and the goal is to create a 6 by 2 area for a person to pass through the laser, while ensuring the laser makes it to the detector on the other side as if it was unimpeded, that is, the laser hits the opposite wall at the same coordinate it started at. There are only 8 mirrors that occupy one corrdinate that can be used, but its ok if a path is found with less.
You can run the program by making use of the place_mirrors function, which takes the y coordinate of the laser, a list of obsticles, which are themselves lists, containing the size and corrdinate of the obsticle ([2, 2, 3] is a rectangular obsticle with its left corner at (2, 11) and has width 2 and height 3), and a variable which will be the output of the locations of the mirrors, along with their orientation.

Here is an illistration to help visualize what should be going on, from my professor's webpage https://danielschlegel.org/wp/teaching/csc344-fall-2019/assignment-4/:
![image](https://user-images.githubusercontent.com/56443205/111388704-233ef400-8686-11eb-8ece-104334d48556.png)

The example shown above would have the following input:
place_mirrors(3, [[2,2,3],[9,2,4]], X)
and subsequent output:
X = [[2,3,/],[2,7,/],[9,7,\],[9,3,\]]
