// CS408 - Assignment #num
// Nicholas Bolen
// #200455709

float[][] sandPile;
ArrayList<Particle> sand = new ArrayList<>();
PVector emitter, emitterC;
PImage sandTexture;

// Init
void setup()
{
    size(810, 810, P3D);
    frameRate(100);
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
    if (emitter.x <= -410 && emitterC.x < 0) emitterC.x = 0;
    if (emitter.x >= 394 && emitterC.x > 0) emitterC.x = 0;
    if (emitter.z <= -410 && emitterC.z < 0) emitterC.z = 0;
    if (emitter.z >= 394 && emitterC.z > 0) emitterC.z = 0;
    emitter.x += emitterC.x;
    emitter.y += emitterC.y;
    emitter.z += emitterC.z;

    // Black background
    background(0);
    lights();

    // Find origin
    translate(0, 30*height/4, -height*10);
    translate(height*5, 0, height*5);

    // Draw sand pile
    fill(255);
    noStroke();
    drawSand();

    // Draw emitter
    noFill();
    stroke(255);
    strokeWeight(1);
    pushMatrix();
    translate(emitter.x, emitter.y, emitter.z);
    box(50);    // emitter
    popMatrix();

    // Add sand particle
    if (frameCount % 30 == 0)
        sand.add(new Particle(emitter.x, emitter.y, emitter.z));

    // Draw falling sand
    for (Particle p : sand) {
        pushMatrix();
        translate(p.position.x, p.position.y, p.position.z);
        noStroke();
        // partially transparent brown balls
        fill(105, 80, 47, 200);
        sphere(p.size);
        popMatrix();
    }

    // Update all sand
    updateSand();
}

// Function that smooths sandpile, absorbs falling sand, and moves falling sand particles
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
        // Match origins (-405, -405 => 0, 0)
        p.position.x += height*5;
        p.position.z += height*5;

        // Find surrounding squares
        if (
            0 <= p.position.y + sandPile[int(p.position.x/10)][int(p.position.z/10)] ||
            0 <= p.position.y + sandPile[int(p.position.x/10)+1][int(p.position.z/10)] ||
            0 <= p.position.y + sandPile[int(p.position.x/10)+1][int(p.position.z/10)+1] ||
            0 <= p.position.y + sandPile[int(p.position.x/10)][int(p.position.z/10)+1]
            ) {
            // Distribute weight by closeness to poles
            float xR = p.position.x/10 - int(p.position.x/10);
            float zR = p.position.z/10 - int(p.position.z/10);
            sandPile[int(p.position.x/10)][int(p.position.z/10)] += p.size * ((2 - xR - zR)/2);
            sandPile[int(p.position.x/10)+1][int(p.position.z/10)] += p.size * ((xR + 1 - zR)/2);
            sandPile[int(p.position.x/10)+1][int(p.position.z/10)+1] += p.size * ((xR + zR)/2);
            sandPile[int(p.position.x/10)][int(p.position.z/10)+1] += p.size * ((1 - xR + zR)/2);
            // Remove particle
            sand.remove(i);
        }
        // Restore coordinates (0, 0 => -405, -405)
        p.position.x -= height*5;
        p.position.z -= height*5;
        i++;
    }
}

// Draw sand pile
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

// Detect keypresses
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

// Detect keyreleases
void keyReleased() {
    // Move emitter
    if (key == 'w' || key == 's')
        emitterC.z = 0;
    if (key == 'a' || key == 'd')
        emitterC.x = 0;
}
