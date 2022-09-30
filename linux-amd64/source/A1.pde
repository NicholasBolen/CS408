// CS408 - Assignment 1
// Nicholas Bolen
// #200455709

// List of all particles
ArrayList<Particle> particles = new ArrayList<>();
// Controller particles
Particle control, control2, activeController;
Boolean secondaryEnabled = false, guidesEnabled = false;
float baseAngle = 0;

// Init
void setup()
{
    size(1440, 810);
    frameRate(60);
    control = new Particle();
    particles.add(new Particle(control));
    activeController = control;
}

// Create new particle and call update function on each frame
void draw()
{    
    // Black background
    background(0);
    
    // Create new particle
    Particle p2 = new Particle(control);
    
    // Creative feature - display if feature activated & currently selected controller
    String t;
    if (activeController == control)
        t = "1";
    else t = "2";
    if (secondaryEnabled) {
        noStroke();
        fill(0, 255, 0, 120);
        rect(10, 10, 40, 40);
        fill(255, 255, 255, 120);
        textSize(40);
        text(t, 20, 40); 
    }
    else {
        noStroke();
        fill(255, 0, 0, 120);
        rect(10, 10, 40, 40);
        fill(255, 255, 255, 120);
        textSize(40);
        text(t, 20, 40); 
    }
    
    // Creative feature - choose value within range if enabled
    if (secondaryEnabled) {
        p2.position = new PVector(
            round(urandom(control.position.x, control2.position.x)),
            round(urandom(control.position.y, control2.position.y))
        );
        p2.size = round(urandom(control.size, control2.size));
        p2.shape = urandom(control.shape, control2.shape);
        p2.r = round(urandom(control.r, control2.r));
        p2.g = round(urandom(control.g, control2.g));
        p2.b = round(urandom(control.b, control2.b));
        p2.speed = round(urandom(control.speed, control2.speed));
        p2.alpha = round(urandom(control.alpha, control2.alpha));
    }
    // Creative feature - otherwise, copy current primary values
    else control2 = new Particle(control);
    
    
    // Apply Z rotation of baseAngle +- 30 degrees
    float angle = baseAngle + random(-PI/6, PI/6);
    // Rotation matrix
    float[][] a = {
        {cos(angle), -sin(angle), 0},
        {sin(angle), cos(angle), 0},
        {0, 0, 1}
    };
    p2.direction = matrixToVec(matmul(a, p2.direction));
    
    // Add new particle and call update function
    particles.add(new Particle(p2));
    update(particles);
    
    
    // Creative feature - draw guide lines if enabled
    if (guidesEnabled)
    {
        control.renderOutline();
        if (secondaryEnabled) control2.renderOutline();
    }
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
    if (key == 'r' && activeController.r > 0)
        activeController.r--;
    else if (key == 'R' && activeController.r < 255)
        activeController.r++;
    if (key == 'g' && activeController.g > 0)
        activeController.g--;
    else if (key == 'G' && activeController.g < 255)
        activeController.g++;
    if (key == 'b' && activeController.b > 0)
        activeController.b--;
    else if (key == 'B' && activeController.b < 255)
        activeController.b++;
        
    // Transparency
    if (key == 't' && activeController.alpha > 0)
        activeController.alpha--;
    else if (key == 'T' && activeController.alpha < 255)
        activeController.alpha++;
    
    // Size
    if (key == '-' && activeController.size > 0)
        activeController.size--;
    else if (key == '+' && activeController.size < 200)
        activeController.size++;
    
    // Emitter position
    if (key == 'a' && activeController.position.x > 0)
        activeController.position.x -= 3;
    else if (key == 'd' && activeController.position.x < width)
        activeController.position.x += 3;
    if (key == 'w' && activeController.position.y > 0)
        activeController.position.y -= 3;
    else if (key == 's' && activeController.position.y < height)
        activeController.position.y += 3;
    
    // Speed
    if (keyCode == DOWN && activeController.speed > 0)
        activeController.speed--;
    else if (keyCode == UP && activeController.speed < 10)
        activeController.speed++;
    
    // Base angle / movement direction
    if (keyCode == LEFT)
        baseAngle -= 0.01;
    else if (keyCode == RIGHT)
        baseAngle += 0.01;
    
    // Shape
    if (key == 'h' && activeController.shape > 0.25)
        activeController.shape -= 0.25;
    else if (key == 'H' && activeController.shape < 4)
        activeController.shape += 0.25;
        
    
    // Creative Feature
    // Reset
    if (key == '0') {
        control = new Particle();
        control2 = new Particle(control);
        secondaryEnabled = false;
        activeController = control;
        guidesEnabled = false;
        baseAngle = 0;
    }
    
    // Edit primary controller
    if (key == '1') {
        activeController = control;
    }
    
    // Edit secondary controller
    if (key == '2' && secondaryEnabled) {
        activeController = control2;
    }
    
    // Enable/disable secondary controller
    if (key == '3') {
        secondaryEnabled = !secondaryEnabled;
        activeController = control;
    }
    
    // Enable/disable guides
    if (key == '4') {
        guidesEnabled = !guidesEnabled;
    }
}
