# GPS-IMU-Integration
Data from IEEE Open Access Paper (https://doi.org/10.1109/ACCESS.2016.2631000)

Contains code for generating plots in https://doi.org/10.1109/ACCESS.2016.2631000

File details:

1. TrackerWithAndroid: Core file

2. displayFig: MATLAB GUI Interface


TrackerWithAndroid

1. It will be necessary to change the file path to the current folder inside this file before executing.

Of the options given (EEWalk.mat, ...) upon running, please enter one of the following: 'EEWalk', 'SmallSquare', 'McLaneWalk' without the extensions (i.e. '.mat').

Show Orientation Tracking: Selecting 1 will display device orientation, path, and footstep tracking throughout the dataset. This may take a long time with EEWalk and McLaneWalk. SmallSquare data is small enough to permit observation.

Show Orientation Tracking with Mapping: (Will display if the previous option was not chosen). Shows mapping and tracking through animation. May take a long time with McLaneWalk and EEWalk. 

Show Final tracking map: will show if previous option was not selected. This is just a plot.

A future update will show how to use the GUI. At the moment, please see the PDFs (presentations and paper) to see the final results in action.
