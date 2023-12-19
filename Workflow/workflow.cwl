cwlVersion: v1.2
class: Workflow
id: python_workflow
label: python_workflow

requirements:
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  - id: add-script
    type: File
    default:
      class: File
      location: ./addition.py
  - id: multiply-script
    type: File
    default:
      class: File
      location: ./multiplication.py
  - id: add-args
    type: string[]
    default:
      - '0'
  - id: multiply-args
    type: string[]
    default:
      - '1'

outputs:
  - id: output_txt
    type: File
    outputSource: display_results/output_file
  - id: version_txt
    type: File
    outputSource: version/output_file

steps:
  - id: version
    run: version.cwl
    in: []
    out: [output_file]
  - id: sum
    run: python.cwl
    in:
      script: add-script
      args: add-args
    out: [out]
  - id: product
    run: python.cwl
    in:
      script: multiply-script
      args: multiply-args
    out: [out]
  - id: multiply
    run: python.cwl
    in:
      script: multiply-script
      args:
        source: [sum/out,
                 product/out]
    out: [out]
  - id: display_results
    run: echo.cwl
    in:
      message: 
        source: multiply/out
    out: [output_file]
