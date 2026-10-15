type Position = (Int, Int)

data Direction = U | D | L | R

data GameState = GameState
  { walls :: [Position],
    boxes :: [Position],
    playerPosition :: Position
  }

isInRange :: Int -> Int -> Bool
isInRange x y = x >= 0 && x < y

isWallInPosition :: Position -> [Position] -> Bool
isWallInPosition p walls = p `elem` walls

isBoxInPosition :: Position -> [Position] -> Bool
isBoxInPosition p boxes = p `elem` boxes

moveBox :: Position -> Position -> [Position] -> [Position]
moveBox oldPos newPos boxes = newPos : filter (/= oldPos) boxes

movePlayer :: GameState -> Direction -> GameState
movePlayer g@GameState {playerPosition = p@(x, y), boxes = b, walls = w} U
  | isWallInPosition (x, (y - 1)) w = g
  | isBoxInPosition (x, (y - 1)) b && not (isWallInPosition (x, (y - 2)) w) = g {playerPosition = (x, (y - 1)), boxes = moveBox (x, (y - 1)) (x, (y - 2)) b}
  | otherwise = g {playerPosition = (x, (y - 1))}
movePlayer g@GameState {playerPosition = p@(x, y), boxes = b, walls = w} D
  | isWallInPosition (x, (y + 1)) w = g
  | isBoxInPosition (x, (y + 1)) b && not (isWallInPosition (x, (y + 2)) w) = g {playerPosition = (x, (y + 1)), boxes = moveBox (x, (y + 1)) (x, (y + 2)) b}
  | otherwise = g {playerPosition = (x, (y + 1))}
movePlayer g@GameState {playerPosition = p@(x, y), boxes = b, walls = w} L
  | isWallInPosition ((x - 1), y) w = g
  | isBoxInPosition ((x - 1), y) b && not (isWallInPosition ((x - 2), y) w) = g {playerPosition = ((x - 1), y), boxes = moveBox ((x - 1), y) ((x - 2), y) b}
  | otherwise = g {playerPosition = ((x - 1), y)}
movePlayer g@GameState {playerPosition = p@(x, y), boxes = b, walls = w} R
  | isWallInPosition ((x + 1), y) w = g
  | isBoxInPosition ((x + 1), y) b && not (isWallInPosition ((x + 2), y) w) = g {playerPosition = ((x + 1), y), boxes = moveBox ((x + 1), y) ((x + 2), y) b}
  | otherwise = g {playerPosition = ((x + 1), y)}
