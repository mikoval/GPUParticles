

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
      float w = posi.w; 
      float target = size * 1.3;

      
      float x_bkt = floor( (x + (screenSize.x/2.0) )/cellSize);
      float y_bkt = floor( (y + (screenSize.y/2.0) )/cellSize);


      //hard coded values and things work. 
      //float x_bkt_ind_start = 0.0;
      //float y_bkt_ind_start = 0.0;


      //remove these two comments and things break
      float x_bkt_ind_start = x_bkt * particlesPerCell;
      float y_bkt_ind_start = y_bkt * particlesPerCell;

      //this is the code that is acting weirdly

      for(float j = -particlesPerCell ; j <= particlesPerCell * 2.0 ; j++){
        for(float i = -particlesPerCell ; i <= particlesPerCell * 2.0; i++){

          float  x_bkt_ind = (x_bkt_ind_start + i)/bucketsWidth;
          float  y_bkt_ind = (y_bkt_ind_start + j)/bucketsHeight;
          if(x_bkt_ind < 0.0 || x_bkt_ind > 1.0 || y_bkt_ind < 0.0 || y_bkt_ind > 1.0 ){
            continue;
          }

          vec4 pos2 = texture2D( buckets , vec2(x_bkt_ind,y_bkt_ind) );
          if(pos2.z != 1.0){
            continue;
          }


           vec2 diff = posi.xy - pos2.xy;

           float dist = abs(length(diff));



          
          if(dist <= target && dist > 0.00001){
            float factor = (dist-target)/dist;
            x -= diff.x * factor * 0.5;
            y -= diff.y * factor * 0.5;
          }

          
        }
      }
      

      gl_FragColor = vec4( x, y, z , w);


    }
