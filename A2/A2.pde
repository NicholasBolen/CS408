// CS408 - Assignment 2 //<>//
// Nicholas Bolen
// #200455709

// Animation instructions
String[] anim;
// Objects
PShape[] objs = new PShape[100];
// Keyframes
KeyFrame[][] frames = new KeyFrame[100][100]; // 1D = Object, 2D = Keyframe/timeline

// Init
void setup()
{
    //size(1440, 810);
    size(640, 360, P3D);
    frameRate(60);
    
    // Camera settings
    perspective(radians(60), float(width) / float(height), 1, 1000);
    
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
           append(frames[int(t[1])], new KeyFrame(float(subset(t, 2))));
    }
}

float ry;
// Draw each frame
void draw()
{
    // Black background
    background(0);
    lights();

    // Camera offset
    translate(width/2 - 7, height/2 + 100, -7);

    // Translation
    translate(1, 2, 3);
    
    // Rotation (radians, or radians(degrees))
    rotateX(0);
    rotateY(ry);
    rotateZ(PI);
    
    scale(50);
    // Scaling (%)
    scale(1, 1, 1);
    
    shape(objs[0]);
    
    ry += 0.02;
}
