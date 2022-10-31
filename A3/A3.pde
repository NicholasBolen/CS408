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
int scale = 10, offset = width / 4 * 2, segments = 100;
float position = 0, velocity = 0;
float[] arcLengths = {
    0.07538017,
    0.08531444,
    0.15072927,
    0.40708598,
    0.12589459,
    0.08772681,
    0.06786877
,
    0.26298305
};

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

    /*
    // Calculating arc lengths
    // Segment points
    PVector[] a = { 
        new PVector(1.467, 2.633), 
        new PVector(4.45, 2.95), 
        new PVector(6.6333337, 5.5500007),
        new PVector(12.5, 4.3),
        new PVector(28.7, 4.216667),
        new PVector(33.683334, 3.7),
        new PVector(36.366665, 5.933334),
        new PVector(38.2, 7.916667),
        new PVector(40.683334, 18.083326)
    };
    // Lengths
    for(int i = 0; i < a.length - 1; i++) {
        println(sqrt(pow(a[i].x - a[i+1].x, 2) + pow(a[i].y - a[i+1].y, 2)));
    }
    // Ratio
    float[] arcLengths = {
        2.9997962,
        3.395136,
        5.998356,
        16.200216,
        5.010046,
        3.4911377,
        2.700876,
        10.465558
    };
    for(int i = 0; i < arcLengths.length; i++) {
        println((arcLengths[i] / 39.7955639));
    }
    //*/
    
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
        for (float u = 0; u <= 1; u += 1.0 / segments*arcLengths[i - 3]) {
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
    
    float a = (frameCount-1) / 150.0;
    int i = floor(a * 8) + 3;
    float u = (frameCount - (i-3)*18.75) / 18.75;
    
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
        for (u = 0; u <= 1; u += 1.0 / segments*arcLengths[i - 3]) {
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
    
    float s = (float)sinEase(frameCount, 3, 7.99999, 5 * 30);    // Apply sinusoidal easeIn/easeOut
    u = s % 1;
    i = floor(s);
    
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
        for (u = 0; u <= 1; u += 1.0 / segments*arcLengths[i - 3]) {
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
    
    if(frameCount == 1) {
        position = 3;
        velocity = 0;
    }
    
    a = (frameCount-1) / 150.0;
    position += velocity * (7.99999 / 3252);
    u = position % 1;
    i = floor(position);
    
    if(a <= 1.0/6)
        velocity++;
    else if(a >= 5.0/6)
        velocity--;
        
    // Draw sphere
    point = PVector.mult(control[i - 3], pow((1 - u), 3) / 6);
    point.add(PVector.mult(control[i - 2], (3*pow(u, 3) - 6*pow(u, 2) + 4) / 6));
    point.add(PVector.mult(control[i - 1], (-3*pow(u, 3) + 3*pow(u, 2) + 3*u + 1) / 6));
    point.add(PVector.mult(control[i], pow(u, 3) / 6));
    ellipse(point.x*scale + offset*2, point.y*scale + offset*11, 1.5*scale, 1.5*scale);
    
    
    // Loop every 5 seconds
    if (frameCount >= 150)
        frameCount = 0; // will update to 1 next time draw() is called
}

/*
t = time (progress through the animation, 0 = start, d = end)
start = value when t = 0)
end = value when t = 1
maxT = max time
*/
double sinEase(int t, float start, float end, int maxT) {
    return -end / 2 * (Math.cos(Math.PI * t / maxT) - 1) + start;
}
