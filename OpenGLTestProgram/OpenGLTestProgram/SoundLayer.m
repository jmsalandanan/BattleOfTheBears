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
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"Menu.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"bearHit.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"bearHit2.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"bombground.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"gamebgm.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"gameover.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"Teleport2.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"PlayerHit.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"playershoot1.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"Teleport.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"shipDestroySound.wav"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"gunSound.wav"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"bombSound.wav"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"bombDrop.wav"];



}
+(void)playSound:(NSString *)soundId
{
        [[SimpleAudioEngine sharedEngine] playEffect:soundId];
}
@end
