// CS408 - Assignment 3
// Nicholas Bolen
// #200455709

/*
    Tasks:
 1. Display a curve
 2. A sphere moving along a curve
 3. Sphere moving along curve with sinsoidal and parabolic ease in/out
 
 
 */

PVector[] control = new PVector[0];
int scale = 20, offset = 200, segments = 200;
float i2 = 3;

// Init
void setup()
{
    // Adding all control points
    control = (PVector[])append(control, new PVector( 0.0, 0.0, 0.0));
    control = (PVector[])append(control, new PVector( 1.0, 3.5, 0.0));
    control = (PVector[])append(control, new PVector( 4.8, 1.8, 0.0));
    control = (PVector[])append(control, new PVector( 6.5, 7.0, 0.0));
    control = (PVector[])append(control, new PVector( 9.0, 3.5, 0.0));
    control = (PVector[])append(control, new PVector(32.5, 4.8, 0.0));
    control = (PVector[])append(control, new PVector(33.2, 2.6, 0.0));
    control = (PVector[])append(control, new PVector(36.8, 7.0, 0.0));
    control = (PVector[])append(control, new PVector(37.8, 5.0, 0.0));
    control = (PVector[])append(control, new PVector(41.2, 20.5, 0.0));
    control = (PVector[])append(control, new PVector(41.5, 21.5, 0.0));

    size(1440, 810, P3D);
    frameRate(30);
}

// Create new particle and call update function on each frame
void draw()
{
    // White background
    background(123);

    // Control points
    noStroke();
    fill(0);
    for (PVector x : control) {
        ellipse(x.x*scale + offset, x.y*scale + offset, 10, 10);
    }

    // Blue curve
    noStroke();
    fill(0, 0, 255);
    for (int i = 3; i < control.length; i++) {
        // Calculate Cubic B-Spline segment
        for (float u = 0; u <= 1; u += 1.0 / segments) {
            // Calculate segment point
            PVector point = PVector.mult(control[i - 3], pow((1 - u), 3) / 6);
            point.add(PVector.mult(control[i - 2], (3*pow(u, 3) - 6*pow(u, 2) + 4) / 6));
            point.add(PVector.mult(control[i - 1], (-3*pow(u, 3) + 3*pow(u, 2) + 3*u + 1) / 6));
            point.add(PVector.mult(control[i], pow(u, 3) / 6));

            // Draw
            ellipse(point.x*scale + offset, point.y*scale + offset, 2, 2);
        }
    }

    // Yellow sphere
    fill(255, 255, 0);
    float u = i2 % 1;
    int i = floor(i2);
    i2 += 1 / (5*30.0 / (11 - 3));
    if (frameCount >= 150) {
        i2 = 3;
        frameCount = 0;
    }
    // Draw sphere
    PVector point = PVector.mult(control[i - 3], pow((1 - u), 3) / 6);
    point.add(PVector.mult(control[i - 2], (3*pow(u, 3) - 6*pow(u, 2) + 4) / 6));
    point.add(PVector.mult(control[i - 1], (-3*pow(u, 3) + 3*pow(u, 2) + 3*u + 1) / 6));
    point.add(PVector.mult(control[i], pow(u, 3) / 6));
    ellipse(point.x*scale + offset, point.y*scale + offset, 30, 30);
}
