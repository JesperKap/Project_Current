//Distance between the pixels of the patterns
int pixel_separation = 20;

//Amount of pixels of the patterns in x and y dimension
int pixel_x_dimension = 52;
int pixel_y_dimension = 4;

//Amount of acceleration, set to middle of screen
int acceleration_x = displayWidth/2;

void setup() {
  //Full size of display
  size(displayWidth, displayHeight);
}

void draw() {
  //Set background color and stroke weight
  background(50);
  strokeWeight(0);

  //Set y coordinate of acceleration tool 
  int acceleration_y = displayHeight/5*4;

  //Draw pixel positions of representation 1
  for (int i = 0; i < pixel_y_dimension; i++) {
    for (int j = 0; j < pixel_x_dimension; j++) {
      fill(0);
      ellipse(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, 20, 20);
    }
  }

  //Draw pixel positions of representation 2
  for (int i = 0; i < pixel_y_dimension; i++) {
    for (int j = 0; j < pixel_x_dimension; j++) {
      fill(0);
      ellipse(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, 20, 20);
    }
  }

  //Draw pixel positions of representation 3
  for (int i = 0; i < pixel_y_dimension; i++) {
    for (int j = 0; j < pixel_x_dimension; j++) {
      fill(0);
      ellipse(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*3-pixel_y_dimension/2*pixel_separation+i*pixel_separation, 20, 20);
    }
  }

  //Draw lines of acceleration tool
  stroke(255);
  strokeWeight(10);
  line(width/4, acceleration_y, width/4*3, acceleration_y);
  line(width/4-100, acceleration_y, width/4-50, acceleration_y);
  line(width/4*3+50, acceleration_y, width/4*3+100, acceleration_y);
  line(width/4*3+75, acceleration_y-25, width/4*3+75, acceleration_y+25);
  line(width/2, acceleration_y-50, width/2, acceleration_y+50);

  //Draw indicator of acceleration tool
  ellipse(acceleration_x, acceleration_y, 50, 50);
  
  //Determine position of indicator
  if (width/4 < mouseX && mouseX < width/4*3) {
    acceleration_x = mouseX;
  }

  //Control pixel pattern of representation 1
  
  //Control position of attractor points
  float attractor_1_x = 700*cos(map(acceleration_x, width/4, width/4*3, 0, PI))+width/2;
  float attractor_1_y = 700*sin(map(acceleration_x, width/4, width/4*3, 0, PI))+height/5-10;
  float attractor_2_x = 700*cos(map(acceleration_x, width/4, width/4*3, PI, 2*PI))+width/2;
  float attractor_2_y = 700*sin(map(acceleration_x, width/4, width/4*3, PI, 2*PI))+height/5-10;

  //Color all pixels either black or white based on which attractor point is closest to the pixel
  for (int i = 0; i < pixel_y_dimension; i++) {
    for (int j = 0; j < pixel_x_dimension; j++) {
      if (dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y)) {
        fill(255);
      } else if((j+1 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+1)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+1)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-1)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-1)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y))) {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y), 0, 700, -1000, 255));      
      } else if((j+2 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+2)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+2)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-2)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-2)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y))) {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y), 0, 700, -1000, 255));
      } else if((j+3 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+3)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+3)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-3)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-3)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y))) {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y), 0, 700, -1000, 255));
      } else if((j+4 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+4)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+4)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-4)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-4)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y))) {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y), 0, 700, -1000, 255)); 
      } else if((j+5 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+5)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+5)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-5)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-5)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y))) {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y), 0, 700, -1000, 255));
      } else if((j+6 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+6)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+6)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-6)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-6)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y))) {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y), 0, 700, -1000, 255));
      } else if((j+7 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+7)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+7)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-7)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-7)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y))) {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y), 0, 700, -1000, 255));  
      } else if((j+8 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+8)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+8)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-8)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-8)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y))) {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y), 0, 700, -1000, 255));
      } else if((j+9 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+9)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+9)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-9)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_1_x, attractor_1_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-9)*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y))) {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_2_x, attractor_2_y), 0, 700, -1000, 255));  
      } else {
        fill(0);
      }
      noStroke();
      ellipse(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5-pixel_y_dimension/2*pixel_separation+i*pixel_separation, 20, 20);
    }
  }
  
  //Control pixel pattern of representation 2
  
  //Control position of attractor points
  float attractor_a_x = 700*cos(map(acceleration_x, width/4, width/4*3, PI*1.5, PI*0.5))+width/2;
  float attractor_a_y = 700*sin(map(acceleration_x, width/4, width/4*3, PI*1.5, PI*0.5))+height/5*2-10;
  float attractor_b_x = 700*cos(map(acceleration_x, width/4, width/4*3, PI*2.5, 1.5*PI))+width/2;
  float attractor_b_y = 700*sin(map(acceleration_x, width/4, width/4*3, PI*2.5, 1.5*PI))+height/5*2-10;

  //Color all pixels either black or white based on the distance between the pixel and the attractor points
  for (int i = 0; i < pixel_y_dimension; i++) {
    for (int j = 0; j < pixel_x_dimension; j++) {
      if (dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)) {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y), 0, 700, -1000, 255));
        //fill(255);
      } else {
        fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y), 0, 700, -1000, 255));
        //fill(0);
      }
      noStroke();
      ellipse(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, 20, 20);
    }
  }

  //Control pixel pattern of representation 3
  
  //Control the position of the brightest point in the pattern
  float brightest_light = map(acceleration_x, width/4, width/4*3, width/2-pixel_x_dimension/2*pixel_separation+51*pixel_separation, width/2-pixel_x_dimension/2*pixel_separation);

  //Assign decreasing amounts of brightness to neighboring pixels
  strokeWeight(0);
  for (int j = 0; j < pixel_x_dimension; j++) {
    if (dist(brightest_light, height/2, width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*3-pixel_y_dimension/2*pixel_separation+0*pixel_separation) < 600) {
      fill(127.5*cos(0.005*dist(brightest_light, height/2, width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*3-pixel_y_dimension/2*pixel_separation+0*pixel_separation))+127.5);
      ellipse(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*3-pixel_y_dimension/2*pixel_separation+0*pixel_separation, 20, 20);
      ellipse(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*3-pixel_y_dimension/2*pixel_separation+1*pixel_separation, 20, 20);
      ellipse(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*3-pixel_y_dimension/2*pixel_separation+2*pixel_separation, 20, 20);
      ellipse(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*3-pixel_y_dimension/2*pixel_separation+3*pixel_separation, 20, 20);
    }
  }
}
