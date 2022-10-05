import std/strutils

import prologue

let settings = newSettings(appName = "app",
    debug = true,
    port = Port(9090),
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