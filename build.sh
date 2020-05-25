#!/bin/bash

set -e

scriptdir="$( cd "$( dirname "$0" )" && pwd )"
imagename="myproject"

# Check if some container is running. If yes, then kill
runningcontainer=$(docker ps -q)
for a in ${runningcontainer} ; do
   docker kill "${a}" || errorOccurred
done

# Build the docker file
docker build -t "${imagename}:latest" "${scriptdir}" || errorOccurred

# Run the image on port 8001
docker run -itd -p 8001:80 "${imagename}:latest" || errorOccurred

#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ function to report errors and exit ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
function errorOccurred
{
    errorlevel=$?
    echo "Packaging failed with error $errorlevel ---------------------------------"
    exit $errorlevel
}

