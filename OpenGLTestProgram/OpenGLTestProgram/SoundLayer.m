//
//  SoundLayer.m
//  PrototypeApp
//
//  Created by Jose Mari Salandanan on 11/26/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import "SoundLayer.h"

@implementation SoundLayer

-(void)initializeSounds
{
    //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgmusic.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"crash.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"explosion_small.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"explosion_large.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"laser_enemy.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"maleHit.wav"];
    //[[SimpleAudioEngine sharedEngine]preloadEffect:@"menu.mp3"];
    //[[SimpleAudioEngine sharedEngine]preloadEffect:@"ambiance.wav"];
    [[SimpleAudioEngine sharedEngine]preloadEffect:@"shipDestroySound.wav"];
    [[SimpleAudioEngine sharedEngine]preloadEffect:@"gunSound.wav"];
    [[SimpleAudioEngine sharedEngine]preloadEffect:@"bombSound.wav"];
    [[SimpleAudioEngine sharedEngine]preloadEffect:@"playerDie.wav"];
    [[SimpleAudioEngine sharedEngine]preloadEffect:@"playerHit.wav"];
    [[SimpleAudioEngine sharedEngine]preloadEffect:@"bombDrop.wav"];
}
+(void)playSound:(NSString *)soundId
{
        [[SimpleAudioEngine sharedEngine] playEffect:soundId];
}
@end
