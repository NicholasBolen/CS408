// CS408 - Assignment #num
// Nicholas Bolen
// #200455709

float[][] sandPile;
float angle = 0, rotX = 0, rotY = 0;
ArrayList<Particle> sand = new ArrayList<>();
PVector emitter;

/*
 TODO:
 - Use sand bmp texture
 - Add to poles based on closeness to each pole (weighted distribution of sand particles)
 - Also add to diagonals when piling
 - Adjustable emitter position
 - Partially transparent fluffy brown balls for falling sand
 
 Bugs:
 - Screen rotation is janky
 - Sand is not generated in centre of emitter
 - Sand is not absorbed upon impact, but slightly after
 
 Extra Features:
 - Adjustable particle "worth", size, and speed
 
 */


// Init
void setup()
{
    size(810, 810, P3D);
    emitter = new PVector(width/2, -height/3, width/2);
    frameRate(30);

    // Run with 1/10th the size (too computationally expensive otherwise)
    height /= 10;
    width /= 10;
    sandPile = new float[height][width];
}

// Draw on each frame
void draw()
{
    // Black background
    background(0);
    lights();
    stroke(255);
    rotateX(rotX);
    rotateY(rotY);
    ortho();

    // Top left of grid
    translate(0, 30*height/4, -height*10);

    // Draw sand pile
    drawSand();

    // Emitter
    pushMatrix();
    translate(emitter.x, emitter.y, emitter.z);
    noFill();
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
    for (int i = 0; i < sandPile.length - 1; i++) {
        for (int j = 0; j < sandPile[0].length - 1; j++) {
            beginShape();
            vertex(i*10, -sandPile[i][j], j*10);
            vertex(i*10+10, -sandPile[i+1][j], j*10);
            vertex(i*10+10, -sandPile[i+1][j+1], j*10+10);
            vertex(i*10, -sandPile[i][j+1], j*10+10);
            endShape();
        }
    }
}


void mouseDragged() {
    // rotate the viewport
    rotX=((float)mouseX/(float)width)*2*PI;
    rotY=((float)mouseY/(float)height)*2*PI;
}
