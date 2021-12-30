module Capability.Address where

-- servant-api-doc
import Entity.Address
import Entity.User
import Import

class Monad m => ManageAddress m where
  getAllAddress :: m [Address]
  getAddressByUserId :: UserId -> m (Maybe Address)
