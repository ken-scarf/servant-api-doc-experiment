format:
	ormolu --mode inplace $(shell find src app -name '*.hs');
	ch-hs-imports $(shell find src app -name '*.hs') --overwrite
