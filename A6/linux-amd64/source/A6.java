/* autogenerated by Processing revision 1286 on 2022-12-08 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class A6 extends PApplet {

// CS408 - Assignment 6
// Nicholas Bolen
// #200455709

float[][] sandPile;
float rotX = 0, rotY = 0, zoom = 1;    // Creative Feature - rotate and zoom scene
float size = 5, weight = 5;    // Creative Feature - particle size and weight
ArrayList<Particle> sand = new ArrayList<>();
PVector emitter, emitterC;
PImage sandTexture;

// Init
 public void setup()
{
    /* size commented out by preprocessor */;
    frameRate(60);
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
 public void draw()
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

    // Creative Feature - Rotate scene
    scale(zoom);
    rotateX(rotX);
    rotateY(rotY);

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
        sphere(size);
        popMatrix();
    }

    // Update all sand
    updateSand();
}

// Function that smooths sandpile, absorbs falling sand, and moves falling sand particles 
 public void updateSand() {
    // Sand spread
    for (int i = 0; i < sandPile.length; i++) {
        for (int j = 0; j < sandPile[0].length; j++) {
            // If not along left side
            if (i != 0) {
                if (sandPile[i-1][j] - sandPile[i][j] < -(1.0f/3)*10) {
                    sandPile[i-1][j] += 1;
                    sandPile[i][j] -= 1;
                }
            }
            // If not along right side
            if (i != sandPile.length - 1) {
                if (sandPile[i+1][j] - sandPile[i][j] < -(1.0f/3)*10) {
                    sandPile[i+1][j] += 1;
                    sandPile[i][j] -= 1;
                }
            }
            // If not along top side
            if (j != 0) {
                if (sandPile[i][j-1] - sandPile[i][j] < -(1.0f/3)*10) {
                    sandPile[i][j-1] += 1;
                    sandPile[i][j] -= 1;
                }
            }
            // If not along bottom side
            if (j != sandPile[0].length - 1) {
                if (sandPile[i][j+1] - sandPile[i][j] < -(1.0f/3)*10) {
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
        p.position.y += 5;
        // Match origins (-405, -405 => 0, 0)
        p.position.x += height*5;
        p.position.z += height*5;

        // Find surrounding squares
        if (
            0 <= p.position.y + sandPile[PApplet.parseInt(p.position.x/10)][PApplet.parseInt(p.position.z/10)] ||
            0 <= p.position.y + sandPile[PApplet.parseInt(p.position.x/10)+1][PApplet.parseInt(p.position.z/10)] ||
            0 <= p.position.y + sandPile[PApplet.parseInt(p.position.x/10)+1][PApplet.parseInt(p.position.z/10)+1] ||
            0 <= p.position.y + sandPile[PApplet.parseInt(p.position.x/10)][PApplet.parseInt(p.position.z/10)+1]
            ) {
            // Distribute weight by closeness to poles
            float xR = p.position.x/10 - PApplet.parseInt(p.position.x/10);
            float zR = p.position.z/10 - PApplet.parseInt(p.position.z/10);
            sandPile[PApplet.parseInt(p.position.x/10)][PApplet.parseInt(p.position.z/10)] += weight * ((2 - xR - zR)/2);
            sandPile[PApplet.parseInt(p.position.x/10)+1][PApplet.parseInt(p.position.z/10)] += weight * ((xR + 1 - zR)/2);
            sandPile[PApplet.parseInt(p.position.x/10)+1][PApplet.parseInt(p.position.z/10)+1] += weight * ((xR + zR)/2);
            sandPile[PApplet.parseInt(p.position.x/10)][PApplet.parseInt(p.position.z/10)+1] += weight * ((1 - xR + zR)/2);
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
 public void drawSand() {
    pushMatrix();
    translate(-height*5, 0, -height*5);
    textureMode(NORMAL);
    for (int i = 0; i < sandPile.length - 1; i++) {
        for (int j = 0; j < sandPile[0].length - 1; j++) {
            beginShape();
            texture(sandTexture);
            vertex(i*10, -sandPile[i][j], j*10, i/(sandPile.length - 1.0f), j/(sandPile[0].length - 1.0f));
            vertex(i*10+10, -sandPile[i+1][j], j*10, (i+1)/(sandPile.length - 1.0f), j/(sandPile[0].length - 1.0f));
            vertex(i*10+10, -sandPile[i+1][j+1], j*10+10, (i+1)/(sandPile.length - 1.0f), (j+1)/(sandPile[0].length - 1.0f));
            vertex(i*10, -sandPile[i][j+1], j*10+10, i/(sandPile.length - 1.0f), (j+1)/(sandPile[0].length - 1.0f));
            endShape();
        }
    }
    popMatrix();
}

// Detect keypresses
 public void keyPressed() {
    // Move emitter
    if (key == 'w')
        emitterC.z = -1;
    if (key == 's')
        emitterC.z = 1;
    if (key == 'a')
        emitterC.x = -1;
    if (key == 'd')
        emitterC.x = 1;
    
    // Creative Feature - zoom in/out
    if (key == '+')
        zoom += 0.5f;
    if (key == '-')
        zoom -= 0.5f;
        
    // Creative Feature - reset
    if (key == '0') {
        frameCount = 0;
        sandPile = new float[height][width];
        sand = new ArrayList<>();
    }
    
    // Creative Feature - control sand size
    if (key == 'X')
        size++;
    else if (key == 'x' && size > 0)
        size--;
    
    // Creative Feature - control sand weight/worth
    if (key == 'C')
        weight++;
    else if (key == 'c' && weight > 0)
        weight--; 
}

// Detect keyreleases
 public void keyReleased() {
    // Move emitter
    if (key == 'w' || key == 's')
        emitterC.z = 0;
    if (key == 'a' || key == 'd')
        emitterC.x = 0;
}

// Creative Feature - rotate scene with mouse
 public void mouseDragged() {
    // rotate the viewport
    rotX = ((float)mouseY/(float)width)*PI;
    rotY = -((float)mouseX/(float)height)*PI;
}
// The Particle class

class Particle {
    // Params
    PVector position;
    
    // Default constructor
    Particle(float x, float y, float z) {
        position = new PVector(x, y, z);
    }
}


    public void settings() { size(810, 810, P3D); }

    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "A6" };
        if (passedArgs != null) {
            PApplet.main(concat(appletArgs, passedArgs));
        } else {
            PApplet.main(appletArgs);
        }
    }
}