cwlVersion: v1.2
class: CommandLineTool

baseCommand: [echo]
arguments: ['The result is']
stdout: z_output.txt

inputs:
  message:
    type: string
    inputBinding:
      position: 1

outputs:
  output_file:
    type: File
    outputBinding:
      glob: z_output.txt
    
