cwlVersion: v1.2
class: CommandLineTool

baseCommand: [cat, /etc/os-release]

stdout: z_version.txt

inputs: []

outputs:
  output_file:
    type: File
    outputBinding:
      glob: z_version.txt
