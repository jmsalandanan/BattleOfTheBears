//
//  SuicideBomber.m
//  AlienInvasion
//
//  Created by Jose Mari Salandanan on 4/4/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "SuicideBomber.h"

@implementation SuicideBomber

-(ProtoSprite *)spawnSuicidePanda
{
    int rangeY3 = arc4random_uniform(320);
    self.position = GLKVector2Make(rangeY3, 320);
    self.moveVelocity = GLKVector2Make(0,-60);
    
    return self;
}

@end
