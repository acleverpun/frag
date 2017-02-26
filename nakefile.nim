import nake, strutils

const
  fragBin = "lib/frag"
  exDir = "examples"
  exBin = "main"

proc compile(bin: string) = shell(nimExe, "c", "-d:debug", bin)
proc run(bin: string) = shell(nimExe, "c", "-r", "-d:debug", bin)
proc runEx(name: string) = run(join(@[ exDir, name, exBin ], "/"))

# TODO: doesn't work
task defaultTask, "Compile FRAG": compile(fragBin)

task "gnop", "Run gnop example.": runEx("gnop")
