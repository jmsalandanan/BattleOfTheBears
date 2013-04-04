//
//  Bomber.m
//  PrototypeApp
//
//  Created by Jose Mari Salandanan on 11/23/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import "Bomber.h"
#import "Bomb.h"
#import <GLKit/GLKit.h>

@implementation Bomber

-(ProtoSprite *)spawnBomber
{
BOOL originRand = arc4random_uniform(2);
int rangeY2 = 110;
int actualY2 = (arc4random() % rangeY2) + 150;
int minVelocity = 480.0/4.0;
int maxVelocity = 480.0/2.0;
int rangeVelocity = maxVelocity - minVelocity;
int actualVelocity = (arc4random() % rangeVelocity) + minVelocity;

    if(originRand)
    {
        self.position = GLKVector2Make(480 + (self.contentSize.width/2), actualY2);
        self.moveVelocity = GLKVector2Make(-actualVelocity,0);
    }
    else
    {
        self.position = GLKVector2Make(-20 + (self.contentSize.width/2), actualY2);
        self.moveVelocity = GLKVector2Make(actualVelocity,0);
    }
    return self;
}

@end
