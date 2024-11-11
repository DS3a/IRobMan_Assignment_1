# Assignment 1 Instructions:

The following assignment is graded and covers lectures 2, 3 and 4 of irobman.

You are expected to answer all the questions. The questions are of two types theory and coding.

The marks for each part has been specified in the `assignment_1.ipynb` as well. You are expected to attempt
your questions in this ipython notebook and submit only this file in moodle.

There is no negative marking for incorrect answers.

You can attempt the assignment in both linux or mac based systems.
However for Mac in question 2 you won't be able to see the visualization
due to limited support for OpenGL on Mac.

## Setup

### Running Locally 
**! Only possible for Linux systems**

The following packages are necessary necessary for running locally:

Tested with `python==3.9`

```shell
pip install numpy matplotlib
pip install robotic
pip install torch # [cpu/gpu] upto user preference
```
### Running with Docker
**! For both Linux and Mac**

Install the appropriate docker version for your system:

- Linux : https://docs.docker.com/desktop/install/linux/
- Mac: https://docs.docker.com/desktop/install/mac-install/

For Mac there is an additional step:

We need to setup an X11 server on Mac:
`brew install --cask xquartz`

Make sure docker has necessary permissions to run.
```shell
./build.sh # For building the docker image.

./run.sh # For running the docker image. [Linux]

./run_mac.sh # For running the docker image. [Mac]
```

While running with Dockerfile the browser will not open by default:

You will have to open the link printed in the terminal which can look somewhat like this:

```
http://127.0.0.1:8888/tree?token=982ba1c889e5624543a1ccd1cf5f23288e6457d303fd6c97
```

Note this is an example token, it will be different on your machine.

## Sharp Edges:

- If running via docker make sure it has necessary permissions in your system.

- Sometimes the `.sh` files might not be executable. You can make it executable by running `chmod +x <filename>` in your terminal.

- On Mac devices you will face problem with openGL and won't be able to see the output of the visual output from komo in Question 2. In such a situation comment out every `C.view(...)` lines from your code.

- If your notebook get's stuck then restarting the kernel can help.

- For the pytorch versions make sure you select the appropriate version for your platform.
