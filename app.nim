import std/strutils

import prologue

proc hello*(ctx: Context) {.async.} =
    resp "go away"

proc runcmd(ctx: Context) {.async.} =
    let repo = ctx.getQueryParams("repo", "PHONY")
    let script = ctx.getQueryParams("script", "PHONY")

    if repo.cmpIgnoreCase("PHONY") == 0 or script.cmpIgnoreCase("PHONY") == 0:
        resp "Wrong params. Include 'repo' and 'script'"
    else:
        resp "PHONY run " & script & " from " & repo

let app = newApp()
app.get("/", hello)
app.get("/run", runcmd)
app.run()