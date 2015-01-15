void setup(){
  size(900,900);
}
void draw(){
  background(#BFE9FF);
  zoog(mouseX,mouseY, #FFFFFF);
  zoog(mouseX+250,mouseY, #122BB4);
  zoog(mouseX-250,mouseY, #1FEDEB);
  zoog(mouseX,mouseY+250, #ED1FE3);
  zoog(mouseX,mouseY-250, #FF0505);
}
  
void zoog(int xpos, int ypos, color c1) {
  rectMode(CENTER);
  
  //Belly
  stroke(0);
  fill(c1);
  rect(xpos,ypos,20,100);
  
  //Hat
  stroke(222,192,128);
  fill(222,192,128);
  ellipse(xpos,ypos-50, 120, 50);
  
  //Head
  stroke(0);
  fill(0);
  ellipse(xpos,ypos-30,60,60);
  
  //Eyes
  fill(random(255),0,0);
  ellipse(xpos-15,ypos-30,16,32);
  ellipse(xpos+15,ypos-30,16,32);
  
  //Legs
  stroke(0);
  line(xpos-10,ypos+50,xpos-20,ypos+60);
  line(xpos+10,ypos+50,xpos+20,ypos+60);
  
  //arms
  stroke(0);
  line(xpos-10,ypos+15,xpos-23,ypos+10);
  line(xpos+10,ypos+15,xpos+23,ypos+10);
  
  //Buttons
  fill(0);
  ellipse(xpos,ypos+10,5,5);
  ellipse(xpos,ypos+20,5,5);
  ellipse(xpos,ypos+30,5,5);
}

