include <spiffsans.scad>

module write(string,font=spiffsans,spacing=1,i=0) {
  if (i < len(string)) {
    assign(charindex = search(string[i],font,1)[0])
    
    // If the character is in the font
    if (charindex != undef) {
      assign(glyph = font[charindex][2])
      if (glyph){
        polygon(points=glyph[0], paths=glyph[1]);
      }
      translate([font[charindex][1] + spacing, 0, 0])
        write(string, font, spacing, i=i+1);
    } else {
      assign(glyph = font[0][2])
      if (glyph){
        polygon(points=glyph[0], paths=glyph[1]);
      }
      translate([font[0][1] + spacing,0,0])
        write(string, font, spacing, i=i+1);
    }
  }
}

module outset(shape,path_index,dist){
    minkowski(){
      polygon(points = shape[0], paths = [shape[1][path_index]], convexity = 10);
      circle(r=dist);
    }
}

module writeOutset(string,font=spiffsans,spacing=1,thickness=1.6,i=0) {
  if (i < len(string)) {
    assign(charindex = search(string[i],font,1)[0])
    
    // If the character is in the font
    if (charindex != undef) {
      assign(glyph = font[charindex][2])
      if (glyph){
        outset(glyph,0,thickness);
      }
      translate([font[charindex][1] + spacing, 0, 0])
        writeOutset(string, font, spacing, thickness, i=i+1);
    } else {
      assign(glyph = font[0][2])
      if (glyph){
        outset(glyph,0,thickness);
      }
      translate([font[0][1] + spacing,0,0])
        writeOutset(string, font, spacing, thickness, i=i+1);
    }
  }
}
