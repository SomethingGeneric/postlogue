PHONY: do

build:
	nim c -o:bin/debug/postlogue app.nim

build-release:
	nim c -o:bin/release/postlogue -d:release app.nim

setup:
	nim c setup.nim
	./setup
	rm setup

do: build
	./bin/debug/postlogue