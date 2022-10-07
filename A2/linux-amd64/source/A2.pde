// CS408 - Assignment 2
// Nicholas Bolen
// #200455709

// Animation instructions
String[] anim;
// Objects
PShape[] objs;
// Keyframes
KeyFrame[][] frames; // 1D = Object, 2D = Keyframe/timeline
int animLength = 0;

// CREATIVE FEATURE
int sizeScale = 1;
Boolean looping = false;

// Init
void setup()
{
    size(1440, 810, P3D);
    frameRate(60);

    // Load animation from file
    anim = loadStrings("animation.txt");

    init();
}

// CREATIVE FEATURE - separated out to support looping
void init()
{
    objs = new PShape[100];
    frames = new KeyFrame[100][0];

    // Camera settings
    perspective(radians(60), float(width) / float(height), 1, 1000 * sizeScale);

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
        else if (t[0].equals("KEYFRAME")) {
            frames[int(t[1])] = (KeyFrame[])append(frames[int(t[1])], new KeyFrame(float(subset(t, 2))));
            if (int(t[2]) > animLength)
                animLength = int(t[2]);
        }
    }

    // Log before first key frame
    for (int i = 0; i < objs.length; i++)
        if (objs[i] != null)
            println(i, frameCount, "Object does not exist");
}


// Draw each frame
void draw()
{
    // Black background
    background(0);
    lights();

    // Camera offset
    translate(width/2 - 7, height/2 + 100, -7);
    scale(sizeScale);

    int i = 0;
    // Loop through objects
    for (KeyFrame[] k : frames) {
        pushMatrix();
        KeyFrame diff;

        // Animation left for this object and should be currently displayed
        if (k.length > 1 && k[0].frame <= frameCount) {
            // Diff between keyframe 1 and 0
            diff = k[1].sub(k[0]);

            // Error handling
            if (diff.frame < 0) {
                println("ERROR : Time for key frame less than time for previous keyframe on object", i);
                exit();
            }

            // Calculate current display params
            int progress = frameCount - k[0].frame;
            int total = diff.frame;
            float ratio = float(progress) / float(total);

            // Linear Interpolation
            // position = diff * ratio + start_pos
            diff.position.mult(ratio);
            diff.position.add(k[0].position);
            // Invert y (to match openGL axis)
            diff.position.y *= -1;

            // Rotation
            diff.rotation.mult(ratio);
            diff.rotation.add(k[0].rotation);

            // Scale
            diff.scale.mult(ratio);
            diff.scale.add(k[0].scale);

            // Remove old frame
            if (k[1].frame <= frameCount)
                frames[i] = (KeyFrame[])subset(k, 1);
        }
        // No animation left for this object
        else {
            popMatrix();
            i++;
            continue;
        }

        // Translation
        translate(diff.position.x, diff.position.y, diff.position.z);

        // Rotation (radians, or radians(degrees))
        rotateX(diff.rotation.x);
        rotateY(diff.rotation.y);
        rotateZ(diff.rotation.z);

        // Scaling (%)
        scale(diff.scale.x, diff.scale.y, diff.scale.z);


        // Log object info
        println(i, frameCount, diff.position, diff.rotation, diff.scale);

        // Draw object
        if (objs[i] != null)
            shape(objs[i]);
        else {
            println("ERROR : Undefined object ID referenced, #", i);
            exit();
        }

        popMatrix();
        i++;
    }

    if (frameCount >= animLength) {
        for (i = 0; i < objs.length; i++)
            if (objs[i] != null)
                println(i, frameCount, "Object does not exist");

        // CREATIVE FEATURE - loop if looping enabled
        if (looping) {
            frameCount = 0;
            init();
        } else exit();
    }
}

// CREATIVE FEATURE - Watching for keypresses / user commands
void keyPressed()
{
    // Size Scale
    if (key == '+')
        sizeScale++;
    else if (key == '-' && sizeScale > 1)
        sizeScale--;

    // Looping
    if (key == 'L')
        looping = true;
    else if (key == 'l')
        looping = false;
}
