

uniform sampler2D pos;


uniform vec2  res;
uniform vec2  screenSize;
uniform float size;
uniform float bounce;
uniform vec4 obstacles[16];

$rand
void main(){

  vec2 uv = gl_FragCoord.xy / res;
  vec4 posi  = texture2D( pos , uv );
    float x = posi.x;
    float y = posi.y;
    float z = posi.z;
    float w = posi.w;




 	
	
 
     if(x> -10000.0 ){
        
        bool safe = false;
        int minDistInd = -1;
        float minDist = 10000.0;
        vec4 minObj = obstacles[0];
        for(int i = 0 ; i < 16; i++){
          vec4 obj = obstacles[i];

          float dist = distance(posi.xy, obj.xy)  ;
          dist = dist - obj.z;
          if(dist < 0.0){
            safe = true;
          }
          else{
            if(dist < minDist){
              minDist = dist;
              minDistInd = i;
              minObj = obj;
            }
          }
        }
        if(!safe){
          vec4 obj = minObj;
          vec2 dir = normalize(vec2(x - obj.x, y - obj.y ));
          float dist = distance(posi.xy, obj.xy)  ;
          dist = dist - obj.z;
          if(dist > 0.0 && dist < 1000.0){
            x = obj.x + dir.x * (obj.z );
            y =  obj.y + dir.y * (obj.z );
          }
        }
  

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


    }



  gl_FragColor = vec4( x, y, z , w);


}
