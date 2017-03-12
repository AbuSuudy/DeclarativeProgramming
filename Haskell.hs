import Test.QuickCheck
import Data.Char


-- Justin Chew, 829486 --
-- David Plumb 741594 --
-- Abubakar Suudy 837867 --



-- Question 1a --

averageThree :: Float -> Float -> Float -> Float
--Takes  3 numeric values that can be decimal or integer and produces a value 
averageThree x y z = (x + y + z)/3.0
--Function takes 3 values adds them all together and then divides them

isAbove :: Float -> Float -> Int
isAbove a avg
 | a > avg = 1
 | otherwise = 0

howManyAboveAverage1 :: Float -> Float -> Float -> Int
--Takes in three floats and produces an Int
howManyAboveAverage1 x y z = (isAbove x avg) + (isAbove y avg) + (isAbove z avg)
-- isAbove function is called for x,y,z input along with avg 
-- if the input is above avg it would return 1 if not 0 and sum them together
  where avg = averageThree x y z
-- states avg is equal to average of three inputs to howManyAboveAverage1

   
   
howManyAboveAverage2 :: Float -> Float -> Float -> Int
--Takes in three floats and produces an Int  
howManyAboveAverage2 x y z = length [ i | i <- [x, y, z],  i > avg]
--creates a list where it's input is x,y,z where each element is above avg
  where avg = averageThree x y z
-- states avg is equal to average of three inputs to howManyAboveAverage2

-- Result to average student number: 802982.3
-- How many are above average: 2
 
-- Question 2 --

p :: (Num a, Ord a) => a -> Bool
--Takes an Integer produes a Boolean
p x 
 | x < 7 = True
 | otherwise = False
--Guarded expression to check the conditions of the integer x to outcome a Boolean statement 
 
 
listCompSplit :: (a -> Bool) -> [a] -> ([a],[a])
-- Takes the function p and a list [a] to produce a tuple of two lists
listCompSplit f xs = ([x | x <- xs, f x == True], [y | y <- xs, f y == False])
--Uses a list comprehension where f is the function of p and xs is the list [a]
--This computes two list, one where the function p is True and the other where function p is false

hOrderSplit :: (a -> Bool) -> [a] -> ([a],[a])
hOrderSplit f xs = (filter f xs, filter (\x -> f x == False) xs)
--Filters the list to separate them into two list using the condition of function p

recSplit :: (a -> Bool) -> [a] -> ([a],[a])
recSplit f [] = ([],[])
--function maps the empty list to tuples of two lists
recSplit f [x] = ([x],[])
recSplit f (x:y:xys) = (x:xs, y:ys)
--Takes the list of [a] and splits into tuples of two lists  
 where (xs, ys) = recSplit f xys
--Defines the loop of the condition in function p
   

-- Question 3 --

area :: Double -> Double
area x = ((0.5 * x)  * (0.5 * x)) * pi 
--"function to determine area of a circle, from the imputed diameter

pizza  :: Double -> Double -> Double
pizza x y = ((0.001 * area x) + (y * 0.002 * area x)) * 1.6
-- x is the diameter of pizza
-- y is the number of toppings 
-- the first part of the function calculates the cost of the pizza base
-- the second part calculates the cost of the toppings
-- the entire sum is then multiplied by 1.6 as requested

pizza' = if pizza 14 6 > pizza 32 2 then printBambini
 else printFamiglia
-- function to determine which pizza costs more
-- "Pizza Famiglia costs more"
 
 
printBambini :: IO ()
printBambini = putStrLn "Pizza Bambini costs more"

printFamiglia :: IO ()
printFamiglia = putStrLn "Pizza Famiglia costs more"

--Output comment: Pizza Famiglia costs more

-- Question 4 -- 

divides :: Integer -> Integer -> Bool
divides x y = y `mod` x == 0

prime :: Integer -> Bool
prime n = n > 1 &&  and [not(divides x n) | x <- [2..(n-1)]]

allprimes :: [Integer]
allprimes = [x | x<- [2..], prime x]

allprimesBetween :: Integer -> Integer -> [Integer]
allprimesBetween x y = [xs | xs <- [x..y], prime xs]
-- sets two bounds to make a list xs that has prime numbers only

primeTwins :: Integer -> Int
primeTwins n = length [(x,y)| x <- (allprimesBetween 0 n), prime x, y <- (allprimesBetween 0 n), x + 2 == y]
--Get the sets of the prime twin list by comparing with the function x + 2 == y
--Count how many there are in the list within 0 to n









