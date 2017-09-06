

uniform sampler2D pos;
uniform sampler2D posOld;

uniform vec2  res;

uniform float dT;
uniform float t;
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
    //dz = dz * 0.99;


    dy = dy - 0.1;
    x = x + dx;
    y = y + dy;
    
    z = z + dz;

 	

  



  gl_FragColor = vec4( x, y, z , w);


}
