PHONY: do

build:
	nim c -o:bin/debug/postlogue app.nim

build-release:
	nim c -o:bin/release/postlogue -d:release app.nim

do: build
	./bin/debug/postlogue