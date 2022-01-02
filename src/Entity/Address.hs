{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module Entity.Address where

-- aeson

-- lens

-- openapi3

-- aeson

-- lens

-- openapi3

-- aeson

-- lens

-- openapi3

-- aeson
import Data.Aeson
  ( FromJSON (..),
    Options (fieldLabelModifier),
    ToJSON (..),
    defaultOptions,
    genericParseJSON,
    genericToJSON,
  )

-- lens
import Control.Lens ((.~), (?~))

-- openapi3
import Data.OpenApi
  ( HasProperties (..),
    HasRequired (..),
    HasType (..),
    NamedSchema (..),
    OpenApiType (..),
    ToSchema (..),
    declareSchemaRef,
  )

-- servant-api-doc
import Common
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
  toJSON =
    genericToJSON
      defaultOptions
        { fieldLabelModifier = labelModifier "Address"
        }

instance FromJSON Address where
  parseJSON =
    genericParseJSON
      defaultOptions
        { fieldLabelModifier = labelModifier "Address"
        }

instance ToSchema Address where
  declareNamedSchema _ = do
    addrId <- declareSchemaRef @AddressId Proxy
    addrStreet <- declareSchemaRef @Text Proxy
    addrCity <- declareSchemaRef @Text Proxy
    addrZipCode <- declareSchemaRef @Text Proxy
    addrCountry <- declareSchemaRef @Text Proxy
    pure $
      NamedSchema (Just "Address") $
        mempty
          & type_ ?~ OpenApiObject
          & properties
            .~ [ ("id", addrId),
                 ("street", addrStreet),
                 ("city", addrCity),
                 ("zipCode", addrZipCode),
                 ("country", addrCountry)
               ]
          & required .~ ["id", "street", "city", "zipCode", "country"]
