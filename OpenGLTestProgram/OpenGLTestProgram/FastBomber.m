//
//  FastBomber.m
//  AlienInvasion
//
//  Created by Jose Mari Salandanan on 4/4/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "FastBomber.h"

@implementation FastBomber
-(ProtoSprite *)spawnFastBomber
{
    BOOL originRand = arc4random_uniform(2);
    int rangeY2 = 110;
    int actualY2 = (arc4random() % rangeY2) + 150;
    if(originRand)
    {
        self.position = GLKVector2Make(480 + (self.contentSize.width/2), actualY2);
        self.moveVelocity = GLKVector2Make(-300,0);
    }
    else
    {
        self.position = GLKVector2Make(-20 + (self.contentSize.width/2), actualY2);
        self.moveVelocity = GLKVector2Make(300,0);
    }
    return self;
}

@end
