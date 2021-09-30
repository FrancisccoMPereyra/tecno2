int idC= 1;
float posX, posY;

void addTuioObject(TuioObject objetoTuio) {
 
  if ( objetoTuio.getSymbolID() == idC ) {
    posX = objetoTuio.getX()*width;  
    posY = objetoTuio.getY()*height; 
   
  }
}

void updateTuioObject (TuioObject objetoTuio) {
     if ( objetoTuio.getSymbolID() == idC ) {
    posX = objetoTuio.getX()*width;  
    posY = objetoTuio.getY()*height; 
  
     }
}
