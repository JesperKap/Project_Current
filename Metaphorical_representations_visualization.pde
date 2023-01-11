int pixel_separation = 20;
int pixel_x_dimension = 52;
int pixel_y_dimension = 4;
int acceleration_x = displayWidth/2;
float smoothness_factor = 0.05;
float smooth_point_x = displayWidth/2;
float timer = 0;
float damping_x = displayWidth/2;
float damping_smooth_x = displayWidth/2;
float smooth_x = displayWidth/2;

void setup() {
  size(displayWidth, displayHeight);
}

void draw() {
  background(50);
  strokeWeight(0);

  int acceleration = 0;  
  int acceleration_y = displayHeight/5*4;
  int acceleration_width = displayWidth/2;

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

  //Draw acceleration tool
  //Lines
  stroke(255);
  strokeWeight(10);
  line(width/4, acceleration_y, width/4*3, acceleration_y);
  line(width/4-100, acceleration_y, width/4-50, acceleration_y);
  line(width/4*3+50, acceleration_y, width/4*3+100, acceleration_y);
  line(width/4*3+75, acceleration_y-25, width/4*3+75, acceleration_y+25);
  line(width/2, acceleration_y-50, width/2, acceleration_y+50);

  //Indicator
  ellipse(acceleration_x, acceleration_y, 50, 50);
  if (width/4 < mouseX && mouseX < width/4*3) {
    acceleration_x = mouseX;
  }
  println(width/4*3);
  //Map indicator position to a range of -1 to 1
  float acceleration_factor = map(acceleration_x, width/4, width/4*3, -1, 1);

  //Control pixel pattern of representation 1
  float cursor_map = map(acceleration_x, width/4, width/4*3, width/2-pixel_x_dimension/2*pixel_separation+51*pixel_separation, width/2-pixel_x_dimension/2*pixel_separation);
  float x_difference = cursor_map - smooth_point_x;
  smooth_point_x = smooth_point_x + x_difference * smoothness_factor; 
  float damping_x_difference = cursor_map - damping_x;
  if (timer%50 == 0) {
    damping_x = damping_x + damping_x_difference * 1.75;
  }
  float smooth_damping_x_difference = damping_smooth_x - damping_x;
  damping_smooth_x = damping_smooth_x + smooth_damping_x_difference ;
  //ellipse(damping_x, height/2, 50, 50);
  //ellipse(smooth_point_x, height/2, 50, 50);  //Draw smooth point
  //ellipse(cursor_map, height/2, 50, 50);  //Draw brightest point
  float smooth_x_difference = damping_x - smooth_x;
  smooth_x = smooth_x + smooth_x_difference*0.05;
  //ellipse(smooth_x, height/2, 50, 50);

  //Control pixel pattern of representation 1
  float attractor_1_x = 700*cos(map(acceleration_x, width/4, width/4*3, 0, PI))+width/2;
  float attractor_1_y = 700*sin(map(acceleration_x, width/4, width/4*3, 0, PI))+height/5-10;
  float attractor_2_x = 700*cos(map(acceleration_x, width/4, width/4*3, PI, 2*PI))+width/2;
  float attractor_2_y = 700*sin(map(acceleration_x, width/4, width/4*3, PI, 2*PI))+height/5-10;
  //ellipse(attractor_1_x, attractor_1_y, 50, 50);  //Draw attractor 1
  //ellipse(attractor_2_x, attractor_2_y, 50, 50);  //Draw attractor 2
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
  //float attractor_a_x = 700*cos(map(acceleration_x, width/4, width/4*3, 0, PI))+width/2;
  //float attractor_a_y = 700*sin(map(acceleration_x, width/4, width/4*3, 0, PI))+height/5*2-10;
  //float attractor_b_x = 700*cos(map(acceleration_x, width/4, width/4*3, PI, 2*PI))+width/2;
  //float attractor_b_y = 700*sin(map(acceleration_x, width/4, width/4*3, PI, 2*PI))+height/5*2-10;
  ////ellipse(attractor_a_x, attractor_a_y, 50, 50);  //Draw attractor a
  ////ellipse(attractor_b_x, attractor_b_y, 50, 50);  //Draw attractor b
  //for (int i = 0; i < pixel_y_dimension; i++) {
  //  for (int j = 0; j < pixel_x_dimension; j++) {
  //    if (dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)) {
  //      fill(255);
  //    } else if((j+1 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+1)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+1)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-1)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-1)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y))) {
  //      fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y), 0, 700, -1000, 255));      
  //    } else if((j+2 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+2)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+2)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-2)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-2)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y))) {
  //      fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y), 0, 700, -1000, 255));
  //    } else if((j+3 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+3)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+3)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-3)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-3)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y))) {
  //      fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y), 0, 700, -1000, 255));
  //    } else if((j+4 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+4)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+4)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-4)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-4)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y))) {
  //      fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y), 0, 700, -1000, 255)); 
  //    } else if((j+5 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+5)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+5)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-5)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-5)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y))) {
  //      fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y), 0, 700, -1000, 255));
  //    } else if((j+6 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+6)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+6)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-6)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-6)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y))) {
  //      fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y), 0, 700, -1000, 255));
  //    } else if((j+7 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+7)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+7)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-7)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-7)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y))) {
  //      fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y), 0, 700, -1000, 255));  
  //    } else if((j+8 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+8)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+8)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-8)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-8)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y))) {
  //      fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y), 0, 700, -1000, 255));
  //    } else if((j+9 < pixel_x_dimension) && (dist(width/2-pixel_x_dimension/2*pixel_separation+(j+9)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j+9)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y)||dist(width/2-pixel_x_dimension/2*pixel_separation+(j-9)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_a_x, attractor_a_y) < dist(width/2-pixel_x_dimension/2*pixel_separation+(j-9)*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y))) {
  //      fill(map(dist(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, attractor_b_x, attractor_b_y), 0, 700, -1000, 255));  
  //    } else {
  //      fill(0);
  //    }
  //    noStroke();
  //    ellipse(width/2-pixel_x_dimension/2*pixel_separation+j*pixel_separation, height/5*2-pixel_y_dimension/2*pixel_separation+i*pixel_separation, 20, 20);
  //  }
  //}
  
  //Alternative pixel pattern of representation 2
  float attractor_a_x = 700*cos(map(acceleration_x, width/4, width/4*3, PI*1.5, PI*0.5))+width/2;
  float attractor_a_y = 700*sin(map(acceleration_x, width/4, width/4*3, PI*1.5, PI*0.5))+height/5*2-10;
  float attractor_b_x = 700*cos(map(acceleration_x, width/4, width/4*3, PI*2.5, 1.5*PI))+width/2;
  float attractor_b_y = 700*sin(map(acceleration_x, width/4, width/4*3, PI*2.5, 1.5*PI))+height/5*2-10;
  //ellipse(attractor_a_x, attractor_a_y, 50, 50);  //Draw attractor a
  //ellipse(attractor_b_x, attractor_b_y, 50, 50);  //Draw attractor b
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
  float brightest_light = map(acceleration_x, width/4, width/4*3, width/2-pixel_x_dimension/2*pixel_separation+51*pixel_separation, width/2-pixel_x_dimension/2*pixel_separation);
  //float x_difference = brightest_light - smooth_point_x;
  //smooth_point_x = smooth_point_x + x_difference * smoothness_factor; 
  //ellipse(smooth_point_x, height/2, 50, 50);  //Draw smooth point
  //ellipse(brightest_light, height/2, 50, 50);  //Draw brightest point
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
  
  //Control the timer
  timer+=1;
}
