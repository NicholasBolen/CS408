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
    int alpha;

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
        
        // Clockwise corner -> edge -> corner -> edge -> ... starting top left
        beginShape();
        vertex(position.x - size/2, position.y - size/2);
        vertex(position.x - shape*size/2, position.y);
        vertex(position.x - size/2, position.y + size/2);
        vertex(position.x, position.y + shape*size/2);
        vertex(position.x + size/2, position.y + size/2);
        vertex(position.x + shape*size/2, position.y);
        vertex(position.x + size/2, position.y - size/2);
        vertex(position.x, position.y - shape*size/2);
        endShape(CLOSE);
    }
    
    // Draw outline function
    void renderOutline() {
        strokeCap(SQUARE);
        strokeWeight(size / 10);
        stroke(r, g, b, alpha);
        noFill();
        
        // Clockwise corner -> edge -> corner -> edge -> ... starting top left
        beginShape();
        vertex(position.x - size/2, position.y - size/2);
        vertex(position.x - shape*size/2, position.y);
        vertex(position.x - size/2, position.y + size/2);
        vertex(position.x, position.y + shape*size/2);
        vertex(position.x + size/2, position.y + size/2);
        vertex(position.x + shape*size/2, position.y);
        vertex(position.x + size/2, position.y - size/2);
        vertex(position.x, position.y - shape*size/2);
        endShape(CLOSE);
    }
}
