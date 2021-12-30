module Entity.UserAddress where

-- servant-api-doc
import Entity.Address
import Entity.User

data UserAddress = UserAddress
  { userAddressUserId :: UserId,
    userAddressAddressId :: AddressId
  }

userAddressDb :: [UserAddress]
userAddressDb =
  [ UserAddress 1 1,
    UserAddress 2 1
  ]
