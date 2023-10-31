# py hw3.py
# Matrix: 1 * 1,* 2 *,* * 1
# Matrix Demo: * * 1,* 3 *,* * *

player1 = '/'
player2 = '\\'

def isMoveValid(node, i, j):
  # is move in range
  if (i not in range(len(node))) or (j not in range(len(node))):
    return False
  # is cell empty
  if node[i][j] != '':
    return False
  return True

def calculateUtility(i, j, player, isMin, tmpDiagonals):
  utility = 0
  
  if player == player1:
    tmpDiagonals[i][j+1] += 1
    diagsUpperRight = tmpDiagonals[i][j+1]
    matrixUpperRight = matrix[i][j+1]

    if str(diagsUpperRight) == matrixUpperRight:
      utility += diagsUpperRight

    tmpDiagonals[i+1][j] += 1
    diagsLowerLeft = tmpDiagonals[i+1][j]
    matrixLowerLeft = matrix[i+1][j]

    if str(diagsLowerLeft) == matrixLowerLeft:
      utility += diagsLowerLeft
  else: # player2
    tmpDiagonals[i][j] += 1
    diagsUpperLeft = tmpDiagonals[i][j]
    matrixUpperLeft = matrix[i][j]

    if str(diagsUpperLeft) == matrixUpperLeft:
      utility += diagsUpperLeft

    tmpDiagonals[i+1][j+1] += 1
    diagsLowerRight = tmpDiagonals[i+1][j+1]
    matrixLowerRight = matrix[i+1][j+1]

    if str(diagsLowerRight) == matrixLowerRight:
      utility += diagsLowerRight

  if isMin:
    utility = -utility

  return utility

def isTerminal(node):
  for i in range(len(node)):
    for j in range(len(node[i])):
      if node[i][j] not in [player1, player2]:
        return False
  return True

#stores  every move that can be made from current state
#eg: 2x2 initial state -> there are 4 moves that can be made, each one is a child
def getChildList(node, player, isMin, currDiagonals, lastUtility):
  childList = []  

  for i in range(len(node)):
    for j in range(len(node[i])):
      if isMoveValid(node, i, j):
        # make a copy of node
        child = [['' for x in range(len(node))] for y in range(len(node))]
        for a in range(len(node)):
          for b in range(len(node[a])):
            child[a][b] = node[a][b]

        # make a copy of diagonals
        tmpDiagonals = [['' for z in range(len(currDiagonals))] for t in range(len(currDiagonals))]
        for c in range(len(currDiagonals)):
          for d in range(len(currDiagonals[c])):
            tmpDiagonals[c][d] = currDiagonals[c][d]

        utility = lastUtility + calculateUtility(i, j, player, isMin, tmpDiagonals)
        child[i][j] = player
        childList.append((child, utility, (i,j), tmpDiagonals))

  return childList

#node[0] = updated ver. of the grid after making this move (mxm array)
#node[1] = utility this move will earn you (+1 / -1)
#node[2] = move in (i,j) format
#node[3] = updated version of the diagonals after making this move

def minEval(node, alpha, beta, AIPlayer, userPlayer):
  move = node[2]
  if isTerminal(node[0]):
    return node

  bestChild = node[0]
  bestMove = move

  for c in getChildList(node[0], userPlayer, True, node[3], node[1]):
    val = maxEval(c, alpha, beta, AIPlayer, userPlayer)
    if (val[1] < beta):
      beta = val[1]         #update beta
      bestChild = c[0]      #update bestChild
      bestMove = c[2]       #update bestMove
    if alpha >= beta:
      return (c[0], beta, c[2])
  return (bestChild, beta, bestMove)

