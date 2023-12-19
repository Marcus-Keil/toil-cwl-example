# toil-cwl-example
This repository serves to aid in figuring out issues on why toil-cwl-runner seems to ignore the singularity image we attempt to give it.

## Version to reproduce issue
Current versions of software and OS we are using.

+ Main OS: Ubuntu 22.04
+ Singularity Image OS: 20.04 (Intentionally different to test container usage)
+ Singularity Version: 3.9.2
+ toil Version: 5.12.0
+ CWLTool Version: 3.1.20230601100705
+ Python Version: 3.9.18

## Setting up

Set build singularity .sif file 
```
singularity build --fakeroot <imageName>.sif singularity.def
```
replace <imageName> with any preferred image name.

Change export.source file to reflect where singularity.sif is
```
export SINGULARITY_CACHEDIR=<PATH/TO/SINGULARITY.SIF/DIRECTORY>
```

export all these variables into current shell session
```
source exports.source
```

## Expected behaviour

With cwltool, the command to call the workflow in the expected way is

```
cwltool --singularity --default-container <imageName> workflow.cwl parameters.yaml
```
Here, "--default-container" is used by cwltool to run all cwl files not labled as workflows with the singularity runner due to the "--singularity" option. This results in the creation of two files, if nothing is change z_output.txt should have 'The result is 15120.0' printed in it, and z_version.txt should have:

```
NAME="Ubuntu"
VERSION="20.04.6 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.6 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
```

printed into it showing that it indeed used the singularity image that was configured.

When this is now used with toil-cwl-runner, we would expect the same behaviour, however, this is not the case. To recreate see what we mean, we run the comand:
```
toil-cwl-runner --jobStore <jobstoreName> --singularity --default-container <imageName> workflow.cwl parameters.yaml
```
where again, the "--singularity" and "--default-container" option are used, which toil-cwl-runner states are valid options. However, the results that are printed in the z_version.txt file represents the current operating system being used by the user. In our case "Ubuntu 22.04". 

