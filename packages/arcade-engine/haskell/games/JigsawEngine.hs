module JigsawEngine where

import Data.List (sortBy)
import Data.Ord (comparing)

-- Position: (row, column, piece_number)
type Position = (Int, Int, Int)

data Direction = U | D | L | R deriving (Eq, Show)

data JigsawState = JigsawState
  { pieces :: [Position],
    emptyPosition :: Position -- (row, col, 0)
  }
  deriving (Eq, Show)

-- Get offset based on movement direction
dirOffset :: Direction -> (Int, Int)
dirOffset U = (-1, 0)
dirOffset D = (1, 0)
dirOffset L = (0, -1)
dirOffset R = (0, 1)

-- Find a piece located at coordinates (r, c)
findPieceAt :: (Int, Int) -> [Position] -> Maybe Position
findPieceAt (r, c) = lookupBy (\(x, y, _) -> x == r && y == c)
  where
    lookupBy _ [] = Nothing
    lookupBy p (x : xs) = if p x then Just x else lookupBy p xs

movePiece :: JigsawState -> Direction -> JigsawState
movePiece state dir =
  let (ex, ey, epn) = emptyPosition state
      (dr, dc) = dirOffset dir
      targetPos = (ex + dr, ey + dc)
   in case findPieceAt targetPos (pieces state) of
        Nothing -> state -- Invalid move: no piece in that direction
        Just (px, py, pn) ->
          let newPieces = (ex, ey, pn) : filter (\(x, y, _) -> (x, y) /= targetPos) (pieces state)
              newEmpty = (px, py, epn)
           in state {pieces = newPieces, emptyPosition = newEmpty}

isWin :: JigsawState -> Bool
isWin JigsawState {pieces = p, emptyPosition = (ex, ey, epn)} =
  -- Sort pieces primarily by row, secondarily by column
  let sortedByGrid = sortBy (comparing (\(r, c, _) -> (r, c))) p
      pieceNumbers = map (\(_, _, pn) -> pn) sortedByGrid
      expected = [1 .. length p]
   in pieceNumbers == expected