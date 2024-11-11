xhost +

docker run -it --net=host --platform linux/amd64 --privileged --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --env="DISPLAY" -p 8888:8888 -v $(pwd):/home/jupyter_user/notebooks jupyter-env
