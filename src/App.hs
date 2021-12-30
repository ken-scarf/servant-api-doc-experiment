{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE ScopedTypeVariables #-}

module App where

-- servant-api-doc
import Capability.Address
import Capability.User
import Entity.Address
import Entity.User
import Entity.UserAddress
import Import

-- servant-server
import Servant

newtype App a = App
  { runApp :: ExceptT ServerError IO a
  }
  deriving (Functor, Applicative, Monad, MonadIO)

instance ManageUser App where
  getUsers = pure usersDb

instance ManageAddress App where
  getAllAddress = pure addressesDb
  getAddressByUserId userId = do
    let mUserAddress =
          listToMaybe $
            filter (\UserAddress {userAddressUserId} -> userId == userAddressUserId) $
              userAddressDb

    case mUserAddress of
      Nothing -> pure Nothing
      Just UserAddress {userAddressAddressId} ->
        pure $
          listToMaybe $
            filter
              (\Address {addressId} -> addressId == userAddressAddressId)
              addressesDb
