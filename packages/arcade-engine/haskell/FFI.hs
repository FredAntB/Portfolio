{-# LANGUAGE ForeignFunctionInterface #-}

module FFI where

import Foreign
import Foreign.C.Types
import GameState
import JigsawEngine qualified as Jigsaw
import SokobanEngine qualified as Sokoban

--------------------------------------------------------------------------------
-- Memory Parsing Helpers
--------------------------------------------------------------------------------

peekPositionArray :: Ptr CInt -> CInt -> IO [(Int, Int)]
peekPositionArray ptr len
  | ptr == nullPtr || len <= 0 = return []
  | otherwise = do
      cInts <- peekArray (fromIntegral (len * 2)) ptr
      return (toPairs (map fromIntegral cInts))
  where
    toPairs [] = []
    toPairs (x : y : xs) = (x, y) : toPairs xs
    toPairs _ = []

peekJigsawArray :: Ptr CInt -> CInt -> IO [(Int, Int, Int)]
peekJigsawArray ptr len
  | ptr == nullPtr || len <= 0 = return []
  | otherwise = do
      cInts <- peekArray (fromIntegral (len * 3)) ptr
      return (toTriplets (map fromIntegral cInts))
  where
    toTriplets [] = []
    toTriplets (x : y : pn : xs) = (x, y, pn) : toTriplets xs
    toTriplets _ = []

--------------------------------------------------------------------------------
-- Sokoban Exports
--------------------------------------------------------------------------------

foreign export ccall "init_sokoban"
  c_init_sokoban :: Ptr CInt -> CInt -> Ptr CInt -> CInt -> Ptr CInt -> CInt -> CInt -> CInt -> IO (Ptr ())

c_init_sokoban :: Ptr CInt -> CInt -> Ptr CInt -> CInt -> Ptr CInt -> CInt -> CInt -> CInt -> IO (Ptr ())
c_init_sokoban wPtr wLen bPtr bLen tPtr tLen px py = do
  wList <- peekPositionArray wPtr wLen
  bList <- peekPositionArray bPtr bLen
  tList <- peekPositionArray tPtr tLen
  let player = (fromIntegral px, fromIntegral py)
      sokobanState =
        Sokoban.SokobanState
          { Sokoban.walls = wList,
            Sokoban.boxes = bList,
            Sokoban.targets = tList,
            Sokoban.playerPosition = player
          }
      wrappedState = Sokoban sokobanState
  sPtr <- newStablePtr wrappedState
  return (castPtr (castStablePtrToPtr sPtr))

foreign export ccall "step_sokoban"
  c_step_sokoban :: Ptr () -> CInt -> IO (Ptr ())

c_step_sokoban :: Ptr () -> CInt -> IO (Ptr ())
c_step_sokoban ptr dirCode = do
  if ptr == nullPtr
    then return nullPtr
    else do
      let sPtr = castPtrToStablePtr (castPtr ptr)
      state <- deRefStablePtr sPtr
      freeStablePtr sPtr
      case state of
        Sokoban s -> do
          let dir = case dirCode of
                0 -> Sokoban.U
                1 -> Sokoban.D
                2 -> Sokoban.L
                _ -> Sokoban.R
              newState = Sokoban (Sokoban.movePlayer s dir)
          newPtr <- newStablePtr newState
          return (castPtr (castStablePtrToPtr newPtr))
        _ -> do
          newPtr <- newStablePtr state
          return (castPtr (castStablePtrToPtr newPtr))

--------------------------------------------------------------------------------
-- Jigsaw Exports
--------------------------------------------------------------------------------

foreign export ccall "init_jigsaw"
  c_init_jigsaw :: Ptr CInt -> CInt -> Ptr CInt -> CInt -> IO (Ptr ())

c_init_jigsaw :: Ptr CInt -> CInt -> Ptr CInt -> CInt -> IO (Ptr ())
c_init_jigsaw pPtr pLen ePtr eLen = do
  pList <- peekJigsawArray pPtr pLen
  eList <- peekJigsawArray ePtr eLen
  let emptyPos = case eList of
        [e] -> e
        _ -> (0, 0, 0)
      jigsawState =
        Jigsaw.JigsawState
          { Jigsaw.pieces = pList,
            Jigsaw.emptyPosition = emptyPos
          }
      wrappedState = Jigsaw jigsawState
  sPtr <- newStablePtr wrappedState
  return (castPtr (castStablePtrToPtr sPtr))

foreign export ccall "step_jigsaw"
  c_step_jigsaw :: Ptr () -> CInt -> IO (Ptr ())

c_step_jigsaw :: Ptr () -> CInt -> IO (Ptr ())
c_step_jigsaw ptr dirCode = do
  if ptr == nullPtr
    then return nullPtr
    else do
      let sPtr = castPtrToStablePtr (castPtr ptr)
      state <- deRefStablePtr sPtr
      freeStablePtr sPtr
      case state of
        Jigsaw s -> do
          let dir = case dirCode of
                0 -> Jigsaw.U
                1 -> Jigsaw.D
                2 -> Jigsaw.L
                _ -> Jigsaw.R
              newState = Jigsaw (Jigsaw.movePiece s dir)
          newPtr <- newStablePtr newState
          return (castPtr (castStablePtrToPtr newPtr))
        _ -> do
          newPtr <- newStablePtr state
          return (castPtr (castStablePtrToPtr newPtr))

--------------------------------------------------------------------------------
-- Memory Cleanup Export
--------------------------------------------------------------------------------

foreign export ccall "free_game_state"
  c_free_game_state :: Ptr () -> IO ()

c_free_game_state :: Ptr () -> IO ()
c_free_game_state ptr = do
  if ptr /= nullPtr
    then freeStablePtr (castPtrToStablePtr (castPtr ptr))
    else return ()