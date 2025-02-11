{-# LANGUAGE OverloadedStrings #-}

module SendMessage
  ( sendMessage,
  )
where

import Control.Lens
import Data.Text (Text, pack)
import Network.Wreq

sendMessage :: String -> Int -> Text -> IO (Status)
sendMessage token chatId text = do
  let url = makeUrl token
  let params = makeParams chatId text
  response <- getWith params url
  return (response ^. responseStatus)

makeUrl :: String -> String
makeUrl token = "https://api.telegram.org/bot" ++ token ++ "/sendMessage"

makeParams :: Int -> Text -> Options
makeParams chatId text =
  defaults
    & param "chat_id" .~ [pack (show chatId)]
    & param "text" .~ [text]
