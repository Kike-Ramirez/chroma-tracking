class Configview {
  PImage saveFile;
  PImage selectFile;
  PImage selectFolder;
  int baseLine;

  Configview () {

    saveFile = loadImage("ic_save_black_24dp.png");
    selectFile = loadImage("ic_insert_drive_file_black_24dp.png");
    selectFolder = loadImage("ic_folder_open_black_24dp.png");

    baseLine = displayHeight*3/7;
  }

  void touchStarted(float x, float y) {
    //println(x);
    //println(y);
  }

  void render() {
    imageMode(CENTER);
    textAlign(CENTER, TOP);
    textSize(36);
    noStroke();

    background(255);
    image(selectFile, displayWidth/6, baseLine);
    image(selectFolder, displayWidth/2, baseLine);
    image(saveFile, displayWidth*5/6, baseLine);

    fill(0);
    text("select\nfile", displayWidth/6, baseLine + 96);
    text("select\nfolder", displayWidth/2, baseLine + 96);
    text("save\nfile", displayWidth*5/6, baseLine + 96);
  }
}
