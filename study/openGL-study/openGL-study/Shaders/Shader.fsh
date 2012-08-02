//
//  Shader.fsh
//  openGL-study
//
//  Created by Mason Mei on 7/30/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
