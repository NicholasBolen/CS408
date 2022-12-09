# CS408 - Assignment 6

Uploaded by [u/NicholasBolen](https://github.com/NicholasBolen/)

You may be able to run the project through the included EXE file, however if there are any issues present with that, you can download the entire `A6` folder, and open `A6.pde` in the Processing editor which can be [downloaded here](https://processing.org/download).

I have also included EXE files for linux and Windows machines, however I cannot ensure these will work without issue on everybody's system. As well, you will need to have installed Java Runtime Environment 17 as it was too large to upload to GitHub, if you attempt to run the application and it fails it will redirect you to the download page.
I would recommend downloading and running through the Processing editor, however you may attempt this approach.

## Creative Feature

For my creative feature, I added controls for scene rotation, zoom in/out, falling sand size and weight, and a reset button.

### Controls:

0 - Restarts simulation

wasd - Move emitter forward/back, left/right

+/- - Zoom in/out on origin of scene

drag mouse - Rotate scene

X/x - increase/decrease the falling sand particle size

C/C - increase/decrease the falling sand particle weight

---

The before / after for my creative feature is most easily visualized in the diff for commit [44faaeaa70242ea112ce963ff09d6de8d1f54e20](https://github.com/NicholasBolen/408/commit/44faaeaa70242ea112ce963ff09d6de8d1f54e20), but there are also comments in my code around the applicable areas beginnning with "Create Feature". Here is a summary:

There were a few additional controller variables added (`rotX`, `rotY`, `zoom`, `size`, and `weight`).

I had to add the `mouseDragged()` function to support scene rotation. I also added many more keys to my `keyPressed()` function.

Restarting the simulation is relatively simple, as I need only reset the `frameCount` to 0 and reset my heightmap. To implement the sand weight, I replaced the default 5 with my new controller variable. The sand size was implemented in a very similar way, replacing the default 5 with my new controller variable. To implement the rotation and zoom, I added controller variables for each of these, and then applied the values stored in the controllers at the start of every frame, using `rotateX()` and `rotateY()`, and `scale()` respectively.
