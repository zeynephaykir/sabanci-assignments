include "all_equal.mzn";

% PARAMS
% e.g.
% n = 5
/* matrix_demo = [|"*","*","2","*","1"
                  |"*","4","1","*","*"
                  |"*","*","1","4","*"
                  |"0","3","*","2","*"
                  |"*","*","*","*","1"
                  |]
                  
                when giving input give n -> n-1
                e.g matrix below is n = 4
*/

/* input_instance1 = [|"*","2","*","2","0"
                      |"2","*","*","*","2"
                      |"*","*","*","*","*"
                      |"*","*","*","*","2"
                      |"*","2","*","2","*"
                      |]
*/

/* input_instance1 = [|"*","*","*","*","1","*","*","*","*","1","*"    
                      |"*","1","2","1","*","*","*","3","*","*","1"    
                      |"1","3","1","*","2","*","*","2","*","1","*"    
                      |"*","*","1","*","*","1","*","2","3","*","*"    
                      |"*","*","*","1","*","1","1","*","1","2","*"    
                      |"*","2","*","2","2","*","2","*","2","*","*"    
                      |"*","3","3","*","*","*","*","*","*","2","*"    
                      |"1","1","2","2","2","3","1","2","2","*","*"    
                      |"*","1","*","*","*","1","2","*","*","3","*"    
                      |"*","*","2","1","*","2","2","*","1","1","*"    
                      |"1","*","*","*","1","*","*","*","*","1","*"    
                      |]
*/

/*                 * * * * 1 * * * * 1 *
                   * 1 2 1 * * * 3 * * 1
                   1 3 1 * 2 * * 2 * 1 *
                   * * 1 * * 1 * 2 3 * *
                   * * * 1 * 1 1 * 1 2 *
                   * 2 * 2 2 * 2 * 2 * *
                   * 3 3 * * * * * * 2 *
                   1 1 2 2 2 3 1 2 2 * *
                   * 1 * * * 1 2 * * 3 *
                   * * 2 1 * 2 2 * 1 * *
                   1 * * * 1 * * * * 1 *
                      
*/

/* matrix_0 = [|"*","0","*","*","*","0"
             |"*","3","*","3","*","*"
             |"1","*","*","*","3","*"
             |"*","3","*","*","2","2"
             |"*","*","4","*","*","*"
             |"*","*","*","*","1","*"
             |]
*/
/* easy_matrix1 = [|"*","1","*","*","*","1"
             |"0","*","1","*","2","*"
             |"*","*","*","*","*","0"
             |"0","*","*","*","*","*"
             |"*","*","3","*","2","*"
             |"0","1","*","*","1","0"
             |]
*/
/* easy_matrix2 = [|"*","2","*","1","*","*"
             |"*","*","*","*","2","0"
             |"0","*","*","*","2","*"
             |"*","*","3","*","*","1"
             |"*","*","*","3","*","1"
             |"1","*","0","*","1","*"
             |]
*/
/* easy_matrix3 = [|"*","*","1","*","2","*"
             |"1","*","1","3","*","2"
             |"*","2","*","*","2","*"
             |"1","*","2","*","*","1"
             |"*","*","1","3","2","*"
             |"1","*","*","*","2","*"
             |]
*/
/* easy_matrix4 = [|"1","1","*","*","*","1"
             |"1","*","*","3","*","1"
             |"*","*","2","*","3","*"
             |"2","*","*","*","1","*"
             |"*","*","1","3","*","*"
             |"1","1","*","*","1","0"
             |]
*/
/* med_matrix1 = [|"*","1","*","1","0","*"
             |"*","2","*","*","*","*"
             |"*","1","3","*","4","*"
             |"*","2","*","4","*","*"
             |"1","*","*","*","*","1"
             |"*","*","*","1","0","*"
             |]
*/
/* med_matrix2 = [|"0","*","1","*","*","0"
             |"*","3","*","*","*","*"
             |"*","2","*","*","2","1"
             |"1","*","*","*","2","1"
             |"*","3","*","3","2","*"
             |"*","*","*","0","*","*"
             |]
*/
/* med_matrix3 = [|"0","*","2","*","1","*"
             |"*","*","*","1","*","*"
             |"0","*","*","4","*","*"
             |"1","1","*","*","4","*"
             |"*","*","3","*","*","*"
             |"*","1","*","*","0","*"
             |]
*/
/* med_matrix4 = [|"*","*","0","*","1","*"
             |"2","*","*","2","*","1"
             |"*","3","2","1","*","1"
             |"1","*","1","*","*","1"
             |"*","*","*","2","*","1"
             |"*","0","*","*","1","*"
             |]
*/
/* med_matrix5 = [|"*","*","0","2","*","*"
             |"*","*","3","*","2","1"
             |"*","3","1","*","*","*"
             |"0","*","2","*","3","*"
             |"*","*","*","1","*","0"
             |"*","1","1","*","*","*"
             |]
*/
/* hard_matrix1 = [|"*","1","*","1","*","*"
             |"*","*","1","3","3","*"
             |"*","3","3","*","1","*"
             |"*","*","2","*","*","*"
             |"*","3","2","2","1","*"
             |"*","1","*","*","1","*"
             |]
*/
/* hard_matrix2 = [|"*","*","*","*","*","*"
             |"1","*","3","*","*","1"
             |"1","*","2","3","*","1"
             |"*","2","*","*","1","1"
             |"1","*","2","3","1","*"
             |"*","*","*","*","*","*"
             |]
*/
/* hard_matrix3 = [|"*","*","*","1","*","*"
             |"0","2","*","*","1","*"
             |"*","*","*","*","*","1"
             |"*","3","1","2","1","*"
             |"2","*","2","*","2","*"
             |"*","*","1","*","1","*"
             |]
*/
/* hard_matrix4 = [|"*","*","*","*","1","*"
             |"0","2","3","2","2","1"
             |"*","1","2","*","3","1"
             |"1","*","*","1","*","1"
             |"*","2","1","3","*","*"
             |"*","*","1","*","1","*"
             |]
*/

