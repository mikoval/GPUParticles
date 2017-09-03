varying float w;
varying vec2 vUv;
uniform sampler2D color;
void main(){
	vec4 color = texture2D( color , vUv.xy );
	gl_FragColor = vec4( 1.0, 1.0, 0.0, 1.0 );
	
  

}
