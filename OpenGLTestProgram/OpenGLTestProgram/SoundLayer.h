//
//  SoundLayer.h
//  PrototypeApp
//
//  Created by Jose Mari Salandanan on 11/26/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"

@interface SoundLayer : NSObject

-(void)initializeSounds;
+(void)playSound:(NSString *)soundId;

@end
