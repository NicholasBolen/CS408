// The Gas class

class Gas {
    // Params
    float density;
    PVector velocity;
    PVector position;

    // Default constructor
    Gas(int i, int j) {        
        int x = round(random(-1, 1) * 3);
        int y = round(random(-1, 1) * 3);
        float f = random(1);
        
        velocity = new PVector(x, y);
        position = new PVector(i, j);
        density = 0;
        if (f <= 0.05)
            density = round(random(1) * 100);
    }
};
