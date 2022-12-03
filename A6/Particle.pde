// The Particle class

class Particle {
    // Params
    PVector position;
    float size;
    float speed;
    
    // Default constructor
    Particle(float x, float y, float z) {
        position = new PVector(x, y, z);
        size = 2;
        speed = 5;
    }

    // Copy constructor
    Particle(Particle p) {
        position = p.position.copy();
        size = p.size;
        speed = p.speed;
    }
}
