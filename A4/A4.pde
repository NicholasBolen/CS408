// CS408 - Assignment 4
// Nicholas Bolen
// #200455709

// used for spin
float angle = 0, speed = 0;

PVector[] min = {
    new PVector(-PI/6, -PI/3, 0), // head
    new PVector(-PI/4, -PI/2, 0), // left upper arm
    new PVector(0, 0, 0), // left lower arm
    new PVector(-PI/4, -PI/2, 0), // right upper arm
    new PVector(0, 0, 0), // right lower arm
    new PVector(-PI/6, -PI/2, 0), // left upper leg
    new PVector(-5*PI/6, 0, 0), // left lower leg
    new PVector(-PI/3, 0, 0), // left foot
    new PVector(-PI/6, -PI/2, 0), // right upper leg
    new PVector(-5*PI/6, 0, 0), // right lower leg
    new PVector(-PI/3, 0, 0), // right foot
};
PVector[] max = {
    new PVector(PI/4, PI/3, 0), // head
    new PVector(PI, PI/2, PI), // left upper arm
    new PVector(5*PI/6, 0, 0), // left lower arm
    new PVector(PI, PI/2, PI), // right upper arm
    new PVector(5*PI/6, 0, 0), // right lower arm
    new PVector(PI/2, 0, PI/3), // left upper leg
    new PVector(0, 0, 0), // left lower leg
    new PVector(0, 0, 0), // left foot
    new PVector(PI/2, 0, PI/3), // right upper leg
    new PVector(0, 0, 0), // right lower leg
    new PVector(0, 0, 0), // right foot
};

// Init
void setup()
{
    size(810, 810, P3D);
    frameRate(30);
}

// Draw on each frame
void draw()
{
    // frame setup
    lights();
    translate(width/2, height/2);
    noStroke();
    sphereDetail(25);

    // spin
    angle += speed;
    rotateX(angle/2);
    rotateY(angle);
    rotateZ(angle*1.5);
    pushMatrix();

    // Grey background
    background(123);
    // Yellow character
    fill(255, 255, 0);

    // Character
    // body
    pushMatrix();
    translate(0, -75);
    cylinder(50, 150, 25);
    popMatrix();
    // neck
    pushMatrix();
    rotateY(interpolate(max[0].y, min[0].y)); // left/right
    translate(0, -95);
    cylinder(10, 20, 25);
    // head
    rotateX(interpolate(max[0].x, min[0].x)); // up/down
    translate(0, -50);
    sphere(50);
    // nose
    pushMatrix();
    translate(0, 15, 50);
    box(10, 10, 20);
    popMatrix();
    // ear-l
    pushMatrix();
    translate(-50, 0, 0);
    sphere(15);
    popMatrix();
    // ear-r
    pushMatrix();
    translate(50, 0, 0);
    sphere(15);
    popMatrix();
    popMatrix();


    // arms
    // left-u
    pushMatrix();
    translate(-62, -70);
    sphere(12); // shoulder
    rotateX(interpolate(max[1].x, min[1].x)); // forwards/back
    rotateZ(interpolate(max[1].z, min[1].z)); // out/up
    rotateY(interpolate(max[1].y, min[1].y)); // palm
    cylinder(12, 75, 25);
    // left-l
    translate(0, 75);
    sphere(12); // elbow
    rotateX(interpolate(max[2].x, min[2].x)); // elbow bend
    cylinder(12, 75, 25);
    popMatrix();
    // right-u
    pushMatrix();
    translate(62, -70);
    sphere(12); // shoulder
    rotateX(interpolate(max[3].x, min[3].x)); // forwards/back
    rotateZ(-interpolate(max[3].z, min[3].z)); // out/up
    rotateY(-interpolate(max[3].y, min[3].y)); // palm
    cylinder(12, 75, 25);
    // right-l
    translate(0, 75);
    sphere(12); // elbow
    rotateX(interpolate(max[4].x, min[4].x)); // elbow bend
    cylinder(12, 75, 25);
    popMatrix();

    // legs
    // left-u
    pushMatrix();
    translate(-25, 75);
    rotateX(interpolate(max[5].x, min[5].x)); // front/back
    rotateZ(interpolate(max[5].z, min[5].z)); // left/right
    rotateY(interpolate(max[5].y, min[5].y)); // foot
    cylinder(12, 75, 25);
    // left-l
    translate(0, 75);
    sphere(12); // knee
    rotateX(interpolate(max[6].x, min[6].x)); // knee bend
    cylinder(12, 75, 25);
    // left-foot
    translate(0, 75, 0);
    rotateX(interpolate(max[7].x, min[7].x)); // foot bend
    translate(0, 6, 13);
    box(25, 12, 50);
    popMatrix();
    // right-u
    pushMatrix();
    translate(25, 75);
    rotateX(interpolate(max[8].x, min[8].x)); // front/back
    rotateZ(-interpolate(max[8].z, min[8].z)); // out/up
    rotateY(-interpolate(max[8].y, min[8].y)); // foot
    cylinder(12, 75, 25);
    // right-l
    translate(0, 75);
    sphere(12); // knee
    rotateX(interpolate(max[9].x, min[9].x)); // knee bend
    cylinder(12, 75, 25);
    // right-foot
    translate(0, 75, 0);
    rotateX(interpolate(max[10].x, min[10].x)); // foot bend
    translate(0, 6, 13);
    box(25, 12, 50);
    popMatrix();

    //box(160, 50, 100);
    popMatrix();
}

