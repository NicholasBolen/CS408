// CS408 - Assignment 5
// Nicholas Bolen
// #200455709

Gas[][][] grid;
Gas[][] cur, old;

int gasP = 50, vScale = 100;

// Init
void setup()
{
    frameCount = 0;
    size(810, 810);
    frameRate(30);

    // Initialize gas with values
    grid = new Gas[2][height][width];
    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++)
            grid[0][i][j] = new Gas(3, gasP/1000.0);
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
            pixels[i*width + j] = color(old[i][j].density, pow(old[i][j].density, 2) * 0.05, pow(old[i][j].density, 3) * 0.0001);
        }
    updatePixels();
}

// Find cells to be updated and call update
void updateCell(int x, int y) {
    // Find newx and newy
    float newx = x + old[y][x].velocity.x * (vScale/100.0);
    float newy = y + old[y][x].velocity.y * (vScale/100.0);
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

// CREATIVE FEATURE
void keyPressed() {
    // Reset
    if (key == '0')
        setup();

    // Gas percent scale
    if (key == 'r' && gasP > 0) {
        gasP -= 5;
        println("Gas percent:", gasP/1000.0);
    } else if (key == 'R' && gasP < 1000) {
        gasP += 5;
        println("Gas percent:", gasP/1000.0);
    }

    // Velocity scale
    if (key == 'v') {
        vScale -= 5;
        println("Velocity scale:", vScale/100.0);
    } else if (key == 'V') {
        vScale += 5;
        println("Velocity scale:", vScale/100.0);
    }
}
