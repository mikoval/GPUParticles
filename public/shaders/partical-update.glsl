

uniform sampler2D pos;
uniform sampler2D posOld;

uniform vec2  res;
uniform vec2  start;

uniform float dT;
uniform float time;
$rand
void main(){

  vec2 uv = gl_FragCoord.xy / res;
  vec4 oPos = texture2D( posOld , uv );
  vec4 posi  = texture2D( pos , uv );
    float dx = posi.x - oPos.x;
    float dy = posi.y - oPos.y;
    float dz = posi.z - oPos.z;
  	float x = posi.x;
  	float y = posi.y;
  	float z = posi.z;
    float w = posi.w;

    dx = dx * 0.99;
    dy = dy * 0.99;


    if(time > gl_FragCoord.y * res.x + gl_FragCoord.x ){
      if(w < 1.0){

        x = start.x + (rand(uv * time) - 0.5)* 20.0;
        y = start.y;
        w = 1.5;
      }
      else if (w < 2.0){
        w = 2.5;
        dy = dy -  0.5;
       
      }
      else if (w < 3.0){
        w = 3.5;
        dy = dy -  2.0;
        x = x + dx;
        y = y + dy;
        
        z = z + dz; 
      }
      else {
          dy = dy - 0.05;
          x = x + dx;
          y = y + dy;
          
          z = z + dz;
  
      }
      
    }
          

   

 	

  



  gl_FragColor = vec4( x, y, z , w);


}
