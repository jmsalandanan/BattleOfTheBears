//
//  Boss.m
//  AlienInvasion
//
//  Created by Jose Mari Salandanan on 4/4/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "Boss.h"

@implementation Boss
-(ProtoSprite*)spawnBoss
{
    self.position = GLKVector2Make(480 +(self.contentSize.width/2),250);
    self.moveVelocity = GLKVector2Make(-300,0);
    return self;
}
@end
