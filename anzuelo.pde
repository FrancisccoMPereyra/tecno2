class Anzuelo extends FBox {

  PImage anzu;
  Boolean izq, der, abajo, arriba;

  float nX, nY;

  Anzuelo() {
    super(25, 50);
  }

  void inicializar() {
    jugador = new FBox(57, 50); 
    wordl.add(jugador); 
    
    anzu = loadImage("palo.png");
    jugador.attachImage(anzu); 

    setName("anzu");
    jugador.setGrabbable(true);       
    jugador.setPosition(width/2,height/2);
    jugador.setRestitution(0.5);
 
    jugador.setDensity(200);


    izq= false;
    der= false;
    abajo= false;
    arriba= false;
  }

  void mov() {
   
    if (izq) {
      jugador.addForce(1-x, 0);
    }
    if (der) {
      jugador.addForce(x+1, 0);
    }
    if (arriba) {
      jugador.addForce(0, 1-y);
    }
    if (abajo) {
      jugador.addForce(0, y+1);
    }


    nX=jugador.getX();
    nY=jugador.getY();

    if (nX < posX) {  
      jugador.addForce(1+x, 0);
    } else if (nX > posX) {   
      jugador.addForce(1-x, 0);
    } 
    if (nY < posY) {      
      jugador.addForce(0, 1+y);
    } else if (nY > posY) {  
      jugador.addForce(0, 1-y);
    }

  }
}
