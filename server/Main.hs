{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedRecordDot #-}
module Main where

import Proto.Greet (Greet(..), greetServer, HelloReq(..), HelloRes(..))
import "grpc-haskell" Network.GRPC.HighLevel
import "bytestring" Data.ByteString qualified as B
import "text" Data.Text qualified as T
import "time" Data.Time qualified as Time
import "grpc-haskell" Network.GRPC.HighLevel.Generated
  ( GRPCMethodType(Normal)
  , defaultServiceOptions
  , ServerRequest(ServerNormalRequest)
  , ServerResponse(ServerNormalResponse)
  , StatusCode(..)
  , Host(..)
  )

helloHandler :: ServerRequest 'Normal HelloReq HelloRes -> IO (ServerResponse 'Normal HelloRes)
helloHandler (ServerNormalRequest _ req) = do
  time <- Time.getCurrentTime
  putStrLn $ show time <> ": a request is received"
  let response = HelloRes $ "Hello, " <> req.helloReqName <> "!"
  pure $ ServerNormalResponse response mempty StatusOk "OK"

main :: IO ()
main = do
  let opts = defaultServiceOptions
        { serverHost = Host "127.0.0.1"
        , serverPort = 50051
        }
  putStrLn "Launching server.."
  greetServer (Greet helloHandler) opts
