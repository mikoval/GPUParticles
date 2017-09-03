varying float w;
void main(){
	vec2 coord = gl_PointCoord - vec2(0.5); 
	if(length(coord) > 0.5)                
	    discard;

	gl_FragColor = vec4( 0.3, 0.3, 1.0, 1. );
	
  

}
