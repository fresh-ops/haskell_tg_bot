{-# LANGUAGE OverloadedStrings #-}

module GetUpdates
  ( getUpdates,
  )
where

import Control.Lens
import Data.Aeson (decode)
import Data.Text (pack)
import Network.Wreq
import ApiModels

getUpdates :: String -> Int -> IO (Maybe [Update])
getUpdates token offset = do
  let url = makeUrl token
  let params = makeParams offset
  response <- getWith params url
  let body = response ^. responseBody
  case decode body of
    Just (TelegramResponse True updates) -> return (Just updates)
    _ -> return Nothing


makeUrl :: String -> String
makeUrl token = "https://api.telegram.org/bot" ++ token ++ "/getUpdates"

makeParams :: Int -> Options
makeParams offset = 
  defaults
    & param "offset" .~ [pack (show offset)]
