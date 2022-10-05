import yaml/serialization, streams
import strutils, typetraits
import os

type Settings = object
    port : int
    debug : bool
    flowsDir : string

var customPort = 0
var doDebug = false
var flowDir = ""

let cmdArgs = os.commandLineParams()
if cmdArgs.len() > 0 and cmdArgs[0] == "-ni":
    customPort = 9090
    doDebug = true
    flowDir = "/etc/postlogue/flows"
else:
    stdout.write "Port number: "
    customPort = stdin.readline.parseInt

    stdout.write "Debug (Y/n): "
    let debugToggle = stdin.readline

    doDebug = false

    if debugToggle != "n":
        doDebug = true

    stdout.write "Flows dir: "
    flowDir = stdin.readline

let ourSettings = Settings(port:customPort, debug:doDebug, flowsDir:flowDir)

var settingsFile = newFileStream("settings.yaml", fmWrite)
dump(ourSettings, settingsFile)
settingsFile.close()