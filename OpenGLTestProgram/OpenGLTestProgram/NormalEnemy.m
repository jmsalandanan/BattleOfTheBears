//
//  NormalEnemy.m
//  AlienInvasion
//
//  Created by Jose Mari Salandanan on 4/4/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "NormalEnemy.h"

@implementation NormalEnemy
-(ProtoSprite*)spawnNormalEnemy
{
    self.isAttacking = FALSE;
    
    BOOL originRand = arc4random_uniform(2);
    int minY = 200;
    int maxY = 280;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    if(originRand)
    {
        self.position = GLKVector2Make(480 + (self.contentSize.width/2), actualY);
        self.moveVelocity = GLKVector2Make(-100, 0);
        self.fromOrigin = originRand;
    }
    else
    {
        self.position = GLKVector2Make(-20 + (self.contentSize.width/2), actualY);
        self.moveVelocity = GLKVector2Make(100, 0);
        self.fromOrigin = originRand;
    }
    return self;
}

@end
