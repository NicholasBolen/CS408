// The KeyFrame class

class KeyFrame {
    // Vars
    int frame;
    PVector position;
    PVector rotation;
    PVector scale;
    
    KeyFrame(float[] t) {
        frame = int(t[0]);
        position = new PVector(t[1], t[2], t[3]);
        rotation = new PVector(t[4], t[5], t[6]);
        scale = new PVector(t[7], t[8], t[9]);
    }
}
