{-# LANGUAGE OverloadedStrings #-}

module Config (AppConfig (..), readConfigFile) where

import Data.Aeson (FromJSON, ToJSON (..), decode, object, parseJSON, withObject, (.:), (.=))
import qualified Data.ByteString.Lazy as BL

data AppConfig = AppConfig
  { telegramApiToken :: String,
    databaseUrl :: String
  }
  deriving (Show)

instance FromJSON AppConfig where
  parseJSON = withObject "AppConfig" $ \v ->
    AppConfig
      <$> v .: "telegramApiToken"
      <*> v .: "databaseUrl"

instance ToJSON AppConfig where
  toJSON (AppConfig token url) =
    object
      [ "telegramApiToken" .= token,
        "databaseUrl" .= url
      ]

readConfigFile :: String -> IO AppConfig
readConfigFile path = do
  json <- BL.readFile path
  case decode json of
    Just (AppConfig token url) -> return $ AppConfig token url
    _ -> error "Could not parse config file"
