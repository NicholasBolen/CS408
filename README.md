# CS408 - Assignment1

You may be able to run the project through the included EXE file, however if there are any issues present with that, you can download the `.pde` file and open it in the Processing editor which can be [downloaded here](https://processing.org/download).

All of the controls listed in the submission requirements are present, and should match the expected result given by the project assignemnt requirements.

## Creative Feature

For my creative feature, I added another control for all parameters so that particles can be generated within a range of parameters, as opposed to just those currently selected.

In the top left of the screen, there is some info about the currently selected mode:
```Red box = Secondary attributes disabled,
Green box = Secondary attributes enabled

Number 1 = Currently editing primary attributes,
Number 2 = Currently editing secondary attributes```
### Example:

For example, this allows me to set two size parameters (ex. sizeA = 5, sizeB = 100), and now all generated particles will have a size randomly selected between the values of 5 and 100. 

### Controls:

0 - Resets all values to default

1 - Sets user editing the primary attributes (default)

2 - Sets user editing the secondary attributes

3 - Enables / disables secondary attributes (defaulted to disabled)

4 - Enables / disables guide(s) (defaulted to disabled)
