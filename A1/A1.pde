// CS408 - Assignment 1
// Nicholas Bolen
// #200455709

// List of all particles
ArrayList<Particle> particles = new ArrayList<>();
// Controller particle
Particle control;
float baseAngle = 0;;

// Init
void setup()
{
    size(800, 600);
    frameRate(60);
    control = new Particle();
    particles.add(new Particle(control));
}

// Create new particle and call update function on each frame
void draw()
{
    background(0);
    Particle p2 = new Particle(control);
    
    // Apply Z rotation of baseAngle +- 30 degrees
    float angle = baseAngle + random(-PI/6, PI/6);
    // Rotation matrix
    float[][] a = {
        {cos(angle), -sin(angle), 0},
        {sin(angle), cos(angle), 0},
        {0, 0, 1}
    };
    // Apply rotation
    p2.direction = matrixToVec(matmul(a, p2.direction));
    
    particles.add(new Particle(p2));
    update(particles);
}

// Rendering and updating all particles
void update(ArrayList<Particle> ps)
{
    // Iterate over list backwards so we can delete particles without issue
    for (int i = ps.size() - 1; i >= 0; i--) {
        Particle p = ps.get(i);

        p.render(); // render before adjusting position so we display particles added this frame at 0,0
        p.age++;
        if (p.age >= 60)
            ps.remove(p);
        else
            p.position.add(PVector.mult(p.direction, p.speed));
    }
}

// Watching for keypresses / user commands
void keyPressed()
{
    // Colour components
    if (key == 'r' && control.r > 0)
        control.r--;
    else if (key == 'R' && control.r < 255)
        control.r++;
    if (key == 'g' && control.g > 0)
        control.g--;
    else if (key == 'G' && control.g < 255)
        control.g++;
    if (key == 'b' && control.b > 0)
        control.b--;
    else if (key == 'B' && control.b < 255)
        control.b++;
        
    // Transparency
    if (key == 't' && control.alpha > 0)
        control.alpha--;
    else if (key == 'T' && control.alpha < 255)
        control.alpha++;
    
    // Size
    if (key == '-' && control.size > 0)
        control.size--;
    else if (key == '+' && control.size < 200)
        control.size++;
    
    // Emitter position
    if (key == 'a' && control.position.x > 0)
        control.position.x--;
    else if (key == 'd' && control.position.x < width)
        control.position.x++;
    if (key == 'w' && control.position.y > 0)
        control.position.y--;
    else if (key == 's' && control.position.y < height)
        control.position.y++;
    
    // Speed
    if (keyCode == DOWN && control.speed > 0)
        control.speed--;
    else if (keyCode == UP && control.speed < 10)
        control.speed++;
    
    // Base angle / movement direction
    if (keyCode == LEFT)
        baseAngle -= 0.01;
    else if (keyCode == RIGHT)
        baseAngle += 0.01;
    
    // Shape
    if (key == 'h' && control.shape > 0)
        control.shape -= 0.5;
    else if (key == 'H' && control.shape < 3)
        control.shape += 0.5;
        
    // Reset
    if (key == '0') {
        control = new Particle();
        baseAngle = 0;
    }
}
