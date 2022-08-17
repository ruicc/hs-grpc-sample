{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedRecordDot #-}
module Main where

import Proto.Greet (Greet(..), greetClient, HelloReq(..), HelloRes(..))
import "grpc-haskell" Network.GRPC.HighLevel.Generated
  ( GRPCMethodType(Normal)
  , defaultServiceOptions
  , ClientRequest(ClientNormalRequest)
  , ClientResult(ClientNormalResponse, ClientErrorResponse)
  , StatusCode(..)
  , Host(..)
  , withGRPCClient
  , ClientConfig(..)
  )

main :: IO ()
main = do
  let conf = ClientConfig
        { clientServerHost = Host "127.0.0.1"
        , clientServerPort = 50051
        , clientArgs = mempty
        , clientSSLConfig = Nothing
        , clientAuthority = Nothing
        }
  withGRPCClient conf $ \client -> do
    greetSrv <- greetClient client
    let request = HelloReq "ruicc"
    let timeout = 1
    helloRes <- greetSrv.greethello $ ClientNormalRequest request timeout mempty
    case helloRes of
      ClientNormalResponse res _ _ _ _ -> print res
      ClientErrorResponse er -> print er

