module Minesweeper (annotate) where

import Data.Char (isSpace)
import Data.List


annotate :: [String] -> [String]
annotate board
  | all (all isSpace) board = board
  | all (all (\x -> x == '*')) board = board
  | otherwise = scanMatrix board 

scanMatrix :: [String] -> [String]
scanMatrix matrix = map (\r -> map (\c -> getCellValue r c) [0..(length (matrix !! r) - 1)]) [0..(length matrix - 1)]
  where
    getCellValue r c
      | matrix !! r !! c == '*' = '*'
      | otherwise = let neighborsList = [matrix !! i !! j | i <- [max 0 (r-1) .. min (length matrix - 1) (r+1)], j <- [max 0 (c-1) .. min (length (matrix !! 0) - 1) (c+1)]]
                        numMines = length (filter (== '*') neighborsList)
                    in if numMines /= 0 then head (show numMines) else ' '





name: minesweeper
version: 1.1.0.5

dependencies:
  - base

library:
  exposed-modules: Minesweeper
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
      - minesweeper
      - hspec
