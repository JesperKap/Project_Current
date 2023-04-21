# Project_Current
This repository stores relevant pieces of software that were created as part of my Final Bachelor Project 'Current' at the Future Mobility squad of the faculty of Industrial Design at Eindhoven University of Technology.

Iteration 1
  - 'Metaphorical_representations.pde'
  
    This file can be run as a standalone program in the Processing IDE. It features interactive explorations of visualizations that respond to a change in acceleration. With the cursor, you can choose to accelerate (towards plus sign), decelerate (towards minus sign) or stay at a constant speed (middle of the screen).

![Frame_3-01](https://user-images.githubusercontent.com/65406246/233704657-68bc4d16-a5c6-4967-afa7-f5145c2581b5.jpg)

Iteration 2
  - 'Delayed animations'

  Several programs were created for a user test to investigate the role of timing of a visualization to the response time of participants to an accelerating vehicle. In the baseline run, no visualization is shown. In the other runs, a visualization is shown a certain amount of time before the actual acceleration takes place.  
  
    - 'Baseline_run.ino'

    No visualization is shown.

    - 'Run_0.ino'
    
    The visualization is shown at the same time as when the vehicle starts to accelerate.
    
    - 'Run_1.ino'
    
    The visualization is shown one second before the vehicle starts to accelerate.
    
    - 'Run_2.ino'
    
    The visualization is shown two seconds before the vehicle starts to accelerate.
    
    - 'Run_3.ino'
    
    The visualization is shown three seconds before the vehicle starts to accelerate.
    
    - 'Run_4.ino'

    The visualization is shown four seconds before the vehicle starts to accelerate.

  - 'Realtime_animations'
  
  Several programs were created for a user test that allows the prototype to respond to changes in acceleration. They read and store acceleration values and their timestamps. Acceleration values between -0.15 g and 0.15 g are mapped to a certain range of frames of the animation. The wider the range, the more sensitive the visualization is to changes in acceleration.
  
    - 'Baseline_run.ino'

    The code for the baseline run does not activate any of the LEDs. Instead, it only measures and stores the acceleration data of the acceleration sensor.

    - 'Run_1.ino'
    
    The acceleration is mapped to animation frames 1 to 53.
    
    - 'Run_2.ino'
    
    The acceleration is mapped to animation frames 6 to 47.
    
    - 'Run_3.ino'
    
    The acceleration is mapped to animation frames 11 to 42.
    
    - 'Run_4.ino'
    
    The acceleration is mapped to animation frames 16 to 37.
    
    - 'Run_5.ino'

    The acceleration is mapped to animation frames 21 to 32.

  - 'RTC_set_time.ino'

    This program can be run in the Arduino IDE on an Arduino microcontroller with an attached Real Time Clock (RTC). Whenever the program is run, the time of the RTC synchronizes with the time on the device from which it is run. Afterwards, the RTC can keep track of time even when disconnected from other devices, as it has its own battery.
    
  - 'User_test_button_press.pde'
  
    This program can be run in the Processing IDE. It provides a graphical interface to an Arduino microcontroller with a button. The interface shows when the button is being pressed and provides the possibility to store the timestamps of the button presses to a '.csv' file. During my Final Bachelor Project, this was used to measure the response time of participants to different visualizations. 
