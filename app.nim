import std/strutils
import std/json
import os

import prologue
import yaml/serialization, streams

type Settings = object
    port : int
    debug : bool
    flowsDir : string

type Repository = object
    name : string

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

let flowDir = customSettings.flowsDir

proc hello(ctx: Context) {.async.} =
    resp "go away"

proc dumpreq(ctx: Context) {.async.} =
    let request = ctx.request
    echo "Got: ", request.body
    resp "Got: " & request.body

proc runcmd(ctx: Context) {.async.} =
    let request = ctx.request
    let jsonNode = parseJson(request.body)

    let gitref = jsonNode{"ref"}.getStr()

    if gitref != "":
        echo "Thinking this is a commit"
        let gitRepoInfo = jsonNode{"repository"}.getStr()
        if gitRepoInfo != "":
            let repoObj = to(parseJson(gitRepoInfo), Repository)
            let repoName = repoObj.name
            if fileExists(flowDir & "/" & repoName):
                echo "Found workflow for " & repoName
                resp "Found workflow"
            else:
                resp "Foo"
        else:
            echo "Somehow this ref doesn't have a 'repository' key"
            resp "Didn't get typical info for a commit hook"
    else:
        echo "Ignoring a POST"
        resp "Unknown, discarding."


let app = newApp(settings=settings)
app.get("/", hello)

app.post("/run", runcmd)
app.post("/debug", dumpreq)


app.run()