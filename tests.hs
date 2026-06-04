module Main where

import Data.Char (isAlphaNum)
import System.Exit (exitFailure, exitSuccess)



data FizzBuzzDetector = FizzBuzzDetector 
    { outputString :: String
    , coincidenceCount :: Int 
    } deriving (Show, Eq)

tokenize :: String -> [String]
tokenize [] = []
tokenize s@(c:_)
    | isAlphaNum c = 
        let (word, rest) = span (\x -> isAlphaNum x || x == '\'') s
        in word : tokenize rest
    | otherwise = 
        let (delim, rest) = span (not . isAlphaNum) s
        in delim : tokenize rest

getOverlappings :: String -> FizzBuzzDetector
getOverlappings input = FizzBuzzDetector (concat finalTokens) (sum counts)
  where
    tokens = tokenize input
    patterns = [ if i `mod` 15 == 0 then ("FizzBuzz", 1) 
                 else if i `mod` 3 == 0 then ("Fizz", 1) 
                 else if i `mod` 5 == 0 then ("Buzz", 1) 
                 else ("", 0) | i <- [1..] ]

    process [] _ = ([], [])
    process (t@(c:_):ts) ps@((repl, count):patternRest)
        | isAlphaNum c = 
            let (w, cnts) = process ts patternRest 
                actualWord = if null repl then t else repl
            in (actualWord : w, count : cnts)
        | otherwise = 
            let (w, cnts) = process ts ps 
            in (t : w, cnts)
    process ("":ts) ps = process ts ps

    (finalTokens, counts) = process tokens patterns



data TestCase = TestCase String String String Int

testCases :: [TestCase]
testCases =
    [ TestCase "TEST 1"
        "Mary had a little lamb Little lamb, little lamb Mary had a little lamb It's fleece was white as snow"
        "Mary had Fizz little Buzz Fizz lamb, little Fizz Buzz had Fizz little lamb FizzBuzz fleece was Fizz as Buzz" 9
    
    , TestCase "TEST 2"
        "Hi there" 
        "Hi there" 0
    
    , TestCase "TEST 3"
        "one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen"
        "one two Fizz four Buzz Fizz seven eight Fizz Buzz eleven Fizz thirteen fourteen FizzBuzz" 7
    
    , TestCase "TEST 4"
        "Hello, world! It's a beautiful day."
        "Hello, world! Fizz a Buzz Fizz." 3

    , TestCase "TEST 5"
        "Haskell"
        "Haskell" 0
    ]

runTests :: [TestCase] -> IO Bool
runTests ts = do
    results <- mapM runAndVerify (zip [1..] ts)
    return (and results)
  where
    runAndVerify (idx, TestCase name input expStr expCount) = do
        let res = getOverlappings input
        if outputString res == expStr && coincidenceCount res == expCount
            then putStrLn ("[PASS] " ++ name) >> return True
            else do
                putStrLn ("[FAIL] " ++ name)
                putStrLn ("Expected Str: " ++ show expStr)
                putStrLn ("Got Str:      " ++ show (outputString res))
                return False

main :: IO ()
main = do
    putStrLn "verification"
    success <- runTests testCases
    if success 
        then putStrLn "\nAll 5 verifications passed successfully!" >> exitSuccess
        else putStrLn "\nVerification failed." >> exitFailure
