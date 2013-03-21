//
//  Bomber.m
//  PrototypeApp
//
//  Created by Jose Mari Salandanan on 11/23/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import "Bomber.h"
#import <GLKit/GLKit.h>

@implementation Bomber


/*+(id)spawnBomber
{
    super.effect = [[GLKBaseEffect alloc] init];
    ProtoSprite * target2 = [[ProtoSprite alloc]initWithFile:@"bomber.png" effect:super.effect];
    BOOL originRand = arc4random_uniform(2);
    
    int rangeY2 = 110;
    int actualY2 = (arc4random() % rangeY2) + 150;
    if(originRand)
    {
        
        target2.position = GLKVector2Make(480 + (target2.contentSize.width/2), actualY2);
        target2.moveVelocity = GLKVector2Make(-80,0);
    }
    else
    {
        target2.position = GLKVector2Make(-20 + (target2.contentSize.width/2), actualY2);
        target2.moveVelocity = GLKVector2Make(80,0);
    }
    return target2;
}
*/
@end
