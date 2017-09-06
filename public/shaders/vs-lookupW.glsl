uniform sampler2D t_pos;
varying float w;
uniform vec2  res;
uniform float size;
void main(){

  vec4 pos = texture2D( t_pos , position.xy);


  gl_PointSize = size;
  gl_Position = vec4( pos.x / res.x * 2.0 , pos.y/res.y * 2.0, 0.0, 1. );


}
