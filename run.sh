#!/usr/bin/sh
if [ "$1" == "start" ]; then
    echo "Starting server"
    docker run -d -p 8888:8888 -v $(pwd):/home/jovyan/work --name 
phenotypic_data_qc_notebook --platform linux/x86_64  phenotypic-data-qc
    echo "Getting link"
    sleep 1
    docker exec -it phenotypic_data_qc_notebook bash -c 'jupyter lab list' | grep http 
| cut -f1 -d ' ' | sed 's/\/\/.*:8888/\/\/localhost:8888/'
elif [ "$1" == "stop" ]; then
    echo "Stopping the server"
    docker stop phenotypic_data_qc_notebook
    docker rm -f phenotypic_data_qc_notebook
elif [ "$1" == "install" ]; then
    echo "Installing..."
    if ! command -v docker &> /dev/null
    then
        echo "Docker not installed. Please install it before proceeding"
    else
        docker build -t phenotypic-data-qc .
    fi
else
    echo "Unknown option selected '$1'"
fi