// Watching for keypresses / user commands
void keyPressed()
{
    // Spin speed
    if (key == '+')
        speed += 0.005;
    else if (key == '-')
        speed -= 0.005;

    // default pose
    if (key == '0') {
        // Clear pose
        for (int i = 0; i < min.length; i++) {
            min[i] = new PVector();
            max[i] = new PVector();
        }
    }

    // pose 0 & 1
    if (key == 'f') {
        // Clear pose
        for (int i = 0; i < min.length; i++) {
            min[i] = new PVector();
            max[i] = new PVector();
        }

        // pose 0
        min[1] = new PVector(0, 0, PI/2);
        min[3] = new PVector(0, 0, PI/2);

        // pose 1
        max[3] = new PVector(PI/2, 0, PI/2);
        max[4] = new PVector(PI/2, 0, 0);
        max[8] = new PVector(PI/3, 0, 0);
    }

    // pose 0 & 2
    if (key == 'b') {
        // Clear pose
        for (int i = 0; i < min.length; i++) {
            min[i] = new PVector();
            max[i] = new PVector();
        }

        // pose 0
        min[1] = new PVector(0, 0, PI/2);
        min[3] = new PVector(0, 0, PI/2);

        // pose 2
        max[1] = new PVector(PI/2, 0, PI/2);
        max[2] = new PVector(PI/2, 0, 0);
        max[9] = new PVector(-PI/2, 0, 0);
    }

    // pose 3 & 4 (custom, cheering march?)
    if (key == 'n') {
        // Clear pose
        for (int i = 0; i < min.length; i++) {
            min[i] = new PVector();
            max[i] = new PVector();
        }

        // pose 3
        min[2] = new PVector(PI/3, 0, 0);
        min[3] = new PVector(PI/2, PI/6, PI/2);
        min[4] = new PVector(PI/2, 0, 0);
        min[8] = new PVector(2*PI/3, 0, 0);
        min[9] = new PVector(-2*PI/3, 0, 0);

        // pose 4
        max[1] = new PVector(-PI/3, 0, 0);
        max[2] = new PVector(PI/2, 0, 0);
        max[3] = new PVector(5*PI/6, 0, 0);
        max[5] = new PVector(2*PI/3, 0, 0);
        max[6] = new PVector(-2*PI/3, 0, 0);
    }
}

// Create a cylinder (radius, height, lod)
void cylinder(int r, int h, int vertices) {
    pushMatrix();
    // Create end cap
    rotateX(PI/2);
    circle(0, 0, 2*r);
    rotateX(-PI/2);
    // Shift so that origin is on one end
    translate(0, h/2);
    // Create cylinder walls
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i <= vertices; i++) {
        float angle = TWO_PI / vertices;
        float x = sin(i * angle);
        float z = cos(i * angle);

        vertex(x * r, -h/2, z * r);
        vertex(x * r, +h/2, z * r);
    }
    endShape(CLOSE);
    // Other end cap
    translate(0, h/2);
    rotateX(PI/2);
    circle(0, 0, 2*r);
    rotateX(-PI/2);
    popMatrix();
}

// Interpolate between max and min, then back to max. 120 frames/full loop
float interpolate(float max, float min) {
    if (frameCount % 120 + 1 <= 60)
        return ((frameCount % 60)/60.0) * (max - min) + min;
    return (1 - (frameCount % 60)/60.0) * (max - min) + min;
}
