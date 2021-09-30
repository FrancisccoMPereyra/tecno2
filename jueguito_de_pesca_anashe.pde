import fisica.*;
import TUIO.*;
import ddf.minim.*; 
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import fisica.*; 
Minim minim;
AudioSample pescadoPaFuera;
AudioPlayer playerg, trombasuena;
AudioPlayer fondo;
TuioProcessing tuio;
FWorld wordl; 
FBox pared;
FBox jugador;
FCircle pez; 
FBox glob;
//Paredes muro;
Globo globo;
Anzuelo anzu;
Pez dorado;
PImage juego, ganar, perder, navecita, reloj, inicio,nose;
String estado;
float x, y, gravX, gravY, barra, dis, disv, tempo, tempo2, contador1, 
  contador2, cuerpo, gtX, gtY,vida;
boolean tromba;
int timer= millis(), f, ronda;
void setup()
{
  size(800, 600);
  tuio = new TuioProcessing(this);
  Fisica.init(this); 
  minim = new Minim(this); 
  x=7000;
  y=7000;
  gravX=0;
  gravY=0;
  barra=100;
  tempo=900;
  tempo2=400;
  vida = 3;
  tromba= false;
  anzu= new Anzuelo();
  dorado= new Pez();
  globo = new Globo();
 
  contador1=20;
  contador2= 0;
  ronda = 0;

  iniciar();
  anzu.inicializar();
  globo.cargaImg();
  dorado.cargaImg();
 

  juego = loadImage("fondo.png");
  nose = loadImage("fondo2.png");
  ganar = loadImage("ganaste.png");
  perder = loadImage("perdiste.png");
  reloj = loadImage("reloj.png");
  inicio = loadImage("menu.png");
  estado= "inicio";
  trombasuena = minim.loadFile("tromba.mp3", 412);
  pescadoPaFuera = minim.loadSample("agua.mp3", 412);
  playerg = minim.loadFile("ganar.mp3", 412);
  fondo = minim.loadFile("pesca.mp3", 300);

  fondo.loop();
}

void draw()
{

  if (estado.equals("inicio")) {
    background(inicio);
    wordl.step(); 
    wordl.draw();
    wordl.setGravity(gravX, gravY); 
    anzu.mov();
    gtX= jugador.getX();
    gtY= jugador.getY();
    println(gtX + "  ;  " + gtY);
    
    if ( gtX > 200 && gtX < 350 && gtY > 450 && gtY < 550) {
      estado="jugando";
    }
  }


  if (estado.equals("jugando")) {
    if ( frameCount % 1 == 0) {
      background(juego);
       wordl.add(pared);
    } 

    wordl.step(); 
    wordl.draw();
    wordl.setGravity(gravX, gravY); 
    anzu.mov();
    gtX= jugador.getX();
    gtY= jugador.getY();
    timer=timer+1;
  
    if (  timer == 2 ) { 
     
      
      dorado.inicial();
      globo.inicial();
      println(ronda);
    }
    image(reloj, width/2-25, 15);
    if ( timer > tempo && tromba == false) { 
      tromba= true;
      timer =0;
    }

    if (tromba == false && timer <= tempo)
    {
      dis= dist(timer, 0, tempo, 0);
      barra= map(dis, 0, tempo, 0, 100);
      fill(25, 250, 15);
      rect(width/2, 30, barra, 10);
    }

    if (tromba) {
     
      trombasuena.play();
      ArrayList<FBody> cuerpos = wordl.getBodies();
      float p = 30;
     for(FBody cuerpo : cuerpos){
     float dx = random(150, 650) - cuerpo.getX();
     float dy = random(150,450) - cuerpo.getY();
     image(nose,dx,dy,100,100);
     cuerpo.addForce(dx*p,dy*p);
     

     }
      timer= timer++;
      if (timer ==1 ) {
        ronda = ronda +1;
      }  


      if (  timer /100 == 50) { 
        gravX= random(50);
        gravY=random(50);
        wordl.setGravity(gravX*100, gravY*100);
        trombasuena.play();
      }
      if (  timer >tempo2) { 
        tromba= false;
        timer =0;
        
        gravX= random(50);
        gravY=random(50);
        wordl.setGravity(gravX*50, gravY*50);
       pez.addForce(random(-1000, 1000), random(-1000, 1000),random(25,25),random(25,25));}
    } else if (tromba == false) {
      timer= timer++;
      gravX= random(-1250, 1250);
      gravY= random(-1250, 1250);
      trombasuena.pause();
      // println("false timero: " + timer + meteorito);
    }
  }

  if (contador2 >= contador1 ) {
    estado= "perdiste";
  } else if (ronda == 3 ) {
    estado= "ganaste";
   
  }

  if (estado.equals("perdiste")) {     
    image(perder, 0, 0);
    playerg.play();
    fondo.pause();
  } else if 
    (estado.equals("ganaste")) {     
    image(ganar, 0, 0); 
    playerg.play();
    fondo.pause();
}
}
  
void contactStarted(FContact choque) 
{
  if (tromba == false) {  
    FBody ball = null;
    if (choque.getBody1() == jugador)
    {
      pescadoPaFuera.trigger(); 
      ball = choque.getBody2();
    } 
    if (ball == null)
    {
      return;
    }
    wordl.remove(ball); 
  }
  if (tromba == true) {  
    FBody ball = null;
     background(nose);
    if (choque.getBody1() == jugador)
    {   
      ball = choque.getBody2();//funciona para un primer cuerpo
    }  
    if (ball == null)
    {
      return;
    }
  }
}
