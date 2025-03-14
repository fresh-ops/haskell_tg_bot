{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use newtype instead of data" #-}

module JikanModels
  ( AnimeImages (..),
    AnimeData (..),
    ImageURL (..),
    JikanSingleResponse (..),
    JikanMultiResponse (..),
  )
where

import Data.Aeson (FromJSON, parseJSON, withObject, (.:))
import Data.Text (Text)
import GHC.Generics

data AnimeImages = AnimeImages
  { jpg :: ImageURL
  }
  deriving (Show, Generic)

data ImageURL = ImageURL
  { image_url :: Text
  }
  deriving (Show, Generic)

data AnimeData = AnimeData
  { mal_id :: Int,
    url :: Text,
    images :: AnimeImages,
    title :: Text,
    title_english :: Maybe Text,
    title_japanese :: Maybe Text,
    episodes :: Maybe Int,
    status :: Text,
    score :: Maybe Double,
    synopsis :: Maybe Text
  }
  deriving (Show, Generic)

data JikanSingleResponse = JikanSingleResponse
  { anime :: AnimeData
  }
  deriving (Show, Generic)

data JikanMultiResponse = JikanMultiResponse
  { animes :: [AnimeData]
  }
  deriving (Show, Generic)

instance FromJSON JikanSingleResponse where
  parseJSON = withObject "JikanSingleResponse" $ \v ->
    JikanSingleResponse
      <$> v .: "data"

instance FromJSON JikanMultiResponse where
  parseJSON = withObject "JikanMultiResponse" $ \v ->
    JikanMultiResponse
      <$> v .: "data"

instance FromJSON AnimeData

instance FromJSON AnimeImages

instance FromJSON ImageURL