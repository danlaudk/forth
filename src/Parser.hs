module Parser where

import           Text.ParserCombinators.Parsec
import           Text.ParserCombinators.Parsec.Number (int)
import           Types

-- Parsers
exprs :: Parser [Val]
exprs = many1 expr

expr :: Parser Val
expr = do
  spaces
  e <- word <|> number <|> quotation
  spaces
  return e

number :: Parser Val
number = Number <$> int

word :: Parser Val
word = do
  w <- many1 (oneOf ".+-/*:;!@#$%^&*<>=" <|> letter)
  return $ Symbol w

quotation :: Parser Val
quotation = do
  char '['
  es <- exprs
  char ']'
  return $ makeWord es



-- API
parseLine =
  parse exprs "forth"

parseFile path =
  parseLine <$> readFile path
