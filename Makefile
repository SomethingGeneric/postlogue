PHONY: do

build:
	nim c -o:postlogue app.nim

do: build
	./postlogue