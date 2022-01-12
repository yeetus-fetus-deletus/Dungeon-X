void gameOver() { //game over mode ================================================================================
  background(black);
  gameOverGIF.show();
  
  textFont(revamped);
  textSize(120);
  fill(255);
  if (win) {
    text("YOU  WIN", width/2, height/4);
    image(cube1, width/2, height/2, 211*2/3, 200*2/3);
  } else if (!win) {
    text("YOU  LOSE", width/2, height/4);
  }
  
  gameButton.show();
  homeButton.show();
  exitButton.show();
  if (gameButton.click) {
    reset();
    mode = OPTIONS;
  }
  if (homeButton.click) {
    reset();
    mode = INTRO;
  }
  if (exitButton.click) mode = EX;
  
  stroke(black);
  line(400, 580, 800, 580);
  line(400, 660, 800, 660);
}


void ex() { //exit mode ================================================================================
  //options box ========================================
  fill(50, 50);
  strokeWeight(1);
  stroke(240);
  rect(width/2, height/2, 600, 400, 100);

  //exit text ========================================
  textFont(revamped);
  fill(255);
  textSize(25);
  text("ARE YOU SURE YOU WANT TO EXIT?", width/2, 300);

  //exit button ========================================
  textFont(monochrome);
  //cancel button ========================================
  cancelButton.show();
  if (cancelButton.click) {
    mode = GAMEOVER;
  }
  //yes button ========================================
  yesButton.show();
  if (yesButton.click) {
    exit();
  }
}
