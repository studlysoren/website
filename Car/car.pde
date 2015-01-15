class Car {
  //member variables
  int cLength, cHeight, cWeight, cSpeed;
  color cColor;
  float xpos;
  float ypos;
  float left;
  float up;
  

  //constuructor #1
  Car (int tempX, float tempY) {
    xpos = tempX;
    ypos = tempY;
    cSpeed = 5;
    cColor = color(255, 0, 0);
    xpos = width/2;
    ypos = height/2;
  }

  //constructor #2
  Car (float tempX, float tempY, int tempSpeed, color tempColor, float leftTemp, float upTemp) {
    xpos = tempX;
    ypos = tempY;
    cSpeed = tempSpeed;
    cColor = tempColor;
    left = leftTemp;
    up = upTemp;
  }

  //member methods
  void display() {

    //road
    fill(100);
    // rect(0, ypos-5, width, 25);

    //body
    stroke(0);
    fill(cColor);
    rect(xpos, ypos, 40, 15);
    fill(200);
    rect(xpos+15, ypos, 10, 15, 3);
    fill(25);

    //tires
    rect(xpos+5, ypos-3, 10, 3);
    rect(xpos+5, ypos+15, 10, 3);
    rect(xpos+25, ypos-3, 10, 3);
    rect(xpos+25, ypos+15, 10, 3);
  }

  void drive() { //default to the right
    if (left <=1) {
      xpos+=cSpeed;
      //detect edge
      if (xpos >width) {
        xpos = 0;
      }
    } else { //move some to the left
      xpos-=cSpeed; 
      //detect edge
      if (xpos < 0) {
        xpos = width;
      }
    }
    if (up <=1) {
      xpos+=cSpeed;
      if (ypos >height) {
        ypos = 0;
      }
    } else {
      ypos-=cSpeed;
      if (ypos < 0) {
        ypos = height;
      }
    }
  }
}

// create an array of car object
Car[] myCars = new Car[25];

void setup() {
  size(700,700);
  background(255);


  //instantiate the array of cars
  for (int i = 0; i< myCars.length; i++) {
    myCars[i] =  new Car(random(width), random(height), 50, color(random(255), random(255), random(255)), random(2), 50);
  }
}

void draw() {
  //set backgound
  background(255);
  // draw cars
  for (int i = 0; i < myCars.length; i++) {
    Car iCar = myCars[i];
    iCar.display();
    iCar.drive();
  }
}


