{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Entity.User where

-- aeson
import Data.Aeson
  ( FromJSON (..),
    ToJSON (..),
    defaultOptions,
    genericParseJSON,
    genericToJSON,
  )

-- openapi3
import Data.OpenApi
  ( ToSchema (..),
    defaultSchemaOptions,
    genericDeclareNamedSchema,
  )

-- servant-api-doc
import Import

type UserId = Int

data User = User
  { userId :: UserId,
    userName :: Text,
    userEmail :: Text
  }
  deriving (Generic)

usersDb :: [User]
usersDb =
  [ User 1 "user1" "user1@email.com",
    User 2 "user2" "user2@email.com"
  ]

instance ToJSON User where
  toJSON = genericToJSON defaultOptions

instance FromJSON User where
  parseJSON = genericParseJSON defaultOptions

instance ToSchema User where
  declareNamedSchema proxy = genericDeclareNamedSchema defaultSchemaOptions proxy
