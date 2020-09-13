static final int NONE = 0, RED = 1, BLUE = 2;

final int rows = 3, columns = 3;

int[][] board;
final int boardWidth = 720, boardHeight = 720;

int turn;

void setup() {
  size(1280, 720);

  turn = RED;

  board = new int[rows][columns];
  for (int row = 0; row < rows; row++)
    for (int col = 0; col < columns; col++)
      board[row][col] = NONE;
}

void draw() {
  background(100);

  for (int row = 0; row < rows; row++)
    for (int col = 0; col < columns; col++) {
      switch(board[row][col]) {
      case NONE:
        fill(57);
        break;
      case RED:
        fill(#FF0000);
        break;
      case BLUE:
        fill(#0000FF);
        break;
      }

      rect(col * boardWidth / columns, row * boardHeight / rows, boardWidth / columns, boardHeight / rows);
    }

  fill(turn == RED ? #FF0000 : #0000FF);
  square(boardWidth + 15, 15, 50);
}

void mouseReleased() {
  int row = mouseY / (boardHeight / rows);
  int col = mouseX / (boardWidth / columns);
  updateBoard(row, col);
}

void updateBoard(int row, int col) {
  if (board[row][col] == NONE)
  {
    board[row][col] = turn;
    turn = turn == RED ? BLUE : RED;

    println(hasWon());
  }
}

int hasWon() {
  int value = NONE;
  int amt;

  for (int row = 0; row < rows; row++) {
    if (board[row][0] == NONE)
      continue;
    value = board[row][0];

    amt = 1;
    for (int col = 1; col < columns; col++)
      if (board[row][col] == value)
        amt++;
      else
        break;

    if (amt >= columns)
      return value;
  }

  for (int col = 0; col < columns; col++) {
    if (board[0][col] == NONE)
      continue;
    value = board[0][col];

    amt = 1;
    for (int row = 1; row < rows; row++)
      if (board[row][col] == value)
        amt++;
      else
        break;

    if (amt >= rows)
      return value;
  }

  if (board[0][0] != NONE) {
    amt = 1;
    value = board[0][0];
    for (int pos = 1; pos < rows; pos++) {
      if (board[pos][pos] == value)
        amt++;
    }

    if (amt >= rows)
      return value;
  }

  if (board[rows - 1][0] != NONE) {
    amt = 1;
    value = board[rows - 1][0];
    for (int pos = 1; pos < rows; pos++) {
      if (board[rows - 1 - pos][pos] == value)
        amt++;
    }

    if (amt >= rows)
      return value;
  }

  return NONE;
}
