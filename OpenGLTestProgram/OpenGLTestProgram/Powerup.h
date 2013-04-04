//
//  Powerup.h
//  AlienInvasion
//
//  Created by Jose Mari Salandanan on 4/4/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "ProtoSprite.h"

@interface Powerup : ProtoSprite
-(ProtoSprite*)spawnPowerUp:(NSString*)powerUpType powerUpX:(float)powerUpCoordX powerUpY:(float)powerUpCoordY;
@end