/* hard_matrix5 = [|"*","*","1","*","*","*"
             |"1","*","2","3","1","*"
             |"*","1","2","*","2","*"
             |"*","*","3","3","2","*"
             |"*","1","2","*","*","*"
             |"*","*","*","*","1","*"
             |]
*/
int: n;
array[1..n+1,1..n+1] of string: matrix;

% CONST VARS
array[int] of string: values = ["/", "\\"];
% 1 means /
% 2 means \

% DECISION VARS
array[1..n,1..n] of var 1..length(values): grid;
    
% FUNCTIONS
function bool: isUpperLeftCellValid(int: i, int: j)  = i-1 >= 1 /\ i-1 <= n /\ j-1 >= 1 /\ j-1 <= n; % grid[i-1,j-1]
function bool: isUpperRightCellValid(int: i, int: j) = i-1 >= 1 /\ i-1 <= n /\ j   >= 1 /\ j   <= n; % grid[i-1,j]
function bool: isLowerLeftCellValid(int: i, int: j)  = i   >= 1 /\ i   <= n /\ j-1 >= 1 /\ j-1 <= n; % grid[i,j-1]
function bool: isLowerRightCellValid(int: i, int: j) = i   >= 1 /\ i   <= n /\ j   >= 1 /\ j   <= n; % grid[i,j]

% PREDICATES
predicate equalLowerCells(int: i, int: j) = grid[i,j-1]   == grid[i,j];
predicate equalLeftCells(int: i, int: j)  = grid[i-1,j-1] == grid[i,j-1];
predicate equalUpperCells(int: i, int: j) = grid[i-1,j-1] == grid[i-1,j];
predicate equalRightCells(int: i, int: j) = grid[i-1,j]   == grid[i,j];

predicate differentCrossCellsLeft(int: i, int: j)  = grid[i-1,j-1] != grid[i,j];
predicate differentCrossCellsRight(int: i, int: j) = grid[i-1,j]   != grid[i,j-1];

predicate checkUpperRight(int: i, int: j, int: width, int: length) = 
  if isUpperRightCellValid(i,j) /\ grid[i-1,j] == 2 then
    if false == checkLowerRight(i,j,width,length,1) then
       checkUpperRight(i+1,j+1,width,length+1)
    else true
    endif  
  else false
  endif;

predicate checkLowerLeft(int: i, int: j, int: width, int: length, int: currentLevel) = 
  if isLowerLeftCellValid(i,j) /\ grid[i,j-1] == 2 then
    if currentLevel == length then true
    else checkLowerLeft(i-1,j-1,width,length,currentLevel+1)
    endif
  else false
  endif;
  
predicate checkLowerRight(int: i, int: j, int: width, int: length, int: currentLevel) = 
  if isLowerRightCellValid(i,j) /\ grid[i,j] == 1 then
    if currentLevel == width then checkLowerLeft(i,j,width,length,1)
    else checkLowerRight(i+1,j-1,width,length,currentLevel+1)
    endif
  else false
  endif;  
  
