import select.files.*;

SelectLibrary files;



color bgCol = color(0, 255, 0);
Trackpoint t1, t2;
Configview configview;
boolean configMode = false;
boolean oneClickActive = false;
float clickRef = millis();
float clickTimer = 500;
boolean grantedRead = false;
boolean grantedWrite = false;

void setup() {
  fullScreen();
  t1 = new Trackpoint(0.5 * width, 0.8 * height, 0.2 * width);
  t2 = new Trackpoint(0.5 * width, 0.2 * height, 0.2 * width);
  configview = new Configview();



  files = new SelectLibrary(this);
  requestPermissions();
}

void draw() {
  if (oneClickActive) {
    if (millis() - clickRef > clickTimer) {
      println("First click expired");
      oneClickActive = false;
    }
  }
  if (configMode) {
    configview.render();
  } else {
    background(bgCol);
    fill(255);
    t1.render();
    t2.render();
  }
}

void touchStarted() {
  if (configMode) {
    configview.touchStarted(touches[0].x, touches[0].y);
  } else {
    t1.touchStarted(touches[0].x, touches[0].y);
    t2.touchStarted(touches[0].x, touches[0].y);
  }
  if (oneClickActive) {
    configMode = !configMode;
    oneClickActive = false;
  } else {
    clickRef = millis();
    oneClickActive = true;
  }
}

void touchMoved() {
  if (configMode) {
  } else {
    t1.touchMoved(touches[0].x, touches[0].y);
    t2.touchMoved(touches[0].x, touches[0].y);
  }
}

void touchEnded() {
  if (configMode) {
  } else {
    t1.touchEnded();
    t2.touchEnded();
  }
}

void requestPermissions() {
  // if you need to read files, request this
  if (!hasPermission("android.permission.READ_EXTERNAL_STORAGE")) {
    requestPermission("android.permission.READ_EXTERNAL_STORAGE", "handleRead");
  }
  // if you need to save files, request this as well
  if (!hasPermission("android.permission.WRITE_EXTERNAL_STORAGE")) {
    requestPermission("android.permission.WRITE_EXTERNAL_STORAGE", "handleWrite");
  }
}

void handleRead(boolean granted) {
  if (granted) {
    grantedRead = granted;
    println("Granted read permissions.");
  } else {
    println("Does not have permission to read external storage.");
  }
}

void handleWrite(boolean granted) {
  if (granted) {
    grantedWrite = granted;
    println("Granted write permissions.");
  } else {
    println("Does not have permission to write external storage.");
  }
}
