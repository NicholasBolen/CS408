// The Particle class

class Particle {
    // Params
    PVector position;
    PVector direction;
    int size;
    float shape;
    int r;
    int g;
    int b;
    int speed;
    int age;
    float alpha;

    // Default constructor
    Particle() {
        position = new PVector(width / 2, height / 2);
        direction = new PVector(1, 0);
        size = 100;
        shape = 1;
        r = 64; // ~25% of 255
        g = 64;
        b = 64;
        speed = 5;
        age = 0;
        alpha = 255;
    }

    // Copy constructor
    Particle(Particle p) {
        position = p.position.copy();
        direction = p.direction.copy();
        size = p.size;
        shape = p.shape;
        r = p.r;
        g = p.g;
        b = p.b;
        speed = p.speed;
        age = p.age;
        alpha = p.alpha;
    }

    // Draw function
    void render() {
        noStroke();
        fill(r, g, b, alpha);
        rect(position.x - size/2, position.y - size/2, size, size);
        
        /* 3D & Shape prep
        
        stroke(255);
        strokeWeight(5);
        PVector center = new PVector(position.x, position.y);
        
        // center
        point(position.x, position.y);
        
        // constant corners
        beginShape();
        vertex(position.x-size/2, position.y-size/2);
        vertex(position.x-size/2, position.y+size/2);
        vertex(position.x+size/2, position.y+size/2);
        vertex(position.x+size/2, position.y-size/2);
        endShape(CLOSE);
        
        // edge points
        point(position.x+size/2, position.y);
        point(position.x-size/2, position.y);
        point(position.x, position.y+size/2);
        point(position.x, position.y-size/2);
        
        triangle(position.x, position.y, position.x-size, position.y-size, position.x+size, position.y-size);
        */
    }
}
