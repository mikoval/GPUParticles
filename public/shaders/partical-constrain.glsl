

uniform sampler2D pos;
uniform sampler2D posOld;

uniform vec2  res;
uniform vec2  screenSize;
uniform float size;
uniform float bounce;

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
  	float x2 = oPos.x;
  	float y2 = oPos.y;
  	float z2 = oPos.z;
    float w2 = oPos.z;



 	
	
 
  
    if(x > -10000.0){
      if(x + size > screenSize.x/2.0){
      
        x2 = screenSize.x * 0.5 - size + dx * bounce;
      }
      if(x - size < -screenSize.x/2.0){

        x2 = -screenSize.x * 0.5 + size + dx * bounce;
      }
      if(y + size > screenSize.y/2.0){
       
        y2 = screenSize.y * 0.5 - size + dy * bounce;

      }
      if(y  - size  < -screenSize.y * 0.5){
        
        y2 = -screenSize.y  * 0.5 +  size + dy * bounce;
      }

    }
    




  gl_FragColor = vec4( x2, y2, z2 , w2);


}
