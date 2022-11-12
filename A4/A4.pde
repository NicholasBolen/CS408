// CS408 - Assignment 4
// Nicholas Bolen
// #200455709

float angle = 0;

// Init
void setup()
{
    size(810, 810, P3D);
    frameRate(30);
    lights();
}

// Draw on each frame
void draw()
{
    angle += 0.02;
    translate(width/2, height/2);
    rotateX(angle/2);
    rotateY(angle);
    rotateZ(angle*1.5);
    pushMatrix();
    
    // Black background
    background(123);
    fill(255, 255, 0);
    //noFill();

    // Character
    // body
    cylinder(50, 200, 25);
    // neck
    pushMatrix();
    translate(0, -110);
    cylinder(10, 20, 25);
    popMatrix();
    // head
    pushMatrix();
    translate(0, -170);
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
    cylinder(12, 50, 25);
    // left-l
    translate(0, 50);
    cylinder(12, 50, 25);
    popMatrix();
    // right-u
    pushMatrix();
    translate(62, -70);
    //rotateZ(-PI/3);
    cylinder(12, 50, 25);
    // left-l
    translate(0, 50);
    cylinder(12, 50, 25);
    popMatrix();
    
    // legs
    // left-u
    pushMatrix();
    translate(-25, 125);
    cylinder(12, 50, 25);
    // left-l
    translate(0, 50);
    cylinder(12, 50, 25);
    // left-foot
    translate(0, 31, 13);
    box(25, 12, 50);
    popMatrix();
    // right-u
    pushMatrix();
    translate(25, 125);
    cylinder(12, 50, 25);
    // right-l
    translate(0, 50);
    cylinder(12, 50, 25);
    // right-foot
    translate(0, 31, 13);
    box(25, 12, 50);
    popMatrix();
    
    //box(160, 50, 100);
    popMatrix();
}

void cylinder(int r, int h, int vertices) {
    beginShape(TRIANGLE_STRIP);

    for (int i = 0; i <= vertices; i++) {
        float angle = TWO_PI / vertices;
        float x = sin(i * angle);
        float z = cos(i * angle);

        vertex(x * r, -h/2, z * r);
        vertex(x * r, +h/2, z * r);
    }
    endShape(CLOSE);
}
