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
	cp docs/sample.service dist/.
	chmod +x dist/deploy.sh
	tar -cvf postlogue.tgz dist/*
	rm -rf dist
	rm setup

deploy-dist: dist-bundle
	ssh -t xhec.dev "[[ -f /etc/systemd/system/postlogue.service ]] && sudo systemctl disable --now postlogue.service && sudo rm /etc/systemd/system/postlogue.service"
	ssh xhec.dev "[[ -d dist ]] && rm -r dist"
	ssh xhec.dev "[[ -f postlogue.tgz ]] && rm postlogue.tgz"
	scp postlogue.tgz xhec.dev:.
	ssh xhec.dev "tar -xvf postlogue.tgz"
	ssh -t xhec.dev "cd dist && sudo ./deploy.sh"

do: build
	./bin/debug/postlogue