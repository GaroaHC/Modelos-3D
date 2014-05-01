// This work is licensed under the Creative Commons Attribution 3.0 Unported License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/
// or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View,
// California, 94041, USA.

// Persistence Of Vision raytracer version 3.5 sample file.
//
// -w320 -h240
// -w800 -h600 +a0.3
#version  3.7;
global_settings { assumed_gamma 1.9 }

#include "colors.inc"           // Standard colors library
#include "shapes.inc"           // Commonly used object shapes
#include "textures.inc"         // LOTS of neat textures.  Lots of NEW textures.

camera {
   location  <0, 4000*5, 7000*5>
   angle 1 
   right     x*image_width/image_height
   look_at   <0, 150, 0>
   rotate y*(clock*360+45)
}

background{ color rgb<1,1,1>*0.15 } 

// Light source

light_source {<-3000, 11000/1, +2000>  color LightGray  }
light_source {< 3100, 12000/1, -2000>  color White  }
//light_source {< 3200, 11000/1, -2000>  color LightGray }

light_source {<0, 300, 0>  color Blue  }
light_source {<0, 250, 0>  color Blue  }
light_source {<0, 200, 0>  color Blue  }
light_source {<0, 150, 0>  color Blue  }
light_source {<0, 100, 0>  color Blue  }
light_source {<0, 50, 0>  color Blue  }

#include "rdgranit.map"
#declare Pink_Gran_Texture =
texture {
   pigment {
      granite
      color_map { M_RedGranite }
      scale 0.4
      }
   finish {
      specular 0.75
      roughness 0.0085
      ambient 0.05
      reflection 0.2
   }
}

#declare I_Glass=interior{
    ior 1.51
    fade_distance 1000
    fade_power 1
}

#declare F_Glass=finish {
    ambient 0
    diffuse 0
    specular 0.8
    roughness 0.0003
    phong 1 
    phong_size 400
    reflection {
        0.01, 1
        fresnel on
    }
    conserve_energy
}

#declare T_Glass = texture{
    pigment{rgbf<1,1, 1, 0.95>}
    finish {F_Glass}
}        

#declare T_ColoredGlass = texture{
    pigment{rgbf<63*3,63*3, 23*3, 0.95*255>/255}
    finish {F_Glass}
}

#include "donation_box_cantos.inc"
#include "donation_box_base.inc"
#include "donation_box_sheet1.inc"
#include "donation_box_sheet2.inc"
#include "donation_box_sheet3.inc"

object {
  DonationBox_cantos
  rotate <-90, 0, 0>
  texture { T_ColoredGlass }
	interior { I_Glass }
}

object {
  DonationBox_base
  rotate <-90, 0, 0>
  texture { T_ColoredGlass }
	interior { I_Glass }
}

object {
  DonationBox_sheet1
  rotate <-90, 0, 0>
  texture { T_ColoredGlass }
	interior { I_Glass }
}

object {
  DonationBox_sheet2
  rotate <-90, 0, 0>
  texture { T_ColoredGlass }
	interior { I_Glass }
}

object {
  DonationBox_sheet3
  rotate <-90, 0, 0>
  texture { T_ColoredGlass }
	interior { I_Glass }
}

plane { y, -1.5
  pigment { checker Grey Black scale 60}
  finish {
    specular 0.75
    roughness 0.0085
    ambient 0.05
    reflection 0.2
  }
  texture { Pink_Gran_Texture scale 1500 }
}

