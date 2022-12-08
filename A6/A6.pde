// CS408 - Assignment #num
// Nicholas Bolen
// #200455709

float[][] sandPile;
float angle = 0, rotX = 0, rotY = 0;
ArrayList<Particle> sand = new ArrayList<>();
PVector emitter, emitterC;
PImage sandTexture;

/*
 TODO:
 - Add to poles based on closeness to each pole (weighted distribution of sand particles)
 - Also add to diagonals when piling
 - Partially transparent fluffy brown balls for falling sand
 
 Bugs:
 - Sand is not generated in centre of emitter
 - Sand is not absorbed upon impact, but slightly after
 
 Extra Features:
 - Adjustable particle "worth", size, and speed
 
 */


// Init
void setup()
{
    size(810, 810, P3D);
    frameRate(30);
    sandTexture = loadImage("sand.bmp");
    
    // Emitter position and controller
    emitter = new PVector(0, -height/3, 0);
    emitterC = new PVector();

    // Run with 1/10th the size (too computationally expensive otherwise)
    height /= 10;
    width /= 10;
    sandPile = new float[height][width];
}

// Draw on each frame
void draw()
{
    // Move emitter
    emitter.x += emitterC.x;
    emitter.y += emitterC.y;
    emitter.z += emitterC.z;
    
    // Black background
    background(0);
    lights();
    
    // Find origin
    translate(0, 30*height/4, -height*10);
    translate(height*5, 0, height*5);
    
    // Apply rotation
    rotateX(rotX);
    rotateY(rotY);
    
    // Draw sand pile
    noStroke();
    fill(128, 64, 0, 255);
    drawSand();
    
    // Emitter
    pushMatrix();
    translate(emitter.x, emitter.y, emitter.z);
    noFill();
    strokeWeight(1);
    box(50);    // emitter
    fill(255);
    popMatrix();
    // Add sand particle
    if (frameCount % 30 == 0)
        sand.add(new Particle(emitter.x, emitter.y, emitter.z));


    // Draw falling sand
    translate(0, -height*5, 0);
    for (Particle p : sand) {
        pushMatrix();
        translate(p.position.x, p.position.y + 400, p.position.z);
        // partially transparent brown balls
        fill(128, 64, 0, 255);
        sphere(p.size);
        popMatrix();
    }



    // Update all sand
    updateSand();
}

void updateSand() {
    // Sand spread
    for (int i = 0; i < sandPile.length; i++) {
        for (int j = 0; j < sandPile[0].length; j++) {
            // If not along left side
            if (i != 0) {
                if (sandPile[i-1][j] - sandPile[i][j] < -(1.0/3)*10) {
                    sandPile[i-1][j] += 1;
                    sandPile[i][j] -= 1;
                }
            }
            // If not along right side
            if (i != sandPile.length - 1) {
                if (sandPile[i+1][j] - sandPile[i][j] < -(1.0/3)*10) {
                    sandPile[i+1][j] += 1;
                    sandPile[i][j] -= 1;
                }
            }
            // If not along top side
            if (j != 0) {
                if (sandPile[i][j-1] - sandPile[i][j] < -(1.0/3)*10) {
                    sandPile[i][j-1] += 1;
                    sandPile[i][j] -= 1;
                }
            }
            // If not along bottom side
            if (j != sandPile[0].length - 1) {
                if (sandPile[i][j+1] - sandPile[i][j] < -(1.0/3)*10) {
                    sandPile[i][j+1] += 1;
                    sandPile[i][j] -= 1;
                }
            }
        }
    }

    // Move & absorb sand
    int i = 0;
    ArrayList<Particle> c = new ArrayList<>(sand);
    for (Particle p : c) {
        // Move
        p.position.y += p.speed;

        // Find surrounding squares
        if (sandPile[int(p.position.x/10)][int(p.position.z/10)] < p.position.y ||
            sandPile[int(p.position.x/10)+1][int(p.position.z/10)] < p.position.y ||
            sandPile[int(p.position.x/10)+1][int(p.position.z/10)+1] < p.position.y ||
            sandPile[int(p.position.x/10)][int(p.position.z/10)+1] < p.position.y) {
            sandPile[int(p.position.x/10)][int(p.position.z/10)] += 1;
            sandPile[int(p.position.x/10)+1][int(p.position.z/10)] += 1;
            sandPile[int(p.position.x/10)+1][int(p.position.z/10)+1] += 1;
            sandPile[int(p.position.x/10)][int(p.position.z/10)+1] += 1;
            sand.remove(i);
        }
        i++;
    }
}

// Draws sand pile
void drawSand() {
    pushMatrix();
    translate(-height*5, 0, -height*5);
    textureMode(NORMAL);
    for (int i = 0; i < sandPile.length - 1; i++) {
        for (int j = 0; j < sandPile[0].length - 1; j++) {
            beginShape();
            texture(sandTexture);
            vertex(i*10, -sandPile[i][j], j*10, i/(sandPile.length - 1.0), j/(sandPile[0].length - 1.0));
            vertex(i*10+10, -sandPile[i+1][j], j*10, (i+1)/(sandPile.length - 1.0), j/(sandPile[0].length - 1.0));
            vertex(i*10+10, -sandPile[i+1][j+1], j*10+10, (i+1)/(sandPile.length - 1.0), (j+1)/(sandPile[0].length - 1.0));
            vertex(i*10, -sandPile[i][j+1], j*10+10, i/(sandPile.length - 1.0), (j+1)/(sandPile[0].length - 1.0));
            endShape();
        }
    }
    popMatrix();
}

void keyPressed() {
    // Move emitter
    if (key == 'w')
        emitterC.z = -1;
    if (key == 's')
        emitterC.z = 1;
    if (key == 'a')
        emitterC.x = -1;
    if (key == 'd')
        emitterC.x = 1;
}

void keyReleased() {
    // Move emitter
    if (key == 'w' || key == 's')
        emitterC.z = 0;
    if (key == 'a' || key == 'd')
        emitterC.x = 0;
}

void mouseDragged() {
    // rotate the viewport
    rotX=((float)mouseY/(float)width)*PI;
    rotY=-((float)mouseX/(float)height)*PI;
}
