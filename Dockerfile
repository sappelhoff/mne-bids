FROM python:3.11

WORKDIR /app

# build is expected to be done from root of mne-bids repository
COPY . /src

# Get miniconda
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt/miniconda.sh
RUN /bin/bash /opt/miniconda.sh -b -p /opt/conda
ENV PATH="/opt/conda/bin:$PATH"

# Create the environment
RUN conda create -n mne_bids Python=3.11 --yes

# Make RUN commands use the new environment
SHELL ["conda", "run", "-n", "mne_bids", "/bin/bash", "-c"]

# Finish setting up environment
RUN pip install -e /src[dev]

ENTRYPOINT ["conda", "run", "-n", "mne_bids", "mne_bids"]
