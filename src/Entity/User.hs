{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

module Entity.User where

-- aeson
import Data.Aeson
  ( FromJSON (..),
    ToJSON (..),
    Options(fieldLabelModifier),
    defaultOptions,
    genericParseJSON,
    genericToJSON,
  )

-- lens
import Control.Lens

-- openapi3
import Data.OpenApi
  ( HasRequired (..),
    HasType (..),
    NamedSchema (..),
    OpenApiType (..),
    ToSchema (..),
    declareSchemaRef,
  )
import Data.OpenApi.Lens (HasProperties (..))

-- servant-api-doc
import Common
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
  toJSON =
    genericToJSON
      defaultOptions
        { fieldLabelModifier = labelModifier "User"
        }

instance FromJSON User where
  parseJSON =
    genericParseJSON
      defaultOptions
        { fieldLabelModifier = labelModifier "User"
        }

instance ToSchema User where
  declareNamedSchema _ = do
    uId <- declareSchemaRef @UserId Proxy
    uName <- declareSchemaRef @Text Proxy
    uEmail <- declareSchemaRef @Text Proxy
    pure $
      NamedSchema (Just "User") $
        mempty
          & type_ ?~ OpenApiObject
          & properties
            .~ [ ("id", uId),
                 ("name", uName),
                 ("email", uEmail)
               ]
          & required .~ ["id", "name", "email"]
