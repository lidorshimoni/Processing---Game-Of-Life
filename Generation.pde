
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
  int counter = 0;
  //int counter
  if(cells[x][y].getLive())
    counter--;
  for(int i = -1 ;i <= 1 ; i++)
  {
    for(int j = -1; j <= 1 ; j++)
    {
      int col = (x + i + RES_X) % RES_X;
      int row = (y + j + RES_Y) % RES_Y;
      counter += cells[col][row].getLive() ? cells[col][row].getTeam() == cells[x][y].getTeam() ? 1 : -1 : 0;
    }
  }
  
  if(counter<=1 || counter>3)
    return false;
  else if(counter==3)
  {
    cells[x][y].setTeam();
    return true;
    
  }
  else
    return cells[x][y].getLive();
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
