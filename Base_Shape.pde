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
