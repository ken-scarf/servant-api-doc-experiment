{ mkDerivation, aeson, aeson-pretty, base, lens, lib, openapi3
, relude, servant, servant-openapi3, servant-server
, servant-swagger-ui, text, wai, warp
}:
mkDerivation {
  pname = "servant-api-doc";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson aeson-pretty base lens openapi3 relude servant
    servant-openapi3 servant-server servant-swagger-ui text
  ];
  executableHaskellDepends = [ base relude wai warp ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}
