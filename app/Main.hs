{-# LANGUAGE OverloadedStrings #-}

module Main where

-- relude
import Relude

-- servant-api-doc
import Server

-- warp
import Network.Wai.Handler.Warp (run)

main :: IO ()
main = do
  let port = 8080
  putStrLn $ "Starting server on port " <> show port <> "..."
  run port app
