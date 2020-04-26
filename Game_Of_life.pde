int SIZE = 5;
int RES_X = 2560/SIZE;
int RES_Y = 1080/SIZE;

float scale = 1;



int PLAYERS = 3;

int currentColor=0;
boolean isPlaying = false;
boolean isSpeedHack = false;


Cell[][] cells = new Cell[RES_X][RES_Y];
 
 void setup()
 {
   fullScreen();
   setCells(cells);
   loop();
 }
 
 
 void draw()
 {
     translate(-mouseX, -mouseY);

   //translate(width/2, height/2);
   scale(scale);
   
   
   
   //frameRate(10);
   //delay(30);
   drawCells(cells);
   //int x = (int )random(192);
   //int y = (int )random(108);
   //cells[x][y].setLive(true);
   if (isPlaying)
     updateCells(cells);
     if (isSpeedHack)
     {
       for(int i = 0;i<9;i++)
         updateCells(cells);
     }
    //println(isPlaying);
   //keyPressed();
 }

 void keyPressed()
{
  if (key=='0')
  {
    currentColor=0;
  }
  else if(key == '1')
  {
    //userClick(cells, true, 1, 1);
    currentColor=1;
  }
  else if(key == '2')
  {
    //userClick(cells, true, 2, 1);
    currentColor=2;
  }
  else if(key == '3')
  {
    //userClick(cells, true, 3, 1);
    currentColor=3;
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
     userClick(cells, true, currentColor, 1);
  //else
      //userClick(cells, true, currentColor);
 }
 
 void mouseClicked()
 {
   if(mouseButton == LEFT)
       userClick(cells, true, currentColor, 1);
   else if(mouseButton == RIGHT)
         isPlaying=!isPlaying; 
         
 }
 
 
 void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e==-1)
  {
    scale+=0.05;
    //translate(-mouseX, -mouseY);
  }
  else if (e==1 && scale>1)
  {
    scale-=0.05;

  }
  
}
