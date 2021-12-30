module Capability.User where

-- servant-api-doc
import Entity.User
import Import

class Monad m => ManageUser m where
  getUsers :: m [User]
