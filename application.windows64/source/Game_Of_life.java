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

public class Game_Of_life extends PApplet {

int SIZE = 5;
int RES_X = 2560/SIZE;
int RES_Y = 1080/SIZE;

float scale = 1;
float xPan = 0;
float yPan = 0;


int PLAYERS = 3;

int currentColor=0;
boolean isPlaying = false;
boolean isSpeedHack = false;
int radius = 10;


Cell[][] cells = new Cell[RES_X][RES_Y];
 
 public void setup()
 {
   
   setCells(cells);
   loop();
 }
 
 
 public void draw()
 {
   
   //translate(width/2, height/2);
   translate(xPan, yPan);
   scale(scale);
   translate(-xPan, -yPan);
   
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

 public void keyPressed()
{
  if (key=='0')
  {
    currentColor=0;
  }
  else if(key == '1')
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
  else if(key == '=')
  {
    isSpeedHack=!isSpeedHack;
  }
  else if(keyCode == DELETE)
  {
    clearScreen(cells);
  }
       
 }
 
 public void mouseDragged()
 {
   if(mouseButton == LEFT)
     userClick(cells, true, currentColor, radius);
 }
 
 public void mouseClicked()
 {
   if(mouseButton == LEFT)
       userClick(cells, true, currentColor, radius);
   else if(mouseButton == RIGHT)
         isPlaying=!isPlaying; 
         
 }
 
 
 public void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e==-1)
  {
    scale+=0.05f;
    xPan=mouseX;
    yPan=mouseY;

  }
  else if (e==1 && scale>1)
  {
    scale-=0.05f;
    if(scale<1)
      scale=1;
  }
  
}
//abstract class BaseShape
//{
//  public float rotation = 0;

//  abstract protected int getX();
//  abstract protected int getY();

//  private float speedX = 0;
//  private float speedY = 0;

//  public int speed = 0;
//  public int direction;

//  protected int advanceSpeedX()
//  {
//    int advanceX = 0;
//    if (speed == 0)
//    {
//      speedX = 0;
//    } 
//    else 
//    {
//      speedX += (speed) * cos(radians(direction));

//      advanceX = round(speedX);

//      speedX = speedX - advanceX;
//    }
//    return advanceX;
//  }

//  protected int advanceSpeedY()
//  {
//    int advanceY = 0;
//    if (speed == 0)
//    {
//      speedY = 0;
//    }
//    else 
//    {
//      speedY += (speed) * sin(radians(direction));

//      advanceY = round(speedY);

//      speedY = speedY - advanceY;
//    }
//    return advanceY;
//  }


//  protected void rotateIt()
//  {
//    pushMatrix();
//    translate(getX(), getY());
//    rotate(radians(rotation));
//    translate(-getX(), -getY());
//    this.drawIt();
//    popMatrix();
//  }
//  abstract protected void drawIt();
//  public void draw()
//  {
//    if (abs(rotation)%360!=0)

//    {
//      this.rotateIt();
//    }
//    else
//    {
//      this.drawIt();
//    }
//  }
//}
class Cell// extends BaseShape
{
  private int[] colors = {0xffFFFFFF, 0xffFF0000, 0xff00FF00, 0xff0000FF};
  private int x;
  private int y;
  private int width;
  private int height;
  private boolean live = false;
  private int brush = 0;
  private int alpha = 255;
  private int pen = color(255,0,0);
  private int penThickness = 0;
  private int history = 0;
  private int team;// = 0;
  
  public Cell(int x, int y, int width, int height, boolean live, int team)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.live = live;
    this.team = team;
  }
  
  public void setLive(boolean live)
  {
     this.live = live; 
  }
  
  public boolean getLive()
  {
     return this.live; 
  }
  
  public int getTeam()
  {
    return this.team;
  }
  
  public void setTeam(int team)
  {
    this.team = team;
  }
  
  protected void drawIt() 
  {
    if(history == 255)
    {
      //this.live = false;
      history = 0;
    }
      
    if(this.live)
    {
      switch(team)
      {
        case 1:
          brush = colors[1];
          break;
        case 2:
          brush = colors[2];
          break;
        case 3:
          brush = colors[3];
          break;
       default:
         brush = colors[0];          
      }
      //brush = /*color(255,255,255);//*/color(history%255,history%255,history%255);
      history+=15;
    }
    else
    {
       brush = 0;
       //history--;
    }
    brush = (brush & 0xffffff) | (alpha << 24);
    pen = (pen & 0xffffff) | (alpha << 24);
    fill(brush);
    if (penThickness == 0) 
    {
      noStroke();
    }
    else 
    {
      strokeWeight(penThickness);
      stroke(pen);
    }

    //x += this.advanceSpeedX();
    //y += this.advanceSpeedY();

    rect(x, y, width, height);
  }

  protected int getX()
  {
    return x;
  }

  protected int getY()
  {
    return y;
  }

  public boolean pointInShape(int x1, int y1, int radius) 
  {
    if (x1 >= x && x1 <= (x + width) && y1 >= y && y1 <= (y + height)) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
  }
}

