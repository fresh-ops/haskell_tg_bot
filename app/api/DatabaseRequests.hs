{-# LANGUAGE OverloadedStrings #-}

module DatabaseRequests where

import Control.Lens
import Data.Aeson (decode)
import Data.Text (Text)
import JikanModels
import Network.Wreq

getAnimeById :: String -> Int -> IO (Maybe JikanSingleResponse)
getAnimeById db id = do
  let url = db ++ "/" ++ show id
  response <- get url
  let body = response ^. responseBody
  return $ decode body

getAnime :: String -> Text -> IO (Maybe JikanMultiResponse)
getAnime db query = do
  let params = defaults & param "q" .~ [query]
  response <- getWith params db
  let body = response ^. responseBody
  return $ decode body
