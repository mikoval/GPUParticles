uniform vec2 res;
varying vec2 vUv;
$rand

void main(){
	float x = (rand(vUv * 10.0) - 0.5) * res.x ;
	float y = (rand(vUv * 20.0) - 0.5) * res.y ;

	x = -10000.0;
	y = -10000.0;
	gl_FragColor = vec4(x, y, 0.0, 0.0 );
	
  

}
