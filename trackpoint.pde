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
      noStroke();
    }

    if (markerType == 1) {
      fill(markerColor1);
      ellipse(xpos, ypos, size, size);
      fill(markerColor2);
      arc(xpos, ypos, size, size, 0, HALF_PI, PIE);
      arc(xpos, ypos, size, size, PI, PI+HALF_PI, PIE);
    } else if (markerType == 2) {
      stroke(markerColor1);
      strokeWeight(3);
      noFill();
      ellipse(xpos, ypos, size, size);
      line(xpos - 0.5 * size, ypos, xpos + 0.5 * size, ypos);
      line(xpos, ypos - 0.5 * size, xpos, ypos + 0.5 * size);
    } else if (markerType == 3) {
      stroke(markerColor1);
      strokeWeight(3);
      noFill();
      line(xpos - 0.5 * size, ypos, xpos + 0.5 * size, ypos);
      line(xpos, ypos - 0.5 * size, xpos, ypos + 0.5 * size);
    }
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
