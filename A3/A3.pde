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
int scale = 10, offset = width / 4 * 2, segments = 200;
float index1 = 3, index2 = 3, index3 = 3;

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

    size(810, 810, P3D);
    frameRate(30);
}

// Create new particle and call update function on each frame
void draw()
{
    // White background
    background(123);

    // === (a) Uniform Cubic B-Spline ===
    // Control points
    noStroke();
    fill(0);
    for (PVector x : control) {
        ellipse(x.x*scale + offset*6, x.y*scale + offset, 10, 10);
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
            ellipse(point.x*scale + offset*6, point.y*scale + offset, 2, 2);
        }
    }

    // === (b) Motion Control ===
    // Yellow sphere
    fill(255, 255, 0);
    float u = index1 % 1;
    int i = floor(index1);
    index1 += 1 / (5*30.0 / (11 - 3));
    if (frameCount >= 150) {
        index1 = 3;
    }
    // Draw sphere
    PVector point = PVector.mult(control[i - 3], pow((1 - u), 3) / 6);
    point.add(PVector.mult(control[i - 2], (3*pow(u, 3) - 6*pow(u, 2) + 4) / 6));
    point.add(PVector.mult(control[i - 1], (-3*pow(u, 3) + 3*pow(u, 2) + 3*u + 1) / 6));
    point.add(PVector.mult(control[i], pow(u, 3) / 6));
    ellipse(point.x*scale + offset*6, point.y*scale + offset, 1.5*scale, 1.5*scale);
    
    
    // === (c) Sinusoidal Ease-in / Ease-out ===
    // Control points
    noStroke();
    fill(0);
    for (PVector x : control) {
        ellipse(x.x*scale + offset*4, x.y*scale + offset*6, 10, 10);
    }

    // Blue curve
    noStroke();
    fill(0, 0, 255);
    for (i = 3; i < control.length; i++) {
        // Calculate Cubic B-Spline segment
        for (u = 0; u <= 1; u += 1.0 / segments) {
            // Calculate segment point
            point = PVector.mult(control[i - 3], pow((1 - u), 3) / 6);
            point.add(PVector.mult(control[i - 2], (3*pow(u, 3) - 6*pow(u, 2) + 4) / 6));
            point.add(PVector.mult(control[i - 1], (-3*pow(u, 3) + 3*pow(u, 2) + 3*u + 1) / 6));
            point.add(PVector.mult(control[i], pow(u, 3) / 6));

            // Draw
            ellipse(point.x*scale + offset*4, point.y*scale + offset*6, 2, 2);
        }
    }
    
    // Yellow sphere
    fill(255, 255, 0);
    
    index2 = (float)sinEase(frameCount, 3, 7.99999, 5 * 30);    // Apply sinusoidal easeIn/easeOut
    u = index2 % 1;
    i = floor(index2);
    
    // Draw sphere
    point = PVector.mult(control[i - 3], pow((1 - u), 3) / 6);
    point.add(PVector.mult(control[i - 2], (3*pow(u, 3) - 6*pow(u, 2) + 4) / 6));
    point.add(PVector.mult(control[i - 1], (-3*pow(u, 3) + 3*pow(u, 2) + 3*u + 1) / 6));
    point.add(PVector.mult(control[i], pow(u, 3) / 6));
    ellipse(point.x*scale + offset*4, point.y*scale + offset*6, 1.5*scale, 1.5*scale);
    
    
    // === (d) Parabolic Ease-in / Ease-out ===
    // Control points
    noStroke();
    fill(0);
    for (PVector x : control) {
        ellipse(x.x*scale + offset*2, x.y*scale + offset*11, 10, 10);
    }
    // Blue curve
    noStroke();
    fill(0, 0, 255);
    for (i = 3; i < control.length; i++) {
        // Calculate Cubic B-Spline segment
        for (u = 0; u <= 1; u += 1.0 / segments) {
            // Calculate segment point
            point = PVector.mult(control[i - 3], pow((1 - u), 3) / 6);
            point.add(PVector.mult(control[i - 2], (3*pow(u, 3) - 6*pow(u, 2) + 4) / 6));
            point.add(PVector.mult(control[i - 1], (-3*pow(u, 3) + 3*pow(u, 2) + 3*u + 1) / 6));
            point.add(PVector.mult(control[i], pow(u, 3) / 6));

            // Draw
            ellipse(point.x*scale + offset*2, point.y*scale + offset*11, 2, 2);
        }
    }
    // Yellow sphere
    fill(255, 255, 0);
    u = index3 % 1;
    i = floor(index3);
    index3 += 1 / (150.0 / 8);
    if (frameCount >= 150) {
        index3 = 3;
        frameCount = 0;
    }
    // Draw sphere
    point = PVector.mult(control[i - 3], pow((1 - u), 3) / 6);
    point.add(PVector.mult(control[i - 2], (3*pow(u, 3) - 6*pow(u, 2) + 4) / 6));
    point.add(PVector.mult(control[i - 1], (-3*pow(u, 3) + 3*pow(u, 2) + 3*u + 1) / 6));
    point.add(PVector.mult(control[i], pow(u, 3) / 6));
    ellipse(point.x*scale + offset*2, point.y*scale + offset*11, 1.5*scale, 1.5*scale);
}

/*
t = time (progress through the animation, 0 = start, d = end)
start = value when t = 0)
end = value when t = 1
maxT = max time
*/
double sinEase(int t, int start, float end, int maxT) {
    return -end / 2 * (Math.cos(Math.PI * t / maxT) - 1) + start;
}
