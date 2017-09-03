uniform sampler2D color;
varying vec2 vUv;
varying float w;

void main(){


  gl_Position = projectionMatrix * modelViewMatrix * vec4( position.xyz , 1. );


}
