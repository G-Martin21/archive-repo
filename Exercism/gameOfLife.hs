module GameOfLife (tick) where

import Data.List (groupBy, sortOn)

tick :: [[Int]] -> [[Int]]
tick matrix = map (\cellsRow -> map getNewStatus cellsRow) $ positions matrix
  where getNewStatus cell = case getRowCol matrix cell of
                                 1 -> if process cell == 2 || process cell == 3 then 1 else 0
                                 0 -> if process cell == 3 then 1 else 0 
        process cell = sum $ getNeighborsVals cell matrix
        sizeMatrix = (length matrix, length matrix)

-- cell positions matrix -> cell = (row, col)
positions :: [[a]] -> [[(Int, Int)]]
positions xs = groupBy (\x y -> fst x == fst y) $ sortOn fst [(i, j) | (i, row) <- zip [0..] xs, (j, _) <- zip [0..] row]

getNeighborsVals :: (Int, Int) -> [[Int]] -> [Int]
getNeighborsVals cell matrix = let (row, col) = cell
                                   index = [0 .. length matrix - 1]
                                   isValid x y = x `elem` index && y `elem` index && (x, y) /= (row, col)
                                 in [getRowCol matrix (r, c) | r <- [row-1..row+1], c <- [col-1..col+1], isValid r c]            
getRowCol :: [[Int]] -> (Int, Int) -> Int
getRowCol matrix (row, col) = (matrix !! row) !! col






name: game-of-life
version: 1.0.0.0

dependencies:
  - base

library:
  exposed-modules: GameOfLife
  source-dirs: src
  ghc-options: -Wall
  # dependencies:
  # - foo       # List here the packages you
  # - bar       # want to use in your solution.

tests:
  test:
    main: Tests.hs
    source-dirs: test
    dependencies:
      - game-of-life
      - hspec
