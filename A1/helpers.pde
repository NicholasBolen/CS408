// Pick random value between a and b, independant of order passed
float urandom(float a, float b) {
    if(a > b)
        return random(b, a);
    return random(a, b);
}
