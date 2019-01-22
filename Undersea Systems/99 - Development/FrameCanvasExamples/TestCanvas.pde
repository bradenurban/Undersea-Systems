class TestCanvas extends Canvas {

  float n;
  float a;

  public void setup(PGraphics pg) {
    println("starting a test canvas.");
    n = 1;
  }
  public void draw(PGraphics pg) {
    n += 0.01;
    pg.ellipseMode(CENTER);
    pg.fill(lerpColor(color(0, 100, 200), color(0, 200, 100), map(sin(n), -1, 1, 0, 1)));
    pg.rect(0, 0, 200, 200);
    pg.fill(255, 150);
    a+=0.01;
    ellipse(100, 100, abs(sin(a)*150), abs(sin(a)*150));
    ellipse(40, 40, abs(sin(a+0.5)*50), abs(sin(a+0.5)*50));
    ellipse(60, 140, abs(cos(a)*80), abs(cos(a)*80));
  }
}
