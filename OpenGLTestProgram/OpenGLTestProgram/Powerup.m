//
//  Powerup.m
//  AlienInvasion
//
//  Created by Jose Mari Salandanan on 4/4/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "Powerup.h"

@implementation Powerup
-(ProtoSprite*)spawnPowerUp:(NSString *)powerUpType powerUpX:(float)powerUpCoordX powerUpY:(float)powerUpCoordY
{
    if([powerUpType isEqual:@"healthbar.png"])
    {
        self.specialKey =@"health";
        
    }
    if([powerUpType  isEqual:@"powerup_shield.png" ])
    {
        self.specialKey = @"shield";
        
    }
    if([powerUpType isEqual:@"powerup_weapon.png"])
    {
        self.specialKey =@"ammo";
    }
    
    self.moveVelocity = GLKVector2Make(0, -50);
    self.position = GLKVector2Make(powerUpCoordX, powerUpCoordY);
    return self;
}

@end
