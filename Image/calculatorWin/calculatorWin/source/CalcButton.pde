class CalcButton {

  boolean isNumber;
  boolean isSpecial;
  float numButtonValue;
  String opButtonValue;
  String spButtonValue;
  float xpos;
  float ypos;
  int buttonW;
  int buttonH;
  boolean overBox = false;
  color buttonC;

  // Constructor
  CalcButton(float tempXpos, float tempYpos, int tempButtonW, int tempButtonH, color tempButtonC) {
    xpos = tempXpos;
    ypos = tempYpos;
    buttonW = tempButtonW;
    buttonH = tempButtonH;
    buttonC = tempButtonC;
    //println(numButtonValue);
  }

  CalcButton asNumber(float tempNumButtonValue) {
    isNumber = true;
    numButtonValue = tempNumButtonValue;
    return this;
  }
  CalcButton asOperator(String tempOpButtonValue) {
    opButtonValue = tempOpButtonValue;
    return this;
  }
  CalcButton asSpecial(String buttonValue) {
    isSpecial = true;
    spButtonValue = buttonValue;
    return this;
  }


  void display() {
    strokeWeight(2);
    stroke(0);
    textSize(24);
    if (isNumber) {
      fill(buttonC);
      rect(xpos, ypos, buttonW, buttonH, 10);
      fill(255, 255, 0);
      text(int(numButtonValue), xpos+17, ypos+35);
    } 
    else if (isSpecial) {
      fill(buttonC);
      rect(xpos, ypos, buttonW, buttonH, 10);
      fill(0,0,255);
      text(spButtonValue, xpos+17, ypos+35);
    } 
    else {
      fill(buttonC);
      rect(xpos, ypos, buttonW, buttonH, 10);
      fill(0,0,255);
      text(opButtonValue, xpos+17, ypos+35);
    }
  }

  void clickButton() {
    overBox = mouseX > xpos && mouseX < xpos+buttonW && mouseY > ypos && mouseY < ypos+buttonH;
  }
}

