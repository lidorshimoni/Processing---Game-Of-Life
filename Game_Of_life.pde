int SIZE = 10;
int RES_X = 2560/SIZE;
int RES_Y = 1080/SIZE;

float scale = 1;
float xPan = 0;
float yPan = 0;


int PLAYERS = 3;

int currentColor=1;
boolean isPlaying = false;
boolean isSpeedHack = false;
int radius = 5;


Cell[][] cells = new Cell[RES_X][RES_Y];
 
 void setup()
 {
   fullScreen();
   setCells(cells);
   loop();
 }
 
 
 void draw()
 {
   translate(xPan, yPan);
   scale(scale);
   translate(-xPan, -yPan);

   drawCells(cells);
   if (isPlaying)
   {
     updateCells(cells);
     if (isSpeedHack)
     {
       for(int i = 0;i<9;i++)
         updateCells(cells);
     }
   }
 }

 void keyPressed()
{
  if (key=='1')
  {
    currentColor=1;
  }
  else if(key == '2')
  {
    currentColor=2;
  }
  else if(key == '3')
  {
    currentColor=3;
  }
  else if(key == '4')
  {
    currentColor=4;
  }
  else if(key == '=')
  {
    isSpeedHack=!isSpeedHack;
  }
  else if(keyCode == DELETE)
  {
    clearScreen(cells);
  }
       
 }
 
 void mouseDragged()
 {
   if(mouseButton == LEFT)
     userClick(cells, true, currentColor, radius);
 }
 
 void mouseClicked()
 {
   if(mouseButton == LEFT )
       userClick(cells, true, currentColor, radius);
   else if(mouseButton == RIGHT)
         isPlaying=!isPlaying; 
         
 }
 
 
 void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e==-1)
  {
    scale+=0.05;
    xPan=mouseX;
    yPan=mouseY;

  }
  else if (e==1 && scale>1)
  {
    scale-=0.05;
    if(scale<1)
      scale=1;
  }
  
}
