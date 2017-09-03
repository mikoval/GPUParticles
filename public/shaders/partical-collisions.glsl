

uniform sampler2D pos;


uniform vec2  res;
uniform vec2  screenSize;
uniform float size;
uniform float bounce;
const float width = 64.0;
const float height = 64.0;

$rand
void main(){

  vec2 uv = gl_FragCoord.xy / res;
  vec4 posi  = texture2D( pos , uv );
  float x = posi.x;
  float y = posi.y;
  float z = posi.z;
  float target = 1.2 * size;
  for(float i = 0.0; i < width; i++){
    for(float j = 0.0; j < height; j++){
      vec4 pos2 = texture2D( pos , vec2(i,j)/res );
      vec3 diff = posi.xyz - pos2.xyz;
      float dist = length(diff);

      vec2 uvDiff = vec2(i,j) -  gl_FragCoord.xy ;
      float uvDist = length(uvDiff);
      if(dist <= target && uvDist >= 0.5){
        float factor = (dist-target)/dist;
        x = x - diff.x * factor * 0.5;
        y = y - diff.y * factor * 0.5;
      }
    }
  }
  gl_FragColor = vec4( x, y, z , 1);


}