def maxEval(node, alpha, beta, AIPlayer, userPlayer):
  move = node[2]

  if isTerminal(node[0]):
    return node
  
  bestChild = node[0]
  bestMove = move

  for c in getChildList(node[0], AIPlayer, False, node[3], node[1]):
    val = minEval(c, alpha, beta, AIPlayer, userPlayer)
    if (val[1] > alpha):
      alpha = val[1]      #update alpha
      bestChild = c[0]    #update bestChild
      bestMove = c[2]     #update bestMove
    if alpha >= beta:
      return (c[0], alpha, c[2])
  return (bestChild, alpha, bestMove)

def evaluate(startNode, AIPlayer, userPlayer):
  return maxEval((startNode, 0, (-1,-1), diagonals), float("-inf"), float("inf"), AIPlayer, userPlayer)

# user input handling

matrixRowList = input("Matrix: ").split(',')
# Example (Matrix: 1 * 1,* 2 *,* * 1)
# matrixRowList[0] = "1 * 1"
# matrixRowList[1] = "* 2 *"
# matrixRowList[2] = "* * 1"

m = len(matrixRowList) - 1
if m == 0 | (m % 2 != 0):
  print("Error: m must be an even number larger than 2! (m: {})".format(m))
  exit(0)

grid = [['' for i in range(m)] for j in range(m)] # m x m grid with empty strings (players will fill)
matrix = [['' for i in range(m + 1)] for j in range(m + 1)] # (m + 1) x (m + 1) matrix with empty strings (user input)

diagonals = [[0 for i in range(m + 1)] for j in range(m + 1)] # (m + 1) x (m + 1) matrix with 0s 
# (can be used to keep track of the number of diagonals coming out of intersections)

for i in range(m + 1):
  rowCellList = matrixRowList[i].split()
  # Example (i = 0):
  # rowCellList[0] = "1"
  # rowCellList[1] = "*"
  # rowCellList[2] = "1"
  rowCellCount = len(rowCellList)
  if rowCellCount != m + 1:
    print("Error: Number of rows and columns must be equal! (rows: {} columns: {})".format(m, rowCellCount - 1))
    exit(0)
  for j in range(rowCellCount):
    cell = rowCellList[j]
    # Example (i = 0, j = 0):
    # cell = "1"
    if cell not in ['*','1','2','3']:
      print("Error: Invalid value '{}'!".format(cell))
      exit(0)
    matrix[i][j] = cell

user = int(input("Choose a player (type 1 or 2): "))
if user not in [1, 2]:
  print("Error: Invalid value '{}'!".format(user))
  exit(0)

print("You are Player {}".format(user))

if user == 1:
  userTurn = True
  userPlayer = player1
  AIPlayer = player2
  player = userPlayer  #not used
else:
  userTurn = False
  userPlayer = player2
  AIPlayer = player1 
  player = AIPlayer

userPoint = 0

while(not isTerminal(grid)):
  print(grid)

  if userTurn:
    userMove = input("Make your move (type i,j): ").split(',')
    while len(userMove) != 2:
      print("Error: Invalid move, try again!")
      userMove = input("Make your move (type i,j): ").split(',')
    i = int(userMove[0])
    j = int(userMove[1])
    while not isMoveValid(grid, i, j):
      print("Error: Invalid move, try again!")
      userMove = input("Make your move (type i,j): ").split(',')
      i = int(userMove[0])
      j = int(userMove[1])
    userPoint += calculateUtility(i, j, userPlayer, False, diagonals)
    grid[i][j] = userPlayer
  else:
    print("Wait for AI to make its move...")
    val = evaluate(grid, AIPlayer, userPlayer)
    i = val[2][0]
    j = val[2][1]
    userPoint -= calculateUtility(i, j, AIPlayer, False, diagonals)
    grid = val[0]
  userTurn = not userTurn
  if player == userPlayer: #this part is not being used
    player = AIPlayer
  else:
    player = userPlayer

print(grid)

print("userPoint: {}".format(userPoint))

if userPoint < 0:
  print("You lost!")
elif userPoint > 0:
  print("You won!")
else:
  print("It is a tie!")
