class Pez extends FBox {

  PImage[] peces;

  int orientacion;  
  int posX1, posX2;
  int px, py;
  Pez() {
    super(33, 27);
  }


  void cargaImg() {
    
    peces = new PImage[2];
    for (int i=0; i<2; i++)
    {
      peces[i] = loadImage("p"+i+".png");
    }
  }

  void inicial() {
    
    if(posX1>width-50) posX1 = 50; 
    {
    for (int i=0; i<3; i++)
    {
      pez = new FCircle(30);

      pushMatrix();
      translate( x, y );
      rotate( radians( orientacion ) );
      
      pez.attachImage(peces[0]);

      if ( frameCount%60 < 30 ) 
        orientacion = 0;
      else
        orientacion = 180;
      popMatrix();



      pez.setName("cubito");
      pez.adjustPosition(px+random(80, width-80), random(80, height-80)); 

      pez.setRestitution(random(0.1, 1.8)); 
      pez.setRotatable(false);

      pez.addForce(random(-1000, 1000), random(-1000, 1000),random(25,25),random(25,25)); 

      wordl.add(pez);
    }
  }
  }
}
void iniciar() {


  wordl = new FWorld(); 
  wordl.setEdges(); 
  wordl.setGravity(gravX, gravY); 
}
