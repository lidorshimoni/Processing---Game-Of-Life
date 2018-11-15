
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
