import System.Environment(getArgs)

gcd2 a 0 = a
gcd2 a b = gcd2 b (rem b a)

gcdn n = foldl1 gcd2 n

str2int :: String -> Integer
str2int = read

main = do
    a <- getArgs
    print (gcdn (map str2int a))

