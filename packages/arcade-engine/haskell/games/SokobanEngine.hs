module SokobanEngine where

type Position = (Int, Int)

data Direction = U | D | L | R deriving (Eq, Show)

data SokobanState = SokobanState
  { walls :: [Position],
    boxes :: [Position],
    targets :: [Position],
    playerPosition :: Position
  }
  deriving (Eq, Show)

directionOffset :: Direction -> Position
directionOffset U = (0, -1)
directionOffset D = (0, 1)
directionOffset L = (-1, 0)
directionOffset R = (1, 0)

addPos :: Position -> Position -> Position
addPos (x1, y1) (dx, dy) = (x1 + dx, y1 + dy)

removeOne :: (Eq a) => a -> [a] -> [a]
removeOne _ [] = []
removeOne x (y : ys)
  | x == y = ys
  | otherwise = y : removeOne x ys

moveBox :: Position -> Position -> [Position] -> [Position]
moveBox oldPos newPos b = newPos : removeOne oldPos b

movePlayer :: SokobanState -> Direction -> SokobanState
movePlayer state dir =
  let offset = directionOffset dir
      nextP = playerPosition state `addPos` offset
      nextNextP = nextP `addPos` offset
      w = walls state
      b = boxes state

      isWall p = p `elem` w
      isBox p = p `elem` b
   in if isWall nextP
        then state
        else
          if isBox nextP
            then
              if not (isWall nextNextP) && not (isBox nextNextP)
                then state {playerPosition = nextP, boxes = moveBox nextP nextNextP b}
                else state
            else state {playerPosition = nextP}

isWin :: SokobanState -> Bool
isWin SokobanState {boxes = b, targets = t} =
  length b == length t && all (`elem` t) b