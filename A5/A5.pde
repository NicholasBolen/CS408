// CS408 - Assignment 5
// Nicholas Bolen
// #200455709

Gas[][] a;

// Init
void setup()
{
    size(810, 810);
    frameRate(30);
    
    // Initialize gas
    a = new Gas[height][width];
    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++)
            a[i][j] = new Gas(j, i);
}

// Draw on each frame
void draw()
{
    // Black background
    background(0);

    // Display gas
    loadPixels();
    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++) {
            Gas cur = a[i][j];
            //println(cur.position.x, cur.position.y);
            pixels[int(cur.position.y)*height + int(cur.position.x)] = color(cur.density, pow(cur.density, 2) * 0.05, pow(cur.density, 3) * 0.0001);
        }
    updatePixels();


    // Update position
    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++) {
            Gas cur = a[i][j];
            cur.position.x = (cur.position.x + cur.velocity.x) % width;
            if (cur.position.x < 0)
                cur.position.x += width;
            cur.position.y = (cur.position.y + cur.velocity.y) % height;
            if (cur.position.y < 0)
                cur.position.y += height;
        }
}
