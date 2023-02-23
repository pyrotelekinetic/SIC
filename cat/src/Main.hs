{-
 -  cat-sic - A utility to print SIC formated text correctly
 -  Copyright (C) 2023  Carter "pyrotelekinetic" Ison <carter@isons.org>
 -
 -  This program is free software: you can redistribute it and/or modify
 -  it under the terms of the GNU Affero General Public License as published by
 -  the Free Software Foundation, either version 3 of the License, or
 -  (at your option) any later version.
 -
 -  This program is distributed in the hope that it will be useful,
 -  but WITHOUT ANY WARRANTY; without even the implied warranty of
 -  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 -  GNU Affero General Public License for more details.
 -
 -  You should have received a copy of the GNU Affero General Public License
 -  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 -}

{-# LANGUAGE PatternSynonyms #-}

import System.Console.ANSI

pattern Indent = '\xF32A'
pattern Dedent = '\xF32B'

main = do
  i <- getContents
  let i' = lines i
  putStr . unlines $ f 4 0 i'

getLevel :: Int -> String -> (Int, String)
getLevel l (Indent : s) = getLevel (l + 1) s
getLevel l (Dedent : s) = getLevel (l - 1) s
getLevel l s = (l, s)

f :: Int -> Int -> [String] -> [String]
f _ _ [] = []
f w l (s : ss) = case getLevel l s of
  (0, s') -> s' : f w 0 ss
  (l', s') -> (cursorForwardCode (l' * w) ++ s') : f w l' ss
