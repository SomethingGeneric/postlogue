PHONY: do

build:
	nim c -o:bin/debug/postlogue app.nim

build-release:
	nim c -o:bin/release/postlogue -d:release app.nim

setup:
	nim c setup.nim
	./setup
	rm setup

dist-bundle: build-release
	nim c setup.nim
	./setup -ni
	mkdir dist
	cp bin/release/postlogue dist/.
	cp settings.yaml dist/.
	cp setup dist/.
	cp docs/BUNDLE.md dist/REDME.md
	cp docs/autodeploy-systemd.sh dist/deploy.sh
	chmod +x dist/deploy.sh
	tar -cvf postlogue.tgz dist/*
	rm -rf dist
	rm setup

do: build
	./bin/debug/postlogue