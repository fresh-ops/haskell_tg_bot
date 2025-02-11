{-# LANGUAGE DeriveGeneric #-}

module ApiModels
  ( TelegramResponse (..),
    Update (..),
    Message (..),
    Chat (..),
  )
where

import Data.Aeson (FromJSON)
import Data.Text (Text)
import GHC.Generics (Generic)

data TelegramResponse = TelegramResponse
  { ok :: Bool,
    result :: [Update]
  }
  deriving (Show, Generic)

data Update = Update
  { updateId :: Int,
    message :: Maybe Message
  }
  deriving (Show, Generic)

data Message = Message
  { messageId :: Int,
    chat :: Chat,
    text :: Maybe Text
  }
  deriving (Show, Generic)

data Chat = Chat
  { chatId :: Int
  }
  deriving (Show, Generic)

instance FromJSON TelegramResponse

instance FromJSON Update

instance FromJSON Message

instance FromJSON Chat