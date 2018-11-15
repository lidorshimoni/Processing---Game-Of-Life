
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
