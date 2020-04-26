int SIZE = 5;
int RES_X = 2560/SIZE;
int RES_Y = 1080/SIZE;
int PLAYERS = 3;
int currentColor=0;
boolean isPlaying = false;
boolean isSpeedHack = false;

asd;
Cell[][] cells = new Cell[RES_X][RES_Y];
 
 void setup()
 {
   fullScreen();
   setCells(cells);
   loop();
 }
 
 
 void draw()
 {
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
   if(mouseButton == RIGHT)
         isPlaying=!isPlaying; 
 }
