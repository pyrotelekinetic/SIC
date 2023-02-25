{-
 -  format-sic - A utility to convert regular text into SIC format
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

main = do
  i <- getContents
  let i' = diff $ map getLevel (lines i)
  let o = unlines $ map format i'
  putStr o

getLevel :: String -> (Int, String)
getLevel = f 0
  where
  f :: Int -> String -> (Int, String)
  f l ('\t' : ss) = f (succ l) ss
  f l s = (l, s)

diff :: [(Int, String)] -> [(Int, String)]
diff = f 0
  where
  f :: Int -> [(Int, String)] -> [(Int, String)]
  f _ [] = []
  f l ((c, s) : xs) = (l', s) : f c xs
    where l' = c - l

dent :: Int -> String
dent 0 = ""
dent n
  | n > 0 = i : dent (pred n)
  | n < 0 = d : dent (succ n)
  where
  i = '\xF32A'
  d = '\xF32B'

format :: (Int, String) -> String
format (0, s) = s
format (n, s) = dent n ++ s
