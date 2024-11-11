#!/bin/bash

# Start XQuartz
open -a XQuartz


# Allow X11 forwarding from any host (for testing, restrict this in production)
xhost +

# Run docker container
docker run -it \
    --platform linux/amd64 \
    --privileged \
    -e DISPLAY=host.docker.internal:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e LIBGL_ALWAYS_INDIRECT=1 \
    -e MESA_GL_VERSION_OVERRIDE=3.3 \
    -e MESA_GLSL_VERSION_OVERRIDE=330 \
    -p 8888:8888 \
    -v $(pwd):/home/jupyter_user/notebooks \
    jupyter-env
