import algorithm, nake, os, strutils

const
  fragBin = "lib/frag"
  exDir = "examples"
  exBin = "main"

proc compile(bin: string) = direShell(nimExe, "c", bin)
proc run(bin: string) = direShell(nimExe, "c", "-r", bin)
proc runExample(name: string) = run(join(@[ exDir, name, exBin ], "/"))

proc registerExample(path: string) =
  var parts = path.split('-')
  let id = parts[0]
  parts.delete(0)
  task id, "run example " & parts.join("-"):
    runExample(path)

var examples: seq[string] = @[]
for kind, path in walkDir("examples", true):
  if path.contains("assets"): continue
  examples.add(path)
sort(examples, cmp[string])

for path in examples:
  registerExample(path)
