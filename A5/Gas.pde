// The Gas class

class Gas {
    // Params
    float density;
    PVector velocity;

    // Default constructor
    Gas(int a, float gasP) {
        float x = 0, y = 0;
        float f = 1;

        if (a != 0) {
            x = random(-1*a, a);
            y = random(-1*a, a);
            f = random(1);
        }

        velocity = new PVector(x, y);
        density = 0;
        if (f <= gasP)
            density = random(1) * 100;
    }
};
