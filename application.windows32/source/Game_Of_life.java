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

int SIZE = 2;
int RES_X = 1920/SIZE;
int RES_Y = 1080/SIZE;
int PLAYERS = 1;


Cell[][] cells = new Cell[RES_X][RES_Y];
 
 public void setup()
 {
   
   setCells(cells);
   loop();
 }
 
 
 public void draw()
 {
   //frameRate(10);
   delay(30);
   drawCells(cells);
   //int x = (int )random(192);
   //int y = (int )random(108);
   //cells[x][y].setLive(true);
   update(cells);

 }
 
 public void mouseDragged()
 {
   if(mouseButton == LEFT)
     userClick(cells, true);
  else
      userClick(cells, false);
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
  private int team = 0;
  
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
      this.live = false;
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

  public boolean pointInShape(int x1, int y1) 
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

public void update(Cell[][] cells)
{
  for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y ; j++)
    {
      cells[i][j].setLive(checkNeighborhood(cells, i, j));
    }
  }
}

public boolean checkNeighborhood(Cell[][] cells, int x, int y)
{
  // 4 teams counter
  int[] counter = new int[PLAYERS];
  
  // removes the center cell
  if(cells[x][y].getLive())
    counter[cells[x][y].getTeam()]--;
    
  for(int i = -1 ;i <= 1 ; i++)
  {
    for(int j = -1; j <= 1 ; j++)
    {
      int col = (x + i + RES_X) % RES_X;
      int row = (y + j + RES_Y) % RES_Y;
      counter[cells[col][row].getTeam()] += cells[col][row].getLive() ? 1 : 0;
    }
  }
  boolean ret = false;
  for(int i = 0; i<PLAYERS; i++)
  {
    if(counter[i]<=1 || counter[i]>3)
    {
      ret =  false;
    }
    else if(counter[i]==3)
    {
      cells[x][y].setTeam(i);
      ret =  true;
    }
    else
    {
      ret =  cells[x][y].getLive();
    }
  }
  return ret;
}

public void userClick(Cell[][] cells, boolean live)
{
  for(int i = 0; i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y ; j++)
    {
      if(cells[i][j].pointInShape(mouseX, mouseY))
      {
        cells[i][j].setLive(live);
      }
    }
  }
}

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
