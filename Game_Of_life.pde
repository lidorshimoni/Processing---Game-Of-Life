int RES_X = 192;
int RES_Y = 108;

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
   delay(30);
   drawCells(cells);
   //int x = (int )random(192);
   //int y = (int )random(108);
   //cells[x][y].setLive(true);
   update(cells);

 }
 
 void mouseDragged()
 {
   if(mouseButton == LEFT)
     userClick(cells, true);
  else
      userClick(cells, false);
 }
