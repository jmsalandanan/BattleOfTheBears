//
//  SGGViewController.h
//  OpenGLTestProgram
//
//  Created by Jose Mari Salandanan on 11/20/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Bomber.h"
#import "SoundLayer.h"
#define player_Radius 40
#define default_Height 320
#define default_Width 0
#define repeatAnimationOnce 1
#define defaultAnimationDuration 0.3
#define randomAttackProbability 10
#define groundCoordinate 10

@interface SGGViewController : GLKViewController <UIAccelerometerDelegate>

extern const int defaultHeight;


@end
