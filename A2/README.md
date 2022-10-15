# CS408 - Assignment2

Uploaded by [u/NicholasBolen](https://github.com/NicholasBolen/)

You may be able to run the project through the included EXE file, however if there are any issues present with that, you can download the entire `A2` folder, and open `A2.pde` in the Processing editor which can be [downloaded here](https://processing.org/download).

I have also included EXE files for linux and Windows machines, however I cannot ensure these will work without issue on everybody's system. As well, you will need to have installed Java Runtime Environment 17 as it was too large to upload to GitHub, if you attempt to run the application and it fails it will redirect you to the download page.
I would recommend downloading and running through the Processing editor, however you may attempt this approach.

The animation file should be named "animation.txt", and should be in the same folder as A2.pde. Any objects name in the animation.txt file will be imported by the name given, so please ensure that the file names match properly.
I have included a sample animation and 2 custom models.

## IF WINDOW IS TOO LARGE FOR USER'S RESOLUTION ::

Window size can be adjusted in the `A2.pde` file, simply change the `size(x, y, P3D)` function on line 20 (when opened in processing editor) to fit your needs.

## Creative Feature

For my creative features, I added options to loop the animation or increase the size scale, as well as including some custom 3D models for the `spider.obj` and `ladybug.obj`. 


### Controls:

+/- - Increase / Decrease the size scale. Useful if `obj`s are small (defaulted scale is 1)

L/l - Enable / Disable animation looping. If the animation ends and this option is disabled, the animation window will exit. (defaulted to disabled)

---

The before / after for my creative feature is most easily visualized in the diff for commit [902bc1c51a52fa7287030041f1e2d814e01ba471](https://github.com/NicholasBolen/408/commit/902bc1c51a52fa7287030041f1e2d814e01ba471), but there are also comments in my code around the applicable areas beginnning with "Create Feature". Here is a summary:

The `init()` function was separated from `setup()` to allow for processing the animation multiple times. This is what enables the animation looping.

Variables `sizeScale` and `looping` added to control the current state of those options.

Size scale applies an additional uniform scale to all objects, as well as adjusting the clipping layer of the camera. The offset from the camera does not change.

I also added checks for key presses, so that these options could be controlled by the keyboard.

Additionally, I have included a `spider.obj` and `ladybug.obj`. I modelled these in Blender, but I had some issues exporting custom textures so they are left as plain colours for now. These are mainly what I used during my testing, alongside the include `animation.txt` file supplied on the assignment page.


