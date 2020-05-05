class Cell// extends BaseShape
{
  private color[] colors = {#FFFFFF, #FF0000, #00FF00, #0000FF};
  private int x;
  private int y;
  private int width;
  private int height;
  private boolean live = false;
  private color brush = 0;
  private int alpha = 255;
  private color pen = color(255,0,0);
  private int penThickness = 0;
  private int deadTime = 0;
  private int team = 1;
  
  public Cell(int x, int y, int width, int height, boolean live, int team)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.live = live;
    this.team = team-1;
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
    this.team = team-1;
  }
  
  protected void drawIt() 
  {
      
    if(this.live)
    {
      switch(team)
      {
        case 0:
          brush = colors[0];
          break;
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
      this.deadTime = 200/2;
    }
    else
    {
      if (this.deadTime >0)
      {
        switch(team)
        {
          case 0:
            brush = color(this.deadTime*2, this.deadTime*2, this.deadTime*2); 
            break;
          case 1:
            brush = color(this.deadTime*2, 0, this.deadTime/2); 
            break;
          case 2:
            brush = color(this.deadTime/5, this.deadTime*2, 0); 
            break;
          case 3:
            brush = color(0, this.deadTime/1.5, this.deadTime*2);
            break;
         default:
           brush = color(0, this.deadTime*2, this.deadTime*2);         
        }
        this.deadTime-=1;
      }
       
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
