import yaml/serialization, streams
import strutils, typetraits

type Settings = object
    port : int
    debug : bool

stdout.write "Port number: "
let customPort = stdin.readline.parseInt

stdout.write "Debug (Y/n): "
let debug_toggle = stdin.readline

var do_debug = false

if debug_toggle != "n":
    do_debug = true

let ourSettings = Settings(port:customPort, debug:do_debug)

var settingsFile = newFileStream("settings.yaml", fmWrite)
dump(ourSettings, settingsFile)
settingsFile.close()