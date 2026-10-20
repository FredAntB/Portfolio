module GameState where

import JigsawEngine (JigsawState)
import SokobanEngine (SokobanState)

data ActiveGameState = Sokoban SokobanState | Jigsaw JigsawState | NoGame