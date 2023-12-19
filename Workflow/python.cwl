cwlVersion: v1.2
class: CommandLineTool

baseCommand: python3

stdout: output-py.txt

inputs:
  - id: script
    type: File
    inputBinding:
      position: 0
  - id: args
    type: string[]?
    inputBinding:
      position: 1

outputs:
  - id: out
    type: string
    outputBinding:
      glob: output-py.txt
      loadContents: true
      outputEval: $(self[0].contents)
