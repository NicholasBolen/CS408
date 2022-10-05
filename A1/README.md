# CS408 - Assignment1

Uploaded by [u/NicholasBolen](https://github.com/NicholasBolen/)

You may be able to run the project through the included EXE file, however if there are any issues present with that, you can download the entire `A1` folder, and open `A1.pde` in the Processing editor which can be [downloaded here](https://processing.org/download).

I have also included EXE files for linux and Windows machines, however I cannot ensure these will work without issue on everybody's system. As well, you will need to have installed Java Runtime Environment 17 as it was too large to upload to GitHub, if you attempt to run the application and it fails it will redirect you to the download page.
I would recommend downloading and running through the Processing editor, however you may attempt this approach.

All of the controls listed in the submission requirements are present, and should match the expected result given by the project assignemnt requirements.

## IF WINDOW IS TOO LARGE FOR USER'S RESOLUTION ::

Window size can be adjusted in the A1 file, simply change the `size(x, y)` function on line 15 (when opened in processing editor) to fit your needs.

## Creative Feature

For my creative feature, I added another control for all parameters so that particles can be generated within a range of parameters, as opposed to just those currently selected.

In the top left of the screen, there is some info about the currently selected mode:
```
Red box = Secondary attributes disabled,
Green box = Secondary attributes enabled

Number 1 = Currently editing primary attributes,
Number 2 = Currently editing secondary attributes
```

I also added some guides for easier editing. When these are enabled, they will appear as outlines with the attributes of their controller. They are most easily seen when secondary attributes are enabled, and have a different colour form the primary attributes.

### Example:

For example, this allows me to set two size parameters (ex. sizeA = 5, sizeB = 100), and now all generated particles will have a size randomly selected between the values of 5 and 100. 

### Controls:

0 - Resets all values to default

1 - Sets user editing the primary attributes (default)

2 - Sets user editing the secondary attributes

3 - Enables / disables secondary attributes (defaulted to disabled)

4 - Enables / disables guide(s) (defaulted to disabled)

---

The before / after for my creative feature is most easily visualized in the diff for commit [4adae8c8e9ab1ff8c84281a1d1434040030069f1](https://github.com/NicholasBolen/408/commit/4adae8c8e9ab1ff8c84281a1d1434040030069f1), but there are also comments in my code around the applicable areas beginnning with "Create Feature". Here is a summary:

The `urandom()` function was added to allow me ignore what order the values were in when trying to retrieve a random number between two ranges.

There were a few additional controller variables added (`secondaryEnabled`, `guidesEnabled`, `control2`).

Much was added to my `draw()` function to display the current state of the program in the top left, as well as support for randomly selecting within the range given.

I also had to make changes on almost every line in my `keyPressed()` function, to support controlling either the `control` or `control2` emitters. At the end of this function, I added additional keypresses for resetting, setting edit mode (primary or secondary), toggling the secondary attribute, and toggling the guides.

Finally, I also added a `renderOutline()` function to my Particle class, which is used for the guides.
