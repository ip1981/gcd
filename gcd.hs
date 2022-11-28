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

gcd2 :: Integral a => a -> a -> a
gcd2 a 0 = a
gcd2 a b = gcd2 b (a `rem` b)

gcdn :: Integral a => [a] -> a
gcdn = foldl1 gcd2

out :: [String] -> IO ()
out [] = return ()
out a = print (gcdn (map read a) :: Integer)

main :: IO ()
main = getArgs >>= out
