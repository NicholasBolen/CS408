// CS408 - Assignment 2 //<>//
// Nicholas Bolen
// #200455709

// Hold animation instructions
String[] anim;
// Hold objects
PShape[] objs = new PShape[100];
// Hold keyframes
// 2D array, 1D = Object, 2D = Keyframe/timeline
// Alternatively, use a Set?

// Init
void setup()
{
    //size(1440, 810);
    size(640, 360, P3D);
    frameRate(60);

    // Load animation from file
    anim = loadStrings("animation.txt");

    // Process instructions
    for (String a : anim) {
        // tokenize
        String[] t = splitTokens(a);
        // skip empty lines
        if (t.length == 0)
            continue;

        // Load all objects
        if (t[0].equals("OBJECT"))
            objs[int(t[1])] = loadShape(t[2]);
        // Store all keyframes
        else if (t[0].equals("KEYFRAME"))
            break;
    }
}

float ry;
// Draw each frame
void draw()
{
    // Black background
    background(0);
    lights();

    translate(width/2, height/2 + 100, -200);
    rotateZ(PI);
    rotateY(ry);
    
    scale(30);
    shape(objs[0]);
    
    ry += 0.02;

}