public void drawCells(Cell[][] cells)
{
  for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y ; j++)
    {
      cells[i][j].drawIt();
    }
  }
}


public void updateCells(Cell[][] cells)
{
  boolean[][] lives = new boolean[RES_X][RES_Y];
  for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y ; j++)
    {
      lives[i][j] = checkNeighborhood(cells, i, j);
    }
  }
  for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y ; j++)
    {
      cells[i][j].setLive(lives[i][j]);
    }
  }
}

public boolean checkNeighborhood(Cell[][] cells, int x, int y)
{
  // 4 teams counter
  int[] counter = new int[PLAYERS+1];
  
  // removes the center cell
  if(cells[x][y].getLive())
    counter[cells[x][y].getTeam()]--;
    
  for(int i = -1 ;i <= 1 ; i++)
  {
    for(int j = -1; j <= 1 ; j++)
    {
      int col = (x + i + RES_X) % RES_X;
      int row = (y + j + RES_Y) % RES_Y;
      //println("cols " + col + " row " + row);
      counter[cells[col][row].getTeam()] += cells[col][row].getLive() ? 1 : 0;
    }
  }
  boolean ret = false;
  for(int i = 0; i<PLAYERS+1 && !ret; i++)
  {
    if(counter[i]<=1 || counter[i]>3)
    {
      ret =  false;
    }
    else if(counter[i]==3)
    {
      ret =  true;
      cells[x][y].setTeam(findBiggestIndex(counter));
    }
    else
    {
      ret =  cells[x][y].getLive();
    }
  }
  return ret;
}

public int findBiggestIndex(int[] arr)
{
  int max = max(arr);
  for(int i = 0; i<arr.length;i++)
    if(arr[i] == max)
      return i;
  return 1;
}

public void userClick(Cell[][] cells, boolean live, int team, int radius)
{
  int x = mouseX/SIZE;
  int y = mouseY/SIZE;
  if (radius == 0)
  {
    cells[x][y].setLive(live);
    cells[x][y].setTeam(team);
  }
  else
  {
    for(int i=-radius;i<radius;i++)
    {
      if(x+i<0 || x+i>=RES_X)
        continue;
      for(int j=-radius;j<radius;j++)
      {
        if(y+j<0 || y+j>=RES_X)
          continue;
        
        cells[x+i][y+j].setLive(live);
        cells[x+i][y+j].setTeam(team);
      }
    }
  }
}

public void clearScreen(Cell[][] cells)
{
    for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y ; j++)
    {
      cells[i][j].setLive(false);
    }
  }
}

//public void userClick(Cell[][] cells, boolean live, int team, int radius)
//{
//  for(int i = 0; i < RES_X ; i++)
//  {
//    for(int j = 0; j < RES_Y ; j++)
//    {
//      if(cells[i][j].pointInShape(mouseX, mouseY, radius))
//      {
//        cells[i][j].setLive(live);
//        cells[i][j].setTeam(team);
//      }
//    }
//  }
//}

public void setCells(Cell[][] cells)
{
  for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y; j++)
    {
      cells[i][j] = new Cell(i*SIZE, j*SIZE, SIZE, SIZE, false, 0);
    }
  }
}

public void setRandomCells(Cell[][] cells)
{
  boolean live = false;
  for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y; j++)
    {
      //if((int)random(0,25) == 1)
      //{
      //  live = true;
      //}
      cells[i][j] = new Cell(i*SIZE, j*SIZE, SIZE, SIZE, live, 0);
      live = false;
    }
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Game_Of_life" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
