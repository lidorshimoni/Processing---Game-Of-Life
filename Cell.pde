class Cell// extends BaseShape
{
  private color color0 = color(255,255,255);
  private color color1 = color(255,0,0);
  private color color2 = color(0,255,0);
  private color color3 = color(0,0,255);
  private int x;
  private int y;
  private int width;
  private int height;
  private boolean live = false;
  private color brush = 0;
  private int alpha = 255;
  private color pen = color(255,0,0);
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
          brush = color1;
          break;
        case 2:
          brush = color2;
          break;
        case 3:
          brush = color3;
          break;
       default:
         brush = color0;          
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