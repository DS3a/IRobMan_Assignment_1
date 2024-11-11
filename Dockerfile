# Use Ubuntu 22.04 base image
FROM ubuntu:22.04

# Avoid timezone prompts during package installation
# Install system dependencies
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    gcc \
    git \
    locales \
    ffmpeg \
    lsb-release \
    mesa-utils \
    apt-transport-https \
    liblapack3 \
    freeglut3 \
    libglu1-mesa \
    libfreetype6 \
    fonts-ubuntu \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    xserver-xorg-video-all \
    && rm -rf /var/lib/apt/lists/*

# Download and install Miniconda
# Install miniconda
ENV CONDA_DIR=/opt/conda

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh

RUN /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# Create conda environment with Python 3.9
RUN conda create -n robotics_env python=3.9 -y

# Create symbolic link for libglut
RUN cd /usr/lib/x86_64-linux-gnu/ && ln -s libglut.so.3 libglut.so.3.12 || true

# Activate environment and install packages
SHELL ["conda", "run", "-n", "robotics_env", "/bin/bash", "-c"]

RUN ln -s /usr/lib/x86_64-linux-gnu/dri /usr/lib/dri || true
RUN ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.28 ./libstdc++.so.6
RUN conda install -c conda-forge gcc=12.1.0
RUN pip install --no-cache-dir \
    jupyter \
    notebook \
    pandas \
    numpy \
    matplotlib \
    seaborn \
    scikit-learn \
    torch \
    scipy \
    scikit-image \
    opencv-python \
    opencv-python-headless \
    opencv-contrib-python \
    robotic
# Create a non-root user
RUN useradd -m -s /bin/bash jupyter_user
USER jupyter_user

# Set up Jupyter configuration
RUN mkdir -p /home/jupyter_user/.jupyter
COPY jupyter_notebook_config.py /home/jupyter_user/.jupyter/

# Create working directory for notebooks
RUN mkdir -p /home/jupyter_user/notebooks
WORKDIR /home/jupyter_user/notebooks

ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1
ENV LIBGL_ALWAYS_SOFTWARE=1

# Expose the port Jupyter will run on
EXPOSE 8888

# Make sure we use the conda environment when running jupyter
CMD ["conda", "run", "--no-capture-output", "-n", "robotics_env", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
