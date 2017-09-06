

uniform sampler2D pos;


uniform vec2  res;
uniform vec2  screenSize;
uniform float size;
uniform float bounce;

$rand
void main(){

  vec2 uv = gl_FragCoord.xy / res;
  vec4 posi  = texture2D( pos , uv );
    float x = posi.x;
    float y = posi.y;
    float z = posi.z;
    float w = posi.w;



 	
	
 
  

    if(x + size > screenSize.x/2.0){
      
      x = screenSize.x/2.0 - size;
    }
    if(x - size < -screenSize.x/2.0){

      x = -screenSize.x/2.0 + size;
    }
    if(y + size > screenSize.y/2.0){
     
      y = screenSize.y/2.0 - size;

    }
    if(y  - size  < -screenSize.y * 0.5){
      
      y = -screenSize.y/2.0 + size;
    }





  gl_FragColor = vec4( x, y, z , w);


}
