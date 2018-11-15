int SIZE = 10;
int RES_X = 1920/SIZE;
int RES_Y = 1080/SIZE;
int PLAYERS = 3;


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
   update(cells);
   keyPressed();
 }

 void keyPressed()
 {println("presed" + key);
  if(key == '1')
    userClick(cells, true, 1);
  else if(key == '2')
    userClick(cells, true, 2);
  else if(key == '3')
    userClick(cells, true, 3);
 }
 void mouseDragged()
 {
   if(mouseButton == LEFT)
     userClick(cells, true, 0);
  else
      userClick(cells, true, 1);
 }
