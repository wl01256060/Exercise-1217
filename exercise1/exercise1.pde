int [] water_x = new int[25];
float [] flower_hps = new float[5];
PImage water;
PImage flower_danger;
PImage flower_warning;
PImage flower_safe;
void setup()
{
  water = loadImage("water.png");
  flower_danger = loadImage("flower_danger.png");
  flower_warning = loadImage("flower_warning.png");
  flower_safe = loadImage("flower_safe.png");
  size(500,500);
}
void draw()
{
  background(255);
  drawWater();
  letTheWaterFall();
  for (int i = 0; i < flower_hps.length; ++i) {
    if (isLastWaterWithinFlower(i)) {
      changeFlowerHp(i,5);
    }
    //decrease hp everytime
    changeFlowerHp(i,-0.5);
    drawFlowerWithHp(i, flower_hps[i]);
  }
}
// drawWater() - 主要功能為畫水滴
void drawWater()
{
  for (int i = 0; i < water_x.length; ++i) {
    image(water, water_x[i], i * 20);
  }
  
}
// letTheWaterFall() - 讓水滴落下一格
void letTheWaterFall()
{
  for (int i = water_x.length-1; i >= 0; i--) {
    if (i == 0) {
      water_x[i] = mouseX;
    }
    else{
      water_x[i] = water_x [i-1]; 
    }
  }
}
// void changeFlowerHp(int flowerID, int value)
// 參數flowerID為告知第幾個Flower，然後value為要增加或減少多少HP
void changeFlowerHp(int flowerID, float value)
{
  for (int i = 0; i < flower_hps.length; ++i) {
    i = flowerID;
      flower_hps[i]+=value;
      if (flower_hps[i]>=100) {
        flower_hps[i] = 100;
        }
      flower_hps[i]+=value;
      if (flower_hps[i]<0) {
        flower_hps[i] = 0;
      }
    }
}
// isLastWaterWithinFlower(int flowerID)
// 這個在問說這朵花的範圍是否與落地的水滴重疊，若有則回傳True，若無則回傳False
boolean isLastWaterWithinFlower(int flowerID)
{
    if (50+ flowerID*80 < water_x[water_x.length-1] && water_x[water_x.length-1] < 50+( flowerID+1)*80  ) {
      return true;
    }else{
      return false;
    }
}
   

// drawFlowerWithHp(int flowerID,float hpValue)
// 給flowerID，並且也給了該flower的hpValue，這function功能是要把花畫出來
void drawFlowerWithHp(int flowerID,float hpValue)
{
    int i = flowerID;
    hpValue = flower_hps[i] ;
  if (flower_hps[i] > 80) {
      image(flower_safe, 50 + i * 80, height - flower_danger.height);
    }
    else if (flower_hps[i]<=80 && flower_hps[i] > 40) {
      image(flower_warning, 50 + i * 80, height - flower_danger.height);
    }
    else {
      image(flower_danger, 50 + i * 80, height - flower_danger.height);
    }
}
