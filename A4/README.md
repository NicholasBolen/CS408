# CS408 - Assignment4

Uploaded by [u/NicholasBolen](https://github.com/NicholasBolen/)

You may be able to run the project through the included EXE file, however if there are any issues present with that, you can download the entire `A4` folder, and open `A4.pde` in the Processing editor which can be [downloaded here](https://processing.org/download).

I have also included EXE files for linux and Windows machines, however I cannot ensure these will work without issue on everybody's system. As well, you will need to have installed Java Runtime Environment 17 as it was too large to upload to GitHub, if you attempt to run the application and it fails it will redirect you to the download page.
I would recommend downloading and running through the Processing editor, however you may attempt this approach.

## IF WINDOW IS TOO LARGE FOR USER'S RESOLUTION ::

Window size can be adjusted in the `A4.pde` file, simply change the `size(x, y, P3D)` function on line 38 (when opened in processing editor) to fit your needs.

# Q1

My extra body parts were simply knees, elbows and shoulders, consisting of spheres. They don’t add much for actual “actionable” or interesting body parts, however I feel they add a lot to smoothing out the character and movement, preventing some sharp edges and floating limbs whenever they bend.

# Q2

Drawn model with:
Constant, variable, and node transformations

Image in `A4.pdf` 	

# Q3

Note: When some of these rotations are executed, they are negated (in places where angles should be mirrored for left/right limb, or to ensure that the knees/elbows bend the correct direction). This is visible in my code.

Tables in `A4.pdf`

Here are the raw min & max vector arrays I used:

```
PVector[] min = {
    new PVector(-PI/6, -PI/3, 0), // head
    new PVector(-PI/4, -PI/2, 0), // left upper arm
    new PVector(0, 0, 0), // left lower arm
    new PVector(-PI/4, -PI/2, 0), // right upper arm
    new PVector(0, 0, 0), // right lower arm
    new PVector(-PI/6, -PI/2, 0), // left upper leg
    new PVector(-5*PI/6, 0, 0), // left lower leg
    new PVector(-PI/3, 0, 0), // left foot
    new PVector(-PI/6, -PI/2, 0), // right upper leg
    new PVector(-5*PI/6, 0, 0), // right lower leg
    new PVector(-PI/3, 0, 0), // right foot
};
PVector[] max = {
    new PVector(PI/4, PI/3, 0), // head
    new PVector(PI, PI/2, PI), // left upper arm
    new PVector(5*PI/6, 0, 0), // left lower arm
    new PVector(PI, PI/2, PI), // right upper arm
    new PVector(5*PI/6, 0, 0), // right lower arm
    new PVector(PI/2, 0, PI/3), // left upper leg
    new PVector(0, 0, 0), // left lower leg
    new PVector(0, 0, 0), // left foot
    new PVector(PI/2, 0, PI/3), // right upper leg
    new PVector(0, 0, 0), // right lower leg
    new PVector(0, 0, 0), // right foot
};
```

# Q4

Active when the program is launched for the first time, and will continue looping until the user chooses one of the pose modes with f, b, or n.

# Q5

Tables in `A4.pdf`

L upper-arm = (0, 0, PI/2)

R upper-arm = (0, 0, PI/2)

R upper-arm = (PI/2, 0, PI/2)

R lower-arm = (PI/2, 0, 0)

R upper-leg = (PI/3, 0, 0)

L upper-arm=(PI/2, 0, PI/2)

L lower-arm = (PI/2, 0, 0)

R lower-leg = (-PI/2, 0, 0)


# Q6

‘f’ - Interpolate between pose 0 and pose 1

‘b’ - Interpolate between pose 0 and pose 2

‘n’ - Interpolate between pose 3 and pose 4 (custom, cheering march?)

‘X/x’ - Increase/decrease X axis spin speed

‘Y/y’ - Increase/decrease Y axis spin speed

‘Z/z’ - Increase/decrease Z axis spin speed


