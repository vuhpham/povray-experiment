// Global settings
global_settings { assumed_gamma 1.5 }
global_settings { radiosity { brightness 1.5 } }
#default{ finish{ ambient 0.1 diffuse 0.9 }}
#declare AmberColor =  rgb<0.89, 0.80, 0.62>;           
//-----------------------------------------------
#include "colors.inc"
#include "woods.inc"
#include "glass.inc"  
#include "textures.inc"
//-----------------------------------------------
// Beach ball texture
#declare BeachBallTexture =
  texture {
    pigment {
      radial
      color_map {
        [ 0.0   color Blue ]
        [ 0.24  color Blue ]
        [ 0.25  color Yellow ]
        [ 0.49  color Yellow ]
        [ 0.5   color Red ]
        [ 0.74  color Red ]
        [ 0.75  color Yellow ]
        [ 0.99  color Yellow ]
      }
      frequency 3
    }
    finish {
      metallic
      specular    1.0
      roughness   0.001
      brilliance  2.0
    }
    normal { dents 1.0 scale 0.2 }
  }

#declare cylinder_radius = 0.7;
#declare cylinder_height = 1.5;

// For radiosity
#default { finish { ambient 0.5 diffuse 0.4 specular 0 phong 0 } }

camera {
  location <0, 3, -13>
  look_at  <0, 1,  15>
  angle 30
}

// Floor  
plane { y, 0 
  texture  { T_Wood19 }
}

// Walls
plane { z, 5
  pigment {
    color AmberColor
  }
}  

plane { z, -15
  pigment {
    color AmberColor
  }
}

plane { x, -10
  pigment {
    color AmberColor
  }
}
plane { x, 10
  pigment {
    color AmberColor
  }
}
 
// Beach ball
sphere {
  <0,-0.3,0>, 0.3
  texture { BeachBallTexture }
  translate <-0.2,0.6,1>
}

// Mirror
box { <-1,0,4>, <1,3,4.5> pigment { color White } finish{ reflection 1 }}

// Ligh source
light_source {<-10,5,4> color White*1.3 }
                            
   
// Container                         
#declare Container =
difference
{
  cylinder {<0, 0, 0>, <0, 1, 0>, 1}
  cylinder {<0, 1* .05, 0>, <0, 1 + .1, 0>, 1* .9}
  material {
    texture {
      pigment { rgbf<.98,.98,.98,0.8>*1}
      finish { ambient 0.0 diffuse 0.15 specular 0.6 roughness 0.05 reflection { 0.03, 1.0 fresnel on }}
    }
    interior { ior 1.5 fade_power 1001 fade_distance 0.5 fade_color <0.8,0.8,0.8>}
  }
}
union
{
  object { Container }
  intersection
  { 
    cone { <0, .1,0>,.9,<0, 0.6, 0>, 0.9 }
    plane { y, 4 }
    scale .999    
    material {
      texture { Water }
      interior {
        ior 1.33 
        fade_power 1001
        fade_distance 0.5
        fade_color <0, 0, 0> 
      }
    }
  }         
  translate <1.5, 0, 1>
}    

// Rug
box { <-2,0,0>, <3,0.05,3>
  texture {
    Brown_Agate
  }
}