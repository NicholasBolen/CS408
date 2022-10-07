// CS408 - Assignment 2
// Nicholas Bolen
// #200455709

// Animation instructions
String[] anim;
// Objects
PShape[] objs = new PShape[100];
// Keyframes
KeyFrame[][] frames = new KeyFrame[100][0]; // 1D = Object, 2D = Keyframe/timeline



/* TODO
 * print current object info
 * bug with multiple objects
 * 
 * Creative Feature
 * - looping (move init stuff to seperate function that can be called at end of draw() after anim finished?)
 * - speed scale / frame rate
 * - size scale with +/-
 */

// Init
void setup()
{
    size(1440, 810, P3D);
    //size(640, 360, P3D);
    frameRate(30);

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
        else if (t[0].equals("KEYFRAME")) {
            frames[int(t[1])] = (KeyFrame[])append(frames[int(t[1])], new KeyFrame(float(subset(t, 2))));
        }
    }
}

// Draw each frame
void draw()
{
    // Black background
    background(0);
    lights();

    // Camera offset
    translate(width/2 - 7, height/2 + 100, -7);
    scale(10);
    
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
            if (k[1].frame <= frameCount + 1) {
                frames[i] = (KeyFrame[])subset(k, 1);
            }
        }
        // No animation left for this object
        else {
            popMatrix();
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

        // Draw object
        if(objs[i] != null)
            shape(objs[i]);
        else {
            println("ERROR : Undefined object ID referenced, #", i);
            exit();
        }
        
        popMatrix();
        i++;
    }
}
