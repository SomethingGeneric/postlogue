import std/strutils
import os

import prologue
import yaml/serialization, streams

type Settings = object
    port : int
    debug : bool

let cmdArgs = os.commandLineParams()

var configPath = "settings.yaml"
if cmdArgs.len() > 0 and cmdArgs[0] == "-c":
    configPath = cmdArgs[1]

echo "Config path is: ", configPath

var settingsFile = newFileStream(configPath)
var customSettings = Settings()
load(settingsFile, customSettings)
settingsFile.close()

let settings = newSettings(appName = "Postlogue",
    debug = customSettings.debug,
    port = Port(customSettings.port),
)

proc hello*(ctx: Context) {.async.} =
    resp "go away"

proc runcmd(ctx: Context) {.async.} =
    let request = ctx.request
    echo "Got: ", request.body
    resp "Got: " & request.body

let app = newApp(settings=settings)
app.get("/", hello)
app.post("/run", runcmd)
app.run()