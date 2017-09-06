

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
      float target = 1.0 * size;

      
      float x_bkt = floor( (x + (screenSize.x/2.0) )/cellSize);
      float y_bkt = floor( (y + (screenSize.y/2.0) )/cellSize);


      //hard coded values and things work. 
      float x_bkt_ind_start = 0.0;
      float y_bkt_ind_start = 0.0;


      //remove these two comments and things break
      //float x_bkt_ind_start = x_bkt * particlesPerCell;
      //float y_bkt_ind_start = y_bkt * particlesPerCell;



      /*
      // This check is to guarantee that the values are within the size of the texture. 
      // Doesn't make a difference. There is no reason for the variables to not be within that range
      // and if I read them out with javascript they all are.
    
      if(x_bkt_ind_start < 0.0){
        x_bkt_ind_start = 0.0;
      }
      if(x_bkt_ind_start  > 144.0){
        x_bkt_ind_start = 144.0;
      }
      if(y_bkt_ind_start < 0.0){
        y_bkt_ind_start = 0.0;
      }
      if(y_bkt_ind_start  > 144.0){
        y_bkt_ind_start = 144.0;
      }
      */

      //this is the code that is acting weirdly

      for(float j = -144.0 ; j < 144.0; j++){
        for(float i = -144.0 ; i < 144.0; i++){

          float  x_bkt_ind = (x_bkt_ind_start + i)/bucketsWidth;
          float  y_bkt_ind = (y_bkt_ind_start + j)/bucketsHeight;


          vec4 ind2 = texture2D( buckets , vec2(x_bkt_ind,y_bkt_ind) );

          if( abs(ind2.z - 1.0) > 0.00001  || x_bkt_ind < 0.0 || x_bkt_ind > 1.0 || y_bkt_ind < 0.0 || y_bkt_ind > 1.0 ){
            continue;
          }
          
           vec4 pos2 = texture2D( pos , vec2(ind2.xy)/res );

           vec2 diff = posi.xy - pos2.xy;

           float dist = length(diff);


          vec2 uvDiff = ind2.xy -  gl_FragCoord.xy ;
          float uvDist = abs(length(uvDiff));

          
          if(dist <= target && uvDist >= 0.5){
            float factor = (dist-target)/dist;
            x = x - diff.x * factor * 0.5;
            y = y - diff.y * factor * 0.5;
          }

          
        }
      }
      

      gl_FragColor = vec4( x, y, x_bkt_ind_start , y_bkt_ind_start);


    }
