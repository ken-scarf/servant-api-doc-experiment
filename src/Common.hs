{-# LANGUAGE TypeApplications #-}

module Common where

-- base
import qualified Data.Char as C

-- servant-api-doc
import Import

labelModifier :: String -> String -> String
labelModifier str = lowerFirstChar . drop (length @[] str)
  where
    lowerFirstChar :: String -> String
    lowerFirstChar [] = []
    lowerFirstChar (c : cs) = C.toLower c : cs
