FROM jupyter/datascience-notebook:latest

## Configure Preferred R environment name = {PREFERRED_NAME}
RUN conda create -y --prefix={PREFERRED_NAME}
# Configure requirements for R with {PREFERRED_R_VERSION}
RUN source activate /home/jovyan/{PREFERRED_NAME}
RUN conda install -y r-base={PREFERRED_R_VERSION}
RUN conda install -c r r-rstan

## Install packages
RUN conda install -c conda-forge r-r.utils
RUN conda install r-recommended r-irkernel
# ...

## Install from github repo
# Example: RUN R -e 'devtools::install_github("{GITHUB_REPOSITORY_LINK}")'
# ..

## Make this environment availble to the jupyter notebook as a kernel
RUN R -e 'IRkernel::installspec(name = "{PREFERRED_NAME}", displayname = "{PREFERRED_NAME}")'
RUN source deactivate

# Configure any requirements for Python
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
