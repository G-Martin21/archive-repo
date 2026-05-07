module ZebraPuzzle (Resident(..), Solution(..), solve) where

-- Lazy Dynamic Programming, we build recursively an array solution applying the conditions

import Data.Array
import Data.List 

data Resident = Englishman | Spaniard | Ukrainian | Norwegian | Japanese
  deriving (Eq, Show, Enum)

data Solution = Solution { waterDrinker :: Resident
                         , zebraOwner :: Resident
                         } deriving (Eq, Show)

data Houses = Red | Ivory | Green | Yellow | Blue deriving (Eq, Show, Enum)
data Drinks = Milk | Tea | Coffee | Water | Orange_juice deriving (Eq, Show, Enum)
data Pets = Dog | Snails | Fox | Horse | Zebra deriving (Eq, Show, Enum)
data Smokes = Old_Gold | Kools | Chesterfields | Lucky_Strike | Parliaments deriving (Eq, Show, Enum)

condition2 = (\(c, n, d, p, s) -> (n == Englishman && c == Red) || (n /= Englishman && c /= Red)) 
condition3 = (\(c, n, d, p, s) -> (n == Spaniard && p == Dog) || (n /= Spaniard && p /= Dog))
condition4 = (\(c, n, d, p, s) -> (c == Green && d == Coffee) || (c /= Green && d /= Coffee)) 
condition5 = (\(c, n, d, p, s) -> (n == Ukrainian && d == Tea) || (n /= Ukrainian && d /= Tea))
condition7 = (\(c, n, d, p, s) -> (s == Old_Gold && p == Snails) || (s /= Old_Gold && p /= Snails))
condition8 = (\(c, n, d, p, s) -> (c == Yellow && s == Kools) || (c /= Yellow && s /= Kools))
condition13 = (\(c, n, d, p, s) -> (s == Lucky_Strike && d == Orange_juice) || (s /= Lucky_Strike && d /= Orange_juice))
condition14 = (\(c, n, d, p, s)-> (n == Japanese && s == Parliaments) || (n /= Japanese && s /= Parliaments))                  

condition1 = [(c, n, d, p, s) | 
                                c <- [Red .. Blue],
                                n <- [Englishman .. Japanese],                    
                                d <- [Milk .. Orange_juice],
                                p <- [Dog .. Zebra],
                                s <- [Old_Gold .. Parliaments]]

listConditions = [condition2, condition3, condition4, condition5, condition7, condition8, 
                  condition13, condition14]

-- build an array where each succesive step apply one condition to the initial list of tuples (condition1) -> n steps -> final list, where n = size of the array (= #listConditions).

getSolution :: [[(Houses, Resident, Drinks, Pets, Smokes)]]
getSolution = solution
 where 
    size = length listConditions
    arr = array ((0, size)) [(i, inner i) | i <- [0..size]]
    inner i 
      | i == 0 = condition1
      | otherwise = [t | t <- arr ! (i-1), (listConditions !! (i-1)) t]
                                           
    size1 = length $ (arr ! size)
    listArr = arr ! size 
    -- apply the final conditions (location of each value) to get the tuple solution
    solution = [[t1, t2, t3, t4, t5] |                    
                  t1 <- [t | t <- listArr, pHouse1 t],
                  t2 <- [t | t <- listArr, pDifferent (t,t1)],
                  t3 <- [t | t <- listArr, pMilk t, all pDifferent [(t, t1), (t, t2)]],
                  t4 <- [t | t <- listArr, all pDifferent [(t,t1), (t,t2), (t,t3)]],
                  t5 <- [t | t <- listArr, all pDifferent [(t,t1), (t,t2), (t,t3), (t,t4)]],
                    any pBlue [(t1, t2), (t2, t3), (t3, t4), (t4, t5)],
                    any pGreen [(t1, t2), (t2, t3), (t3, t4), (t4, t5)],
                    any pFox [(t1, t2), (t2, t3), (t3, t4), (t4, t5)],
                    any pHorse [(t1, t2), (t2, t3), (t3, t4), (t4, t5)]]                                 
      where  
        -- condition10
        pHouse1 (_, n, _, _, _) = (n == Norwegian)
        -- condition9
        pMilk (_, _, d, _, _) = (d == Milk)
        -- condition 15
        pBlue ((leftc,leftn,_,_,_), (rightc,rightn,_,_,_)) =
                      (leftn == Norwegian && rightc == Blue) ||
                      (rightn == Norwegian && leftc == Blue)
        -- condition6                      
        pGreen ((leftc,_,_,_,_), (rightc,_,_,_,_)) =  (rightc == Green) && (leftc == Ivory)                   -- condition11     
        pFox ((_,_,_,leftp,lefts), (_,_,_,rightp,rights)) =
                      (lefts == Chesterfields && rightp == Fox) ||
                      (rights == Chesterfields && leftp == Fox)
        -- condition12              
        pHorse ((_,_,_,leftp,lefts), (_,_,_,rightp,rights)) =
                      (lefts == Kools && rightp == Horse) ||
                      (rights == Kools && leftp == Horse)
        pDifferent ((c, n, d, p, s), (c', n', d', p', s')) =
                      and [(c /= c'), (n /= n'), (d /= d'), (p /= p'), (s /= s')]                                                       

solve :: Solution
solve = Solution {waterDrinker = fst solutionTuple, zebraOwner = snd solutionTuple}
  where solutionTuple = getAnswer (head getSolution)

getAnswer :: [(Houses, Resident, Drinks, Pets, Smokes)] -> (Resident, Resident)
getAnswer people = (
     head [r | (_, r, Water, _, _) <- people],
     head [r | (_, r, _, Zebra, _) <- people] )                          







name: zebra-puzzle
version: 1.1.0.5

dependencies:
  - base

library:
  exposed-modules: ZebraPuzzle
  source-dirs: src
  ghc-options: -Wall
  dependencies:
  # - foo       # List here the packages you
  # - bar       # want to use in your solution.
  - array
  
tests:
  test:
    main: Tests.hs
    source-dirs: test
    dependencies:
      - zebra-puzzle
      - hspec
      
