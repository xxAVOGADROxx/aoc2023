module Day1 where

import Data.Char (isDigit)
import Data.Maybe (mapMaybe)

------------------------- MAIN STRUCTURE -------------------------
main :: IO ()
main = interact $ \input ->
    let linesInput = lines input
        result1 = partOne linesInput
        result2 = partTwo linesInput
     in unlines ["Result 1: " ++ show result1, "Result 2: " ++ show result2]

partOne :: [String] -> Integer
partOne allLines = sum $ getNumberInTextLine <$> allLines
  where
    getNumberInTextLine :: String -> Integer
    getNumberInTextLine line =
        let firstNum = getFirstNumber line
            lastNum = getFirstNumber (reverse line)
         in read (firstNum <> lastNum)

    getFirstNumber :: String -> String
    getFirstNumber [] = error "The string doesn't contain any digit"
    getFirstNumber (x : xs)
        | isDigit x = [x]
        | otherwise = getFirstNumber xs

--------------------------- SECOND PART ---------------------------

partTwo :: [String] -> Integer
partTwo xs = sum $ readConcatenated . parseNumbers <$> xs
  where
    readConcatenated :: [String] -> Integer
    readConcatenated ns = read (head ns <> last ns)

parseNumbers :: String -> [String]
parseNumbers [] = []
parseNumbers str@(x : rest)
    | isDigit x = [x] : parseNumbers rest
    | otherwise =
        -- concatMap ( maybeToList . flip getNumber str) [3 .. 5]
        mapMaybe (`getNumber` str) [3 .. 5]
            ++ parseNumbers rest
  where
    getNumber :: Int -> String -> Maybe String
    getNumber a ys = wordToNumber (take a ys)

    wordToNumber :: String -> Maybe String
    wordToNumber word = case word of
        "one" -> Just "1"
        "two" -> Just "2"
        "three" -> Just "3"
        "four" -> Just "4"
        "five" -> Just "5"
        "six" -> Just "6"
        "seven" -> Just "7"
        "eight" -> Just "8"
        "nine" -> Just "9"
        "zero" -> Just "0"
        _ -> Nothing

------------------------------ NOTES ------------------------------
-- import Text.Read (reads)

-- parseInteger :: String -> Maybe Integer
-- parseInteger str = case reads str of
--     [(n, "")] -> Just n   -- Si toda la cadena se convierte en un número
--     _         -> Nothing  -- En cualquier otro caso (incluyendo el fallo)

-- main :: IO ()
-- main = do
--     print $ parseInteger "123"   -- Imprime: Just 123
--     print $ parseInteger "abc"   -- Imprime: Nothing
--     print $ parseInteger "123abc" -- Imprime: Nothing