predicate loop(int: i, int: j, int: width) = 
  if isUpperLeftCellValid(i,j) /\ grid[i-1,j-1] == 1 then
    if false == checkUpperRight(i,j,width,1) then
       loop(i-1,j+1,width+1)
    else true
    endif
  else false
  endif;

% CONSTRAINTS
% upper left cell:  grid[i-1,j-1]
% upper right cell: grid[i-1,j]
% lower left cell:  grid[i,j-1]
% lower right cell: grid[i,j]
constraint forall(i,j in 1..n+1)(false == loop(i,j,1));

constraint forall(i,j in 1..n+1)(
  if matrix[i,j] == "0" then
    if isUpperLeftCellValid(i,j)  then grid[i-1,j-1] = 1 endif /\ % affects upper left cell
    if isUpperRightCellValid(i,j) then grid[i-1,j]   = 2 endif /\ % affects upper right cell
    if isLowerLeftCellValid(i,j)  then grid[i,j-1]   = 2 endif /\ % affects lower left cell
    if isLowerRightCellValid(i,j) then grid[i,j]     = 1 endif    % affects lower right cell
  elseif matrix[i,j] == "4" then
    if isUpperLeftCellValid(i,j)  then grid[i-1,j-1] = 2 endif /\ % affects upper left cell
    if isUpperRightCellValid(i,j) then grid[i-1,j]   = 1 endif /\ % affects upper right cell
    if isLowerLeftCellValid(i,j)  then grid[i,j-1]   = 1 endif /\ % affects lower left cell
    if isLowerRightCellValid(i,j) then grid[i,j]     = 2 endif    % affects lower right cell
  elseif matrix[i,j] == "1" then
    % corner
    if     i == 1 /\ j == 1     then grid[i,j]     = 2 % upper left corner affects lower right cell
    elseif i == 1 /\ j == n+1   then grid[i,j-1]   = 1 % upper right corner affects lower left cell
    elseif i == n+1 /\ j == 1   then grid[i-1,j]   = 1 % lower left corner affects upper right cell
    elseif i == n+1 /\ j == n+1 then grid[i-1,j-1] = 2 % lower right corner affects upper left cell
    % edge
    elseif i == 1   then equalLowerCells(i,j) % upper edge affects lower left and lower right cells
    elseif j == n+1 then equalLeftCells(i,j)  % right edge affects upper left and lower left cells    
    elseif i == n+1 then equalUpperCells(i,j) % lower edge affects upper left and upper right cells        
    elseif j == 1   then equalRightCells(i,j) % left edge affects upper right and lower right cells   
    % center
    else grid[i-1,j-1]  = 1 /\ grid[i,j]   = 1 /\ differentCrossCellsRight(i,j) % upper left cell and its cross are / and the others are different
         \/ grid[i-1,j] = 2 /\ grid[i,j-1] = 2 /\ differentCrossCellsLeft(i,j)  % upper right cell and its cross are \ and the others are different
    endif
  elseif matrix[i,j] == "2" then
    % cannot be a corner
    % edge
    if     i == 1   then grid[i,j-1]   = 1 /\ grid[i,j]   = 2 % upper edge affects lower left and lower right cells
    elseif j == n+1 then grid[i-1,j-1] = 2 /\ grid[i,j-1] = 1 % right edge affects upper left and lower left cells    
    elseif i == n+1 then grid[i-1,j-1] = 2 /\ grid[i-1,j] = 1 % lower edge affects upper left and upper right cells        
    elseif j == 1   then grid[i-1,j]   = 1 /\ grid[i,j]   = 2 % left edge affects upper right and lower right cells    
    % center  
    else all_equal([grid[i-1,j-1], grid[i-1,j], grid[i,j-1], grid[i,j]])    % all cells are equal
         \/ (differentCrossCellsLeft(i,j) /\ differentCrossCellsRight(i,j)) % cross cells are different
    endif
  elseif matrix[i,j] == "3" then
    % cannot be a corner
    % cannot be an edge
    % center
    grid[i-1,j-1]  = 2 /\ grid[i,j]   = 2 /\ differentCrossCellsRight(i,j) % upper left cell and its cross are \ and the others are different
    \/ grid[i-1,j] = 1 /\ grid[i,j-1] = 1 /\ differentCrossCellsLeft(i,j)  % upper right cell and its cross are / and the others are different
  else matrix[i,j] = matrix[i,j] % do nothing
  endif);  

solve satisfy;

% TODO: Try to convert this to an easier-to-understand format
output [values[fix(grid[i,j])] ++ " " ++ 
       if j == n then "\n" endif
       | i,j in 1..n];
