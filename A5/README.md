# CS408 - Assignment 5

Uploaded by [u/NicholasBolen](https://github.com/NicholasBolen/)

You may be able to run the project through the included EXE file, however if there are any issues present with that, you can download the entire `A5` folder, and open `A5.pde` in the Processing editor which can be [downloaded here](https://processing.org/download).

I have also included EXE files for linux and Windows machines, however I cannot ensure these will work without issue on everybody's system. As well, you will need to have installed Java Runtime Environment 17 as it was too large to upload to GitHub, if you attempt to run the application and it fails it will redirect you to the download page.
I would recommend downloading and running through the Processing editor, however you may attempt this approach.

## IF WINDOW IS TOO LARGE FOR USER'S RESOLUTION ::

Window size can be adjusted in the `A5.pde` file, simply change the `size(x, y, P3D)` function on line 14 (when opened in processing editor) to fit your needs.


## Creative Feature

For my creative feature, I added controls for the initial gas distribution chance, as well as a velocity scale.

### Controls:

0 - Restarts simulation (necessary to see results of gas distribution modifier)

R/r - increases/decreases the chance that gas will be placed in any given cell (defaults to 0.05)

S/s - increases/decreases the velocity scale that takes effect when determining the resulting position of gas (defaults to 1)

---

The before / after for my creative feature is most easily visualized in the diff for commit [44faaeaa70242ea112ce963ff09d6de8d1f54e20](https://github.com/NicholasBolen/408/commit/44faaeaa70242ea112ce963ff09d6de8d1f54e20), but there are also comments in my code around the applicable areas beginnning with "Create Feature". Here is a summary:

There were a couple additional controller variables added (`gasP` and `vScale`).

Much was added to my `draw()` function to display the current state of the program in the top left, as well as support for randomly selecting within the range given.

I had to add the `keyPressed()` function to support controlling the new gas and velocity controllers. As well, I added the control for restarting & reinitializing the simulation.

Restarting the simulation is relatively simple, as I need only re-run my setup function, as well as resetting the `frameCount` to 0. To implement the initial gas percentage, I replaced the default 0.05 with my new controller variable, and passed this along wherever necessary during simulation initialization. Finally, to implement the velocity scale, in the `updateCells()` function, the resulting x and y are scaled by `vScale`. This allows the resulting position of the gas to be scaled, without having to directly modify their velocity (note that gas may act differently than expected because of this, whenever `vScale` != 1).