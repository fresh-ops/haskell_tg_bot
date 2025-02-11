{-# LANGUAGE OverloadedStrings #-}
module ApiModels
  ( TelegramResponse (..),
    Update (..),
    Message (..),
    Chat (..),
  )
where

import Data.Aeson (FromJSON, parseJSON, withObject, (.:))
import Data.Text (Text)

data TelegramResponse = TelegramResponse
  { ok :: Bool,
    result :: [Update]
  }
  deriving (Show)

data Update = Update
  { updateId :: Int,
    message :: Maybe Message
  }
  deriving (Show)

data Message = Message
  { messageId :: Int,
    chat :: Chat,
    text :: Maybe Text
  }
  deriving (Show)

newtype Chat = Chat {chatId :: Int} deriving (Show)

-- Экземпляры FromJSON для парсинга JSON
instance FromJSON TelegramResponse where
  parseJSON = withObject "TelegramResponse" $ \v ->
    TelegramResponse
      <$> v .: "ok"
      <*> v .: "result"

instance FromJSON Update where
  parseJSON = withObject "Update" $ \v ->
    Update
      <$> v .: "update_id"
      <*> v .: "message"

instance FromJSON Message where
  parseJSON = withObject "Message" $ \v ->
    Message
      <$> v .: "message_id"
      <*> v .: "chat"
      <*> v .: "text"

instance FromJSON Chat where
  parseJSON = withObject "Chat" $ \v ->
    Chat
      <$> v .: "id"