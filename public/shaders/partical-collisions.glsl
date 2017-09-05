

uniform sampler2D pos;
uniform sampler2D buckets;


uniform vec2  res;
uniform vec2  screenSize;
uniform float size;
uniform float bounce;
const float width = &WIDTH;
const float height = &HEIGHT;
const float cellSize = &CELLSIZE;
const float particlesPerCell = &PPC;
const float bucketsWidth = &BW;
const float bucketsHeight = &BH;

$rand
void main(){

  vec2 uv = gl_FragCoord.xy / res;
  vec4 posi  = texture2D( pos , uv );
  float x = posi.x;
  float y = posi.y;
  float z = posi.z;
  float target = 1.2 * size;

  
  float x_bkt = floor( (x + (screenSize.x/2.0) )/cellSize);
  float y_bkt = floor( (y + (screenSize.y/2.0) )/cellSize);
  float x_bkt_ind_start = x_bkt * particlesPerCell;
  float y_bkt_ind_start = y_bkt * particlesPerCell;

  float numCellsHorizontal = floor(screenSize.x/cellSize);
  float numCellsVertical = floor(screenSize.y/cellSize);

   


  
 
 for(float j = 0.0; j < bucketsHeight; j++){
    for(float i = 0.0; i <= bucketsWidth ; i++){

      float  x_bkt_ind = i/bucketsWidth;
      float  y_bkt_ind = j/bucketsHeight;


      vec4 ind2 = texture2D( buckets , vec2(x_bkt_ind,y_bkt_ind) );

      if(ind2.z != 1.0){
        continue;
      }
      
      vec4 pos2 = texture2D( pos , vec2(ind2.xy)/res );

      vec3 diff = posi.xyz - pos2.xyz;

      float dist = length(diff);

      vec2 uvDiff = ind2.xy -  gl_FragCoord.xy ;
      float uvDist = length(uvDiff);



      if(dist <= target && uvDist >= 0.5){
        float factor = (dist-target)/dist;
        x = x - diff.x * factor * 0.5;
        y = y - diff.y * factor * 0.5;
      }
    }
  }
  
  /*
  //this is the code that is acting weirdly
  for(float j = 0.0 ; j < particlesPerCell; j++){
    for(float i = 0.0 ; i < particlesPerCell; i++){

      float  x_bkt_ind = (x_bkt_ind_start - i)/bucketsWidth;
      float  y_bkt_ind = (y_bkt_ind_start - j)/bucketsHeight;


      vec4 ind2 = texture2D( buckets , vec2(x_bkt_ind,y_bkt_ind) );

      
       vec4 pos2 = texture2D( pos , vec2(ind2.xy)/res );

       vec2 diff = posi.xy - pos2.xy;

       float dist = length(diff);


      vec2 uvDiff = ind2.xy -  gl_FragCoord.xy ;
      float uvDist = abs(length(uvDiff));


      if(ind2.z != 1.0){
        continue;
      }
      
      if(dist <= target && uvDist >= 1.0){
        float factor = (dist-target)/dist;
        x = x - diff.x * factor * 0.5;
        y = y - diff.y * factor * 0.5;
      }

      
    }
  }
  */

  gl_FragColor = vec4( x, y, z , 1);


}
