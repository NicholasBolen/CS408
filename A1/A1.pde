// CS408 - Assignment 1 //<>//
// Nicholas Bolen
// #200455709

// List of all particles
ArrayList<Particle> particles = new ArrayList<>();
// Controller particle
Particle control;

// Init
void setup()
{
    size(800, 600);
    frameRate(30);
    control = new Particle();
    particles.add(new Particle(control));
}

// Create new particle and call update function on each frame
void draw()
{
    background(0);
    particles.add(new Particle(control));
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
