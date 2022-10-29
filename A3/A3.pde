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
int scale = 20, offset = 200;

// Init
void setup()
{
    // Adding all control points
    control = (PVector[])append(control, new PVector( 0.0,  0.0, 0.0));
    control = (PVector[])append(control, new PVector( 1.0,  3.5, 0.0));
    control = (PVector[])append(control, new PVector( 4.8,  1.8, 0.0));
    control = (PVector[])append(control, new PVector( 6.5,  7.0, 0.0));
    control = (PVector[])append(control, new PVector( 9.0,  3.5, 0.0));
    control = (PVector[])append(control, new PVector(32.5,  4.8, 0.0));
    control = (PVector[])append(control, new PVector(33.2,  2.6, 0.0));
    control = (PVector[])append(control, new PVector(36.8,  7.0, 0.0));
    control = (PVector[])append(control, new PVector(37.8,  5.0, 0.0));
    control = (PVector[])append(control, new PVector(41.2, 20.5, 0.0));
    control = (PVector[])append(control, new PVector(41.5, 21.5, 0.0));
    
    size(1440, 810, P3D);
    frameRate(60);
}

// Create new particle and call update function on each frame
void draw()
{
    // White background
    background(0);
    
    stroke(0, 0, 255);
    for(int i = 0; i < control.length - 1; i++) {
        line(control[i].x*scale + offset, control[i].y*scale + offset, control[i+1].x*scale + offset, control[i+1].y*scale + offset);
    }
    
    noStroke();
    fill(255);
    for(PVector x : control) {
        ellipse(x.x*scale + offset, x.y*scale + offset, 10, 10);
    }
}
