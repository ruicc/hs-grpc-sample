make:

clean:
	cabal v2-clean
	rm bin/{server,client}

.PHONY: server
server:
	@make bin/server
	bin/server

.PHONY: client
client:
	@make bin/client
	bin/client

bin/server:
	@make cabal.build component=grpc-sample:exe:server
bin/client:
	@make cabal.build component=grpc-sample:exe:server
cabal.build:
	cabal v2-build $(component) -O0
	cabal v2-install $(component) --installdir=bin --overwrite-policy=always

proto.gen:
	cabal v2-run compile-proto-file -- --proto proto/greet.proto --out gen --string-type Data.Text.Text
proto.clean:
	rm -rf gen

ghcid:
	ghcid \
		-c "cabal v2-repl -O0 $(component)" \
		--no-height-limit \
		--reverse-errors \
		--clear \
		--restart=grpc-sample.cabal \
		--restart=cabal.project \
		--restart=cabal.project.local \
		--restart=cabal.project.freeze
ghcid.server:
	@make ghcid component=server
ghcid.client:
	@make ghcid component=client
