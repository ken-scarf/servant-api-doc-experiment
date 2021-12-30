{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Entity.Address where

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

type AddressId = Int

data Address = Address
  { addressId :: AddressId,
    addressStreet :: Text,
    addressCity :: Text,
    addressZipCode :: Text,
    addressCountry :: Text
  }
  deriving (Generic)

addressesDb :: [Address]
addressesDb =
  [ Address 1 "street1" "city1" "zipcode1" "country1"
  ]

instance ToJSON Address where
  toJSON = genericToJSON defaultOptions

instance FromJSON Address where
  parseJSON = genericParseJSON defaultOptions

instance ToSchema Address where
  declareNamedSchema proxy = genericDeclareNamedSchema defaultSchemaOptions proxy
