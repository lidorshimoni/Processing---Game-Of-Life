
public void setCells(Cell[][] cells)
{
  for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y; j++)
    {
      cells[i][j] = new Cell(i*SIZE, j*SIZE, SIZE, SIZE, false, 1);
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
      cells[i][j] = new Cell(i*SIZE, j*SIZE, SIZE, SIZE, live, 1);
      live = false;
    }
  }
}
