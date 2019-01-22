/**
 * ControlP5 Canvas
 *
 * by andreas schlegel, 2011
 * www.sojamo.de/libraries/controlp5
 * 
 */

import controlP5.*;

ControlP5 cp5;
Accordion accordion;
ControlFrame cf;

void settings() {
  size(400, 600);
}


void setup() {
  cf = new ControlFrame(this, 400, 800, "Controls");
  surface.setResizable(true);
  surface.setLocation(420, 50);
  smooth();

  cp5 = new ControlP5(this);

  Group g1 = cp5.addGroup("Gauge1")
    .setBackgroundColor(color(50, 64))
    .setBackgroundHeight(250)
    ;

  cp5.addGroup("TestGauge")
    .setPosition(0, 50)
    .setWidth(200)
    .moveTo(g1)
    .hideBar()
    .addCanvas(new TestCanvas())
    ;

  Group g2 = cp5.addGroup("Gauge2")
    .setBackgroundColor(color(50, 64))
    .setBackgroundHeight(250)
    ;

  cp5.addGroup("TestGauge2")
    .setPosition(0, 50)
    .setWidth(200)
    .moveTo(g2)
    .hideBar()
    .addCanvas(new TestCanvas2())
    ;

  accordion = cp5.addAccordion("acc")
    .setPosition(40, 40)
    .setWidth(200)
    .addItem(g1)
    .addItem(g2)
    ;

  accordion.setCollapseMode(Accordion.MULTI);
}

void draw() {
  background(0);
}
