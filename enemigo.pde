class Globo extends FBox {

  PImage e ;

Boolean goingRight = true;
  float originalX;
  
  Globo() {
    super(50, 50);
  }


  void cargaImg() {
    for (int i=0; i<9; i++)
    {
      e = loadImage("cuervo.png");
    }
  }

  void inicial() {
    for (int i=0; i<1; i++)
    {
      glob = new FBox(50, 50); 
      glob.attachImage(e);
      glob.setName("globo");
      glob.setPosition(random(80, width-80), random(80, height-80)); //Ubica el objeto en el mapa
      glob.getX();
      
      
       if (getX() > originalX + 50)
      {
        goingRight = false;
      }
      else if (getX() < originalX - 50)
      {
        goingRight = true;
      }
      if (goingRight)
      {
        setVelocity(50, getVelocityY());
      }
      else
      {
        setVelocity(-50, getVelocityY());
      }
      glob.setRestitution(random(0.1,0.4));
      glob.setFill(originalX, random(100)*i, random(255)); 
      glob.addForce(random(-500, 500), random(-500, 550)); 
      glob.adjustPosition(getX(),getY());
      wordl.add(glob);
    }
  }


void iniciar(){

 wordl = new FWorld();
  wordl.setEdges(); 
  wordl.setGravity(gravX, gravY); 
  
 
}
}
