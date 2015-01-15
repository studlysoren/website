//lines mylines1;
Lines[] myLines = new Lines [20];

void setup() {
  background(#CE6C02);
  size(1000, 500);
  frameRate(30);
  //myLines1 = new Lines(random(width),random(height), random(1,5),random(1,20));
  for (int i=0; i<myLines.length; i++) {
    myLines[i] = new Lines(random(width), random(height), random(1, 5), random(1, 20));
  }
}

void draw () {
  if (frameCount >200) {
    frameCount = 0;
    background(#CE6C02);
  } else {
    //myLines1.display();
    for (int i=0; i<myLines.length; i++) {
      Lines iLines = myLines[i];
      iLines.display();
    }
  }
}

class Lines {
  //class variables
  float xpos;
  float ypos;
  float strokeW;
  float pointCount;

  //constructor
  Lines(float tempX, float tempY, float tempStroke, float tempCount) {
    xpos = tempX;
    ypos = tempY;
    strokeW = tempStroke;
    pointCount = tempCount;
  }
  //display
  void display () {
    strokeW = random(10,10);
    pointCount = random(10,20);
    stroke(0);
    strokeWeight(strokeW);

    if (xpos > width || xpos < 0 || ypos > height || ypos < 0) {
      xpos = random(width);
      ypos = random(height);
    } else {
      if (random(100)>40) {
        stroke(0);
        strokeWeight(strokeW);
        moveLeft(xpos, ypos, pointCount);
      } else if (random(100)>20) {
        stroke(0);
        strokeWeight(strokeW);
        moveUp(xpos, ypos, pointCount);
      } else if (random(100)>10) {
        stroke(0);
        strokeWeight(strokeW);
        moveDown(xpos, ypos, pointCount);
      } else {
        stroke(0);
        strokeWeight(strokeW);
        moveRight(xpos, ypos, pointCount);
      }
    }
  }


  void moveRight(float startX, float startY, float moveCount) {
    for (float i=0; i<moveCount; i++) {
      point(startX + (1*i), startY);
      xpos = startX + 1;
    }
  }
  void moveLeft(float startX, float startY, float moveCount) {
    for (float i=0; i<moveCount; i++) {
      point(startX-(1*i), startY);
      xpos = startX - 1;
    }
  }
  void moveUp(float startX, float startY, float moveCount) {
    for (float i=0; i<moveCount; i++) {
      point(startX, startY-(1*i));
      ypos = startY - 1;
    }
  }
  void moveDown(float startX, float startY, float moveCount) {
    for (float i=0; i<moveCount; i++) {
      point(startX, startY+(1*i));
      ypos = startY+1;
    }
  }
}


