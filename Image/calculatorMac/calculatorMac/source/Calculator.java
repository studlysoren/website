import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Calculator extends PApplet {

CalcButton[] numButtons = new CalcButton[10];
CalcButton[] opButtons = new CalcButton[10];
CalcButton[] spButtons = new CalcButton[1];

//Global variables
String displayValue = "0";
String valueToCompute = "";
String valueToCompute2 = "";
float valueToComputeI = 0;
float valueToComputeI2 = 0;
float result = 0;
String opValue;
boolean firstNum;
//int keyResult;

public void setup() {
  size(250, 370);
  background(225);
  //frameRate(10);

  // Number buttons
  numButtons[0] = new CalcButton(70, 310, 50, 50, 150).asNumber(0);
  numButtons[1] = new CalcButton(10, 250, 50, 50, 150).asNumber(1);
  numButtons[2] = new CalcButton(70, 250, 50, 50, 150).asNumber(2);
  numButtons[3] = new CalcButton(130, 250, 50, 50, 150).asNumber(3);
  numButtons[4] = new CalcButton(10, 190, 50, 50, 150).asNumber(4);
  numButtons[5] = new CalcButton(70, 190, 50, 50, 150).asNumber(5);
  numButtons[6] = new CalcButton(130, 190, 50, 50, 150).asNumber(6);
  numButtons[7] = new CalcButton(10, 130, 50, 50, 150).asNumber(7);
  numButtons[8] = new CalcButton(70, 130, 50, 50, 150).asNumber(8);
  numButtons[9] = new CalcButton(130, 130, 50, 50, 150).asNumber(9);

  // Operators
  opButtons[0] = new CalcButton(190, 310, 50, 50, 150).asOperator("+");
  opButtons[1] = new CalcButton(190, 250, 50, 50, 150).asOperator("-");
  opButtons[2] = new CalcButton(190, 190, 50, 50, 150).asOperator("\u00d7");
  opButtons[3] = new CalcButton(190, 130, 50, 50, 150).asOperator("\u00f7");
  opButtons[4] = new CalcButton(10, 310, 50, 50, 150).asOperator("=");
  opButtons[5] = new CalcButton(10, 10, 50, 50, 150).asOperator("C");
  opButtons[6] = new CalcButton(10, 70, 50, 50, 150).asOperator("\u221a");
  opButtons[7] = new CalcButton(190, 70, 50, 50, 150).asOperator("\u00b1");
  opButtons[8] = new CalcButton(70, 70, 50, 50, 150).asOperator("sq");
  opButtons[9] = new CalcButton(130, 70, 50, 50, 150).asOperator("%");

  // Special buttons
  spButtons[0] = new CalcButton(130, 310, 50, 50, 150).asSpecial(".");

  firstNum = true;
}

public void draw() {
  //Draw number buttons
  for (int i=0; i < numButtons.length; i++) {
    CalcButton inumButton = numButtons[i];
    inumButton.display();
  }
  for (int i=0; i<opButtons.length; i++) {
    CalcButton iopButton = opButtons[i];
    iopButton.display();
  }
  for (int i = 0; i<spButtons.length; i++) {
    CalcButton ispButton = spButtons[i];
    ispButton.display();
  }
  updateDisplay();
}

public void mousePressed() {
  for (int i = 0; i<numButtons.length; i++) {
    CalcButton inumButton = numButtons[i];
    inumButton.clickButton();
    if (inumButton.overBox) {
      if (firstNum) {
        valueToCompute += PApplet.parseInt(inumButton.numButtonValue);
        displayValue = valueToCompute;
      } 
      else {
        valueToCompute2 += PApplet.parseInt(inumButton.numButtonValue);
        displayValue = valueToCompute2;
      }
    }
  }
  for (int i=0; i<opButtons.length; i++) {
    CalcButton iOpButton = opButtons[i];
    iOpButton.clickButton();
    if (iOpButton.overBox) {
      if (iOpButton.opButtonValue == "C") {
        handleKeyPressOp("C");
      } 
      else if (iOpButton.opButtonValue == "=") {
        //performCalculation();
        handleKeyPressOp("=");
      } 
      else if (iOpButton.opButtonValue == "+") {
        handleKeyPressOp("+");
      } 
      else if (iOpButton.opButtonValue == "-") {
        handleKeyPressOp("-");
      }
      else if (iOpButton.opButtonValue == "\u00d7") {
        handleKeyPressOp("\u00d7");
      }
      else if (iOpButton.opButtonValue == "\u00f7") {
        handleKeyPressOp("\u00f7");
      }
      else if (iOpButton.opButtonValue == "\u221a") {
        handleKeyPressOp("\u221a");
      }
      else if (iOpButton.opButtonValue == "\u00b1") {
        handleKeyPressOp("\u00b1");
      }
      else if (iOpButton.opButtonValue == "sq") {
        handleKeyPressOp("sq");
      }
      else if (iOpButton.opButtonValue == "%") {
        handleKeyPressOp("%");
      }
    }
  }


  for (int i=0; i<spButtons.length; i++) {
    CalcButton iSpButton = spButtons[i];
    iSpButton.clickButton();
    //concantenate
    if (iSpButton.overBox && mousePressed == true && firstNum == true) {
      valueToCompute = valueToCompute + spButtons[i].spButtonValue;
      displayValue = valueToCompute;
    } 
    else if (iSpButton.overBox && mousePressed == true && firstNum == false) {
      valueToCompute2 = valueToCompute2 + spButtons[i].spButtonValue;
      displayValue = valueToCompute2;
    }
  }
}

public void performCalculation() {
  valueToComputeI = PApplet.parseFloat(valueToCompute);
  valueToComputeI2 = PApplet.parseFloat(valueToCompute2);

  //Perform calculation based on the appropriate operator
  if (opValue == "+") {
    result = valueToComputeI + valueToComputeI2;
    displayValue = str(result);
  } 
  else if (opValue == "-") {
    result = valueToComputeI - valueToComputeI2;
    displayValue = str(result);
  } 
  else if (opValue == "\u00d7") {
    result = valueToComputeI * valueToComputeI2;
    displayValue = str(result);
  } 
  else if (opValue == "\u00f7") {
    result = valueToComputeI / valueToComputeI2;
    displayValue = str(result);
  }
  else if (opValue == "\u221a") {
    if (firstNum) {
      valueToComputeI = sqrt(valueToComputeI);
      displayValue = str(valueToComputeI);
    } 
    else {
      valueToComputeI2 = sqrt(valueToComputeI2);
      displayValue = str(valueToComputeI2);
    }
  }
  else if (opValue == "\u00b1") {
    result = valueToComputeI *-1;
    displayValue = str(result);
  }
  else if (opValue == "sq") {
    if (firstNum) {
      valueToComputeI = sq(valueToComputeI);
      displayValue = str(valueToComputeI);
    }
    else {
      valueToComputeI2 = sq(valueToComputeI2);
      displayValue = str(valueToComputeI2);
    }
  }
  else if (opValue =="%") {
    if (firstNum) {
      valueToComputeI = valueToComputeI*0.010000f;
      displayValue = str(valueToComputeI);
    } 
    else {
      valueToComputeI2 = valueToComputeI2*0.010000f;
      displayValue = str(valueToComputeI2);
    }
  }

  if (firstNum) {
    valueToCompute = displayValue;
  } 
  else {
    valueToCompute = displayValue;
    valueToCompute2 = "";
  }
}

public void updateDisplay() {
  fill(255);
  rect(70, 10, 170, 50);
  fill(0);
  text(displayValue, 80, 40);
}
public void handleKeyPressOp(String keyPress) {
  if (keyPress =="C") {
    displayValue = "0";
    opValue = "C";
    valueToCompute = "";
    valueToCompute2 = "";
    valueToComputeI = 0;
    valueToComputeI2 = 0;
    result = 0;
    firstNum = true;
  } 
  else if (keyPress == "=") {
    firstNum = true;
    performCalculation();
  } 
  else if (keyPress == "+") {
    if (result != 0) {
      opValue = "+";
      valueToCompute2 = "";
      firstNum = false;
      displayValue = "+";
    } 
    else {
      opValue = "+";
      firstNum = false;
      displayValue = "+";
    }
  }
  else if (keyPress == "-") {
    if (result != 0) {
      opValue = "-";
      valueToCompute2 = "";
      firstNum = false;
      displayValue = "-";
    } 
    else {
      opValue = "-";
      firstNum = false;
      displayValue = "-";
    }
  }
  else if (keyPress == "\u00d7") {
    if (result != 0) {
      opValue = "\u00d7";
      valueToCompute2 = "";
      firstNum = false;
      displayValue = "\u00d7";
    } 
    else {
      opValue = "\u00d7";
      firstNum = false;
      displayValue = "\u00d7";
    }
  }
  else if (keyPress == "\u00f7") {
    if (result != 0) {
      opValue = "\u00f7";
      valueToCompute2 = "";
      firstNum = false;
      displayValue = "\u00f7";
    } 
    else {
      opValue = "\u00f7";
      firstNum = false;
      displayValue = "\u00f7";
    }
  }
  else if (keyPress == "\u221a") {
    if (result != 0) {
      opValue = "\u221a";
      valueToCompute2 = "";
      firstNum = false;
      displayValue = "\u221a";
    } 
    else {
      opValue = "\u221a";
      firstNum = false;
      displayValue = "\u221a";
    }
  }
  else if (keyPress == "\u00b1") {
    if (result != 0) {
      opValue = "\u00b1";
      valueToCompute2 = "";
      firstNum = false;
      displayValue = "\u00b1";
    } 
    else {
      opValue = "\u00b1";
      firstNum = false;
      displayValue = "\u00b1";
    }
  }
  else if (keyPress == "sq") {
    if (result != 0) {
      opValue = "sq";
      valueToCompute2 = "";
      firstNum = false;
      displayValue = "sq";
    } 
    else {
      opValue = "sq";
      firstNum = false;
      displayValue = "sq";
    }
  }
  else if (keyPress == "%") {
    if (result != 0) {
      opValue = "%";
      valueToCompute2 = "";
      firstNum = false;
      displayValue = "%";
    } 
    else {
      opValue = "%";
      firstNum = false;
      displayValue = "%";
    }
  }
}

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
  int buttonC;

  // Constructor
  CalcButton(float tempXpos, float tempYpos, int tempButtonW, int tempButtonH, int tempButtonC) {
    xpos = tempXpos;
    ypos = tempYpos;
    buttonW = tempButtonW;
    buttonH = tempButtonH;
    buttonC = tempButtonC;
    //println(numButtonValue);
  }

  public CalcButton asNumber(float tempNumButtonValue) {
    isNumber = true;
    numButtonValue = tempNumButtonValue;
    return this;
  }
  public CalcButton asOperator(String tempOpButtonValue) {
    opButtonValue = tempOpButtonValue;
    return this;
  }
  public CalcButton asSpecial(String buttonValue) {
    isSpecial = true;
    spButtonValue = buttonValue;
    return this;
  }


  public void display() {
    strokeWeight(2);
    stroke(0);
    textSize(24);
    if (isNumber) {
      fill(buttonC);
      rect(xpos, ypos, buttonW, buttonH, 10);
      fill(255, 255, 0);
      text(PApplet.parseInt(numButtonValue), xpos+17, ypos+35);
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

  public void clickButton() {
    overBox = mouseX > xpos && mouseX < xpos+buttonW && mouseY > ypos && mouseY < ypos+buttonH;
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Calculator" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
