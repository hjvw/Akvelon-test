module Main where

import Data.Char (isAlphaNum)
import System.IO (hFlush, stdout)


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

    
    process :: [String] -> [(String, Int)] -> ([String], [Int])
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

main :: IO ()
main = do
    putStrLn "FizzBuzz "
    putStr "Type your text and press Enter: "
    hFlush stdout 


    inputData <- getLine

    let result = getOverlappings inputData

    putStrLn "\nProcessed Result"
    putStrLn (outputString result)
    putStrLn "==================="
    putStr "Total Matches Found: "
    print (coincidenceCount result)
