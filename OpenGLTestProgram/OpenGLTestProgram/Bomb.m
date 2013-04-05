//
//  Bomb.m
//  AlienInvasion
//
//  Created by Jose Mari Salandanan on 4/4/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "Bomb.h"

@implementation Bomb

-(ProtoSprite *)spawnBomb:(float)bombX bombCoordinateY:(float)bombY bombImage:(NSString *)bomb
{
    NSLog(@"%f %f",bombX,bombY);
    self.moveVelocity = GLKVector2Make(0, -50);
    self.position = GLKVector2Make(bombX, bombY);
    return self;
}
@end
