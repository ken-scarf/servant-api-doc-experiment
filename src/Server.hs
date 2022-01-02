{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Server where

-- openapi3

-- openapi3

-- openapi3

-- openapi3

-- openapi3

-- openapi3

-- openapi3
import Data.OpenApi (OpenApi)

-- servant-api-doc
import App (App (..))
import Capability.Address (ManageAddress (..))
import Capability.User (ManageUser (..))
import Entity.Address (Address)
import Entity.User (User, UserId)
import Import

-- servant-openapi3
import Servant.OpenApi (toOpenApi)

-- servant-server
import Servant
  ( Application,
    Capture,
    Get,
    Handler (..),
    JSON,
    Server,
    ServerT,
    hoistServer,
    serve,
    (:<|>) ((:<|>)),
    (:>),
  )

-- servant-swagger-ui
import Servant.Swagger.UI (SwaggerSchemaUI, swaggerSchemaUIServerT)

type UserAPI = "users" :> Get '[JSON] [User]

type AddressAPI =
  "addresses"
    :> ( Get '[JSON] [Address]
           :<|> Capture "userId" UserId :> Get '[JSON] (Maybe Address)
       )

type API = UserAPI :<|> AddressAPI

type ApiWithDoc = SwaggerSchemaUI "api-doc" "swagger.json" :<|> API

userServerT :: ManageUser m => ServerT UserAPI m
userServerT = getUsers

addressServerT :: ManageAddress m => ServerT AddressAPI m
addressServerT = getAllAddress :<|> getAddressByUserId

apiServerT :: (ManageUser m, ManageAddress m) => ServerT API m
apiServerT = userServerT :<|> addressServerT

apiWithDocServerT :: (ManageUser m, ManageAddress m) => ServerT ApiWithDoc m
apiWithDocServerT = swaggerSchemaUIServerT apiSwagger :<|> apiServerT

api :: Proxy API
api = Proxy

apiWithDoc :: Proxy ApiWithDoc
apiWithDoc = Proxy

apiSwagger :: OpenApi
apiSwagger = toOpenApi api

apiServer :: Server ApiWithDoc
apiServer = hoistServer apiWithDoc toHandler apiWithDocServerT
  where
    toHandler :: App a -> Handler a
    toHandler a = Handler $ runApp a

app :: Application
app = serve apiWithDoc apiServer
