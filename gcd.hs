{-

Usage:

  $ runhaskell gcd.hs 22 11
  11

or:

  $ ghc gcd.hs -o gcd-hs
  $ ./gcd-hs 11 22 121
  11

-}
import System.Environment (getArgs)

gcd2 :: Integer -> Integer -> Integer
gcd2 a 0 = a
gcd2 a b = gcd2 b (a `rem` b)

gcdn :: [Integer] -> Integer
gcdn = foldl1 gcd2

str2int :: String -> Integer
str2int = read

main :: IO ()
main = do
  a <- getArgs
  print $ gcdn (map str2int a)
