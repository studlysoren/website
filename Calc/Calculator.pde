//Basic Calculator: By Soren Smith | Copyright 2014 

//instantiate each of the classification of buttons
CalcButton[] numButtons = new CalcButton[10];
CalcButton[] opButtons = new CalcButton[9];
CalcButton[] spButtons = new CalcButton[1];

//global variables
String displayValue = "";
String valueToCompute = ""; //string value left of operator
String valueToCompute2 = ""; //string value right of operator
float valueToComputeI = 0; //float value left of operator
float valueToComputeI2 = 0; //float value right of operator
float result = 0;
char opValue;
boolean firstNum;

void setup () {
  size(400, 400);
  background(#C15454);
  noFill();
  strokeWeight(3);
  stroke(200);

  //populate number buttons
  numButtons[0] = new CalcButton(280, 260).asNumber(0, 40, 40);
  numButtons[1] = new CalcButton(40, 320).asNumber(1, 40, 40);
  numButtons[2] = new CalcButton(100, 320).asNumber(2, 40, 40);
  numButtons[3] = new CalcButton(160, 320).asNumber(3, 40, 40);
  numButtons[4] = new CalcButton(220, 320).asNumber(4, 40, 40);
  numButtons[5] = new CalcButton(280, 320).asNumber(5, 40, 40);
  numButtons[6] = new CalcButton(40, 260).asNumber(6, 40, 40);
  numButtons[7] = new CalcButton(100, 260).asNumber(7, 40, 40);
  numButtons[8] = new CalcButton(160, 260).asNumber(8, 40, 40);
  numButtons[9] = new CalcButton(220, 260).asNumber(9, 40, 40);

  //populate operators
  opButtons[0] = new CalcButton(40, 220).asOperator("+", 40, 20);
  opButtons[1] = new CalcButton(100, 220).asOperator("-", 40, 20);
  opButtons[2] = new CalcButton(160, 220).asOperator("×", 40, 20);
  opButtons[3] = new CalcButton(220, 220).asOperator("÷", 40, 20);
  opButtons[4] = new CalcButton(340, 220).asOperator("=", 40, 20);
  opButtons[5] = new CalcButton(40, 180).asOperator("c", 40, 20);
  opButtons[6] = new CalcButton(280, 220).asOperator("p", 20, 20);
  opButtons[7] = new CalcButton(100, 180).asOperator("sqrt", 40, 20);
  opButtons[8] = new CalcButton(160, 180).asOperator("sq", 40, 20);
  //opButtons[9] = new CalcButton(100, 180).asOperator("sqrt",40,20);
  //opButtons[10] = new CalcButton(100, 180).asOperator("sqrt",40,20);


  //populate special
  spButtons[0] = new CalcButton(340, 340).asSpecial(".", 20, 20);

  //set the initial value of first num to true
  firstNum = true;
}

void draw() {
  //draw number buttons
  for (int i=0; i<numButtons.length; i++) {
    CalcButton inumButton = numButtons[i];
    inumButton.display();
  }
  for (int i=0; i<opButtons.length; i++) {
    CalcButton iopButton = opButtons[i];
    iopButton.display();
  }
  for (int i=0; i<spButtons.length; i++) {
    CalcButton ispButton = spButtons [i];
    ispButton.display();
  }
  updateDisplay();
}

void mousePressed() {
  for (int i=0; i<numButtons.length; i++) {
    CalcButton inumButton = numButtons[i];
    inumButton.clickButton();
    if (inumButton.overBox) {
      if (firstNum) {
        valueToCompute += int(inumButton.numButtonValue);
        displayValue = valueToCompute;
      } else {
        valueToCompute2 += int(inumButton.numButtonValue);
        displayValue = valueToCompute2;
      }
    }
  }
  for (int i=0; i<opButtons.length; i++) {
    CalcButton iOpButton = opButtons[i];
    iOpButton.clickButton();
    if (iOpButton.overBox) {
      if (iOpButton.opButtonValue == "+") {
        if (result != 0) {
          opValue = '+';
          valueToCompute2 = "";
          firstNum = false;
          displayValue = "+";
        } else {
          opValue = '+';
          firstNum = false;
          displayValue = "+";
        }
      } else if (iOpButton.opButtonValue == "-") {
        if (result !=0) {
          opValue = '-';
          valueToCompute2 = "";
          firstNum = false;
          displayValue = "-";
        } else {
          opValue = '-';
          firstNum = false;
          displayValue = "-";
        }
      } else if (iOpButton.opButtonValue == "×") {
        if (result !=0) {
          opValue = '×';
          valueToCompute2 = "";
          firstNum = false;
          displayValue = "×";
        } else {
          opValue = '×';
          firstNum = false;
          displayValue = "×";
        }
      } else if (iOpButton.opButtonValue == "÷") {
        if (result !=0) {
          opValue = '÷';
          valueToCompute2 = "";
          firstNum = false;
          displayValue = "÷";
        } else {
          opValue = '÷';
          firstNum = false;
          displayValue = "÷";
        }
      } else if (iOpButton.opButtonValue == "=") {
        //perform calculation
        firstNum = true;
        performCalculation();
      } else if (iOpButton.opButtonValue == "c") {
        displayValue = "0";
        opValue = 'c';
        valueToCompute = "";
        valueToCompute2 = "";
        valueToComputeI = 0;
        valueToComputeI2 = 0;
        result = 0;
        firstNum = true;
      } else if (iOpButton.opButtonValue == "p") {
        opValue = 'n';
        performCalculation();
      } else if (iOpButton.opButtonValue == "sqrt") {
        opValue = 's';
        performCalculation();
      } else if (iOpButton.opButtonValue == "sq") {
        opValue = 'w';
        performCalculation();
      }
    }
  }
  for (int i=0; i<spButtons.length; i++) {
    CalcButton iSpButton = spButtons[i];
    iSpButton.clickButton();
    if (iSpButton.overBox) {
      if (iSpButton.spButtonValue == ".") {
        //concantenate the values clicked on
        if (iSpButton.overBox && firstNum == true) {
          valueToCompute += iSpButton.spButtonValue;
          displayValue = valueToCompute;
        } else if (iSpButton.overBox && firstNum == false) {
          valueToCompute2 += iSpButton.spButtonValue;
          displayValue = valueToCompute2;
        }
      }
    }
  }
}


void performCalculation() {
  //set string values to floats
  valueToComputeI = float(valueToCompute);
  valueToComputeI2 = float(valueToCompute2);

  //perform calculation base on the appropriate operator
  if (opValue == '+') {
    result = valueToComputeI + valueToComputeI2;
    displayValue = str(result);
  } else if (opValue == '-') {
    result = valueToComputeI - valueToComputeI2;
    displayValue = str(result);
  } else if (opValue == '×') {
    result = valueToComputeI * valueToComputeI2;
    displayValue = str(result);
  } else if (opValue == '÷') {
    result = valueToComputeI / valueToComputeI2;
    displayValue = str(result);
    //let = work multiple times
    if (firstNum) {
      valueToCompute = displayValue;
    } else {
      valueToCompute = displayValue;
      valueToCompute2 = "";
    }
  } else if (opValue == 'n') {
    if (firstNum) {
      valueToComputeI = valueToComputeI*-1;
      displayValue = str(valueToComputeI);
    } else {
      valueToComputeI2 = valueToComputeI2*-1;
      displayValue = str(valueToComputeI2);
    }
  } else if (opValue == 's') {
    if (firstNum) {
      valueToComputeI = sqrt(valueToComputeI);
      displayValue = str(valueToComputeI);
    } else {
      valueToComputeI2 = sqrt(valueToComputeI2);
      displayValue = str(valueToComputeI2);
    }
  } else if (opValue == 'w') {
    if (firstNum) {
      valueToComputeI = sq(valueToComputeI);
      displayValue = str(valueToComputeI);
    } else {
      valueToComputeI2 = sq(valueToComputeI2);
      displayValue = str(valueToComputeI2);
    }
  }
}

//void handleKeyPressOp(String keyPress) {}

void updateDisplay() {
  fill(200, 200, 150);
  rect(40, 40, 180, 120, 5);
  fill(0);
  textSize(25);
  text(displayValue, 50, 70);

  fill(#C15454);
  noStroke();
  rect(260, 50, 100, 75);
  fill(0);
  textSize(15);
  text("Val 1: " + valueToCompute, 260, 60);
  text("Val 2: " + valueToCompute2, 260, 75);
  text("Result: " + result, 260, 90);
  text("Operator: " + opValue, 260, 105);
}

class CalcButton {
  //class variables
  boolean isNumber;
  boolean isSpecial;
  float numButtonValue;
  String opButtonValue;
  String spButtonValue;
  float xpos;
  float ypos;
  int boxSize = 40;
  int buttonW = 40;
  int buttonH = 40;
  boolean overBox = false;

  //constructor for buttons
  CalcButton(float tempXpos, float tempYpos) {
    xpos = tempXpos;
    ypos = tempYpos;
    //println(numButtonValue);
  }

  //constructor for number buttons
  CalcButton asNumber(float tempNumButtonValue, int tempW, int tempH) {
    isNumber = true;
    numButtonValue = tempNumButtonValue;
    buttonW = tempW;
    buttonH = tempH;
    return this;
  }
  //consturctor for operator buttons
  CalcButton asOperator(String tempOpButtonValue, int tempW, int tempH) {
    opButtonValue = tempOpButtonValue;
    buttonW = tempW;
    buttonH = tempH;
    return this;
  }
  //consturctor for special buttons
  CalcButton asSpecial(String tempSpButtonValue, int tempW, int tempH) {
    isSpecial = true;
    spButtonValue = tempSpButtonValue;
    buttonW = tempW;
    buttonH = tempH;
    return this;
  } 

  //draw the button on the canvas
  void display() {
    if (isNumber) {
      fill(#97D3D6);
      stroke(0);
      strokeWeight(2);
      rect(xpos, ypos, buttonW, buttonH, 2);
      fill(0);
      textSize(24);
      text(int(numButtonValue), xpos+13, ypos+30);
    } else if (isSpecial) {
      fill(#97D3D6);
      stroke(0);
      strokeWeight(2);
      rect(xpos, ypos, buttonW, buttonH, 1);
      fill(0);
      textSize(24);
      text(spButtonValue, xpos+6, ypos+12);
    } else if (opButtonValue == "p") {
      fill(#97D3D6);
      stroke(0);
      strokeWeight(2);
      rect(xpos, ypos, buttonW, buttonH, 8);
      fill(0);
      textSize(24);
      text("±", xpos+1, ypos+17);
    } else if (opButtonValue == "sqrt") {
      fill(#97D3D6);
      stroke(0);
      strokeWeight(2);
      rect(xpos, ypos, buttonW, buttonH, 8);
      fill(0);
      textSize(15);
      text(opButtonValue, xpos+5, ypos+15);
    } else {
      fill(#97D3D6);
      stroke(0);
      strokeWeight(2);
      rect(xpos, ypos, buttonW, buttonH, 8);
      fill(0);
      textSize(24);
      text(opButtonValue, xpos+12, ypos+18);
    }
  }

  //handle mouse actions
  void clickButton() {
    overBox = mouseX > xpos && mouseX < xpos+buttonW && mouseY > ypos && mouseY < ypos+buttonH;
  }
}


