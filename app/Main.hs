{-# LANGUAGE OverloadedStrings #-}

module Main where

-- relude

-- servant-api-doc

-- relude

-- servant-api-doc

-- relude

-- servant-api-doc

-- relude

-- servant-api-doc

-- relude

-- servant-api-doc

-- relude

-- servant-api-doc

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
