import yaml/serialization, streams
import strutils, typetraits
import os

type Settings = object
    port : int
    debug : bool

var customPort = 0
var doDebug = false

let cmdArgs = os.commandLineParams()
if cmdArgs.len() > 0 and cmdArgs[0] == "-ni":
    customPort = 9090
    doDebug = true
else:
    stdout.write "Port number: "
    customPort = stdin.readline.parseInt

    stdout.write "Debug (Y/n): "
    let debugToggle = stdin.readline

    doDebug = false

    if debugToggle != "n":
        doDebug = true

let ourSettings = Settings(port:customPort, debug:doDebug)

var settingsFile = newFileStream("settings.yaml", fmWrite)
dump(ourSettings, settingsFile)
settingsFile.close()