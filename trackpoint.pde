class Trackpoint {
  float xpos, ypos, size;
  color tpcolor = color(255);
  boolean selected = false;

  Trackpoint (float x, float y, float s) {
    xpos = x;
    ypos = y;
    size = s;
  }

  void setPosition(float x, float y) {
    xpos = x;
    ypos = y;
  }

  void setSize(float s) {
    size = s;
  }

  void setColor(int r, int g, int b) {
    tpcolor = color(r, g, b);
  }

  void render() {
    if (selected) {
      stroke(255, 0, 0);
      strokeWeight(3);
    } else {
      strokeWeight(1);
      noStroke();
    }
    fill(tpcolor);
    ellipse(xpos, ypos, size, size);
  }

  void touchStarted(float x, float y) {
    float dist = sqrt((xpos-x)*(xpos-x) + (ypos-y) * (ypos-y));
    if (dist < size) {
      selected = true;
    }
  }

  void touchEnded() {
    if (selected) {
      selected = false;
    }
  }

  void touchMoved(float x, float y) {
    if (selected) {
      xpos = x;
      ypos = y;
    }
  }
}
