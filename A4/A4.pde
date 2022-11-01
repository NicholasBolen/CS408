// CS408 - Assignment 4
// Nicholas Bolen
// #200455709

// Init
void setup()
{
    size(810, 810, P3D);
    frameRate(30);
}

// Draw on each frame
void draw()
{
    // Black background
    background(0);
    fill(255, 255, 0);
    strokeWeight(15);
    ellipse(405, 405, 700, 700);
    ellipse(300, 300, 150, 150);
    ellipse(510, 300, 150, 150);
    ellipse(405, 510, 400, 50);
}
