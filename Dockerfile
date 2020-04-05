FROM python:3.6

WORKDIR /app

# build is expected to be done from root of mne-bids repository
COPY . /src

# Get miniconda
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt/miniconda.sh
RUN /bin/bash /opt/miniconda.sh -b -p /opt/conda
ENV PATH="/opt/conda/bin:$PATH"

# Create the environment
RUN conda create -n mne_bids Python=3.6 --yes

# Make RUN commands use the new environment
SHELL ["conda", "run", "-n", "mne_bids", "/bin/bash", "-c"]

# Finish setting up environment
RUN conda install numpy>=1.14 scipy>=0.18.1
RUN pip install mne>=0.19.1
RUN pip install -e /src

ENTRYPOINT ["conda", "run", "-n", "mne_bids", "mne_bids"]
