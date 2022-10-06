// The KeyFrame class

class KeyFrame {
    // Vars
    int frame;
    PVector position;
    PVector rotation;
    PVector scale;
    
    // Construct from input format
    KeyFrame(float[] t) {
        frame = int(t[0]);
        position = new PVector(t[1], t[2], t[3]);
        rotation = new PVector(t[4], t[5], t[6]);
        scale = new PVector(t[7], t[8], t[9]);
    }
    
    // Copy constructor
    KeyFrame(KeyFrame k) {
        this.frame = k.frame;
        this.position = k.position.copy();
        this.rotation = k.rotation.copy();
        this.scale = k.scale.copy();
    }
    
    // Get value difference between two keyframes, 
    KeyFrame sub(KeyFrame k) {
        KeyFrame n = new KeyFrame(this);
        
        n.frame = this.frame - k.frame;
        n.position.sub(k.position);
        n.rotation.sub(k.rotation);
        n.scale.sub(k.scale);
        
        return n;
    }
}
