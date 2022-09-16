// The Particle class

class Particle {
    // Params
    PVector position;
    PVector direction;
    int size;
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
        r = 255;
        g = 255;
        b = 0;
        speed = 5;
        age = 0;
        alpha = 255;
    }

    // Copy constructor
    Particle(Particle p) {
        position = p.position.copy();
        direction = p.direction.copy();
        size = p.size;
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
    }
}
