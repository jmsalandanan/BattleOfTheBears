//
//  Bomb.h
//  AlienInvasion
//
//  Created by Jose Mari Salandanan on 4/4/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "ProtoSprite.h"

@interface Bomb : ProtoSprite

-(ProtoSprite *)spawnBomb:(float)bombX bombCoordinateY:(float)bombY bombImage:(NSString*)bomb;

@end

