module Queens (boardString, canAttack) where

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString white black = unlines [ unwords [aux x y | y <- [0..7]] | x <- [0..7]]
 where aux i j
         | white == Just (i, j) = "W"
         | black == Just (i, j) = "B"
         | otherwise = "_"

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (x1, y1) (x2, y2) 
  | (x1 == x2) || (y1 == y2) = True
  | slope == 1 || slope == -1 = True
  | otherwise = False
 where slope = (y1 - y2) `div` (x1 - x2)
-- two points in the same diagonal are collinear and their slope is 1 or -1




name: queen-attack
version: 2.2.0.7

dependencies:
  - base

library:
  exposed-modules: Queens
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
      - queen-attack
      - hspec
