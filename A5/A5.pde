// CS408 - Assignment 5
// Nicholas Bolen
// #200455709

Gas[][][] grid;
Gas[][] cur, old;

// Creative Feature - controls for gas percent, velocity scale, velocity max, colourMode
int gasP = 50, vScale = 100, vMax = 3, colourMode = 0;

// Init
void setup()
{
    frameCount = 0;    // Creative Feature - reset frameCount when restarting simulation
    size(810, 810);
    frameRate(30);

    // Initialize gas with values
    grid = new Gas[2][height][width];
    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++)
            grid[0][i][j] = new Gas(vMax, gasP/1000.0);    // Creative Feature - pass set gas percentage & velocity max to gas generation
}

// Draw on each frame
void draw()
{
    // Black background
    background(0);
    // Determine old/new grids
    old = grid[(frameCount + 1) % 2];
    cur = grid[frameCount % 2];

    displayGrid();

    // Initialize new grid to 0
    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++)
            cur[i][j] = new Gas(0, 0);

    // Update position
    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++)
            updateCell(j, i);
}

// Display gas
void displayGrid() {
    // Display gas
    loadPixels();
    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++) {
            float density = old[i][j].density;
            pixels[i*width + j] = colorFunc(density, j, i);
        }
    updatePixels();
}

// Creative Feature - return colour based on current state & colourMode
color colorFunc(float density, int x, int y) {

    // rgb controls
    float r = 0;
    float g = 0;
    float b = 0;

    // Default
    if (colourMode == 0)
        return color(density, pow(density, 2) * 0.05, pow(density, 3) * 0.0001);

    //  Heat map
    if (colourMode == 1) {
        int max = 75;
        // 0  -  25 = black to red
        if (density / max < 0.25)
            r = 255 * ((density / max) / 0.25);
        // 25 -  50 = red to green
        else if (density / max < 0.5) {
            g = 255 * (((density / max) - 0.25) / 0.25);
            r = 255 - g;
        }
        // 50 -  99 = green to blue
        else if (density / max < 0.99) {
            b = 255 * (((density / max) - 0.5) / 0.49);
            g = 255 - b;
        }
        // 99 - 100 = blue to white
        else {
            b = 255;
            g = (((density / max) - 0.99) / 0.01);
            r = g;
        }
        return color(r, g, b);
    }

    // Aqua
    if (colourMode == 2)
        return color(0, 255 - density*100, 255 - density*100);

    // Colour mapped by position
    r = (x / float(width))*255;
    g = 255 - ((x + y) / float(width + height))*255;
    b = 255 - ((x + (height-y)) / float(width + height))*255;

    if (colourMode == 3)
        return color(r/density, g/density, b/density);
    return color(255 - r/density, 255 - g/density, 255 - b/density);
}

// Find cells to be updated and call update
void updateCell(int x, int y) {
    // Find newx and newy
    float newx = x + old[y][x].velocity.x * (vScale/100.0);    // Creative Feature - apply velocity scale when finding position
    float newy = y + old[y][x].velocity.y * (vScale/100.0);    // Creative Feature - apply velocity scale when finding position
    while (newy >= height) newy -= height;
    while (newy < 0.0) newy += height;
    while (newx >= width) newx -= width;
    while (newx < 0.0) newx += width;

    // Locate all destination cells
    int intx = (int) newx;
    int inty = (int) newy;
    float fractionx = newx - intx;
    float fractiony = newy - inty;

    // Update from inflow
    updateFromInflow(
        intx,
        inty,
        (1.0 - fractionx) * (1.0 - fractiony) * old[y][x].density,
        old[y][x].velocity);
    updateFromInflow(
        intx,
        inty + 1,
        (1.0 - fractionx) * fractiony          * old[y][x].density,
        old[y][x].velocity);
    updateFromInflow(
        intx + 1,
        inty,
        fractionx          * (1.0 - fractiony) * old[y][x].density,
        old[y][x].velocity);
    updateFromInflow(
        intx + 1,
        inty + 1,
        fractionx          * fractiony           * old[y][x].density,
        old[y][x].velocity);
}

// Update cells (velocity & density)
void updateFromInflow(int x, int y, float m2, PVector v2) {
    // Wrap-around
    while (y >= height) y -= height;
    while (y < 0.0) y += height;
    while (x >= width) x -= width;
    while (x < 0.0) x += width;

    // Save current cell conditions
    float m1 = cur[y][x].density;
    PVector v1 = cur[y][x].velocity;

    // Avoid dividing by 0
    if (m1 + m2 == 0) {
        cur[y][x].density = 0;
        cur[y][x].velocity = new PVector(0, 0);
    } else {
        cur[y][x].density = m1 + m2;
        cur[y][x].velocity = new PVector((m1 * v1.x + m2*v2.x) / (m1 + m2), (m1 * v1.y + m2*v2.y) / (m1 + m2));
    }
}

// Creative Feature - detect keypresses for controls
void keyPressed() {
    // Creative Feature - Reset
    if (key == '0')
        setup();

    // Creative Feature - Gas percent scale
    if (key == 'r' && gasP > 0) {
        gasP -= 5;
        println("Gas percent:", gasP/1000.0);
    } else if (key == 'R' && gasP < 1000) {
        gasP += 5;
        println("Gas percent:", gasP/1000.0);
    }

    // Creative Feature - Velocity scale
    if (key == 'v') {
        vScale -= 5;
        println("Velocity scale:", vScale/100.0);
    } else if (key == 'V') {
        vScale += 5;
        println("Velocity scale:", vScale/100.0);
    }

    // Creative Feature - Velocity max
    if (key == '-' && vMax > 0) {
        vMax--;
        println("Velocity Max:", vMax);
    } else if (key == '+') {
        vMax++;
        println("Velocity Max:", vMax);
    }

    // Creative Feature - Colour mode
    if (key == 'd' && colourMode < 4) {
        colourMode++;
        println("Colour Mode:", colourMode);
    } else if (key == 'a' && colourMode > 0) {
        colourMode--;
        println("Colour Mode:", colourMode);
    }
}
