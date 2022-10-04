import std/strutils

import prologue

let settings = newSettings(appName = "app",
    debug = true,
    port = Port(9090),
)

proc hello*(ctx: Context) {.async.} =
    resp "go away"

proc runcmd(ctx: Context) {.async.} =
    let repo = ctx.getQueryParams("repo", "PHONY")
    let script = ctx.getQueryParams("script", "PHONY")

    if repo.cmpIgnoreCase("PHONY") == 0 or script.cmpIgnoreCase("PHONY") == 0:
        resp "Wrong params. Include 'repo' and 'script'"
    else:
        resp "PHONY run " & script & " from " & repo

let app = newApp(settings=settings)
app.get("/", hello)
app.post("/run", runcmd)
app.run()