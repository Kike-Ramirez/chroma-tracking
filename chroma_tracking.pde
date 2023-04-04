import select.files.*;

SelectLibrary files;
ArrayList<Trackpoint> trackers;
Configview configview;
boolean configMode = false;
boolean oneClickActive = false;
float clickRef = millis();
float clickTimer = 500;
boolean grantedRead = false;
boolean grantedWrite = false;
JSONObject userSettings;
color chromaColor, markerColor1, markerColor2;
int markerType;
float markerSize;


void setup() {

  fullScreen();

  userSettings = loadJSONObject("template.json");

  chromaColor = color(userSettings.getJSONObject("chromaColor").getInt("r"), userSettings.getJSONObject("chromaColor").getInt("g"), userSettings.getJSONObject("chromaColor").getInt("b"));
  markerColor1 = color(userSettings.getJSONObject("markerColor1").getInt("r"), userSettings.getJSONObject("markerColor1").getInt("g"), userSettings.getJSONObject("markerColor1").getInt("b"));
  markerColor2 = color(userSettings.getJSONObject("markerColor2").getInt("r"), userSettings.getJSONObject("markerColor2").getInt("g"), userSettings.getJSONObject("markerColor2").getInt("b"));
  markerSize = userSettings.getFloat("markerSize");
  markerType = userSettings.getInt("markerType");

  JSONArray trackerList = userSettings.getJSONArray("markers");

  trackers = new ArrayList<Trackpoint>();

  for (int i = 0; i < trackerList.size(); i++) {

    JSONObject marker = trackerList.getJSONObject(i);

    trackers.add(new Trackpoint(marker.getFloat("xpos")*width, marker.getFloat("ypos")*height, markerSize*width));
  }

  configview = new Configview();

  files = new SelectLibrary(this);
  requestPermissions();
}

void draw() {
  if (oneClickActive) {
    if (millis() - clickRef > clickTimer) {
      oneClickActive = false;
    }
  }
  if (configMode) {
    configview.render();
  } else {
    background(chromaColor);
    for (int i= 0; i < trackers.size(); i++) {
      trackers.get(i).render();
    }
  }
}

void touchStarted() {
  if (configMode) {
    configview.touchStarted(touches[0].x, touches[0].y);
  } else {
    for (int i = 0; i < trackers.size(); i++) {
      trackers.get(i).touchStarted(touches[0].x, touches[0].y);
    }
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
    for (int i = 0; i < trackers.size(); i++) {
      trackers.get(i).touchMoved(touches[0].x, touches[0].y);
    }
  }
}

void touchEnded() {
  if (configMode) {
  } else {
    for (int i = 0; i < trackers.size(); i++) {
      trackers.get(i).touchEnded();
    }
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
