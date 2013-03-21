//
//  ProtoSprite.h
//  OpenGLTestProgram
//
//  Created by Jose Mari Salandanan on 11/20/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface ProtoSprite : NSObject
{
    NSArray *frames;

}
@property (assign) GLKVector2 position;
@property (assign) CGSize contentSize;
@property (assign) GLKVector2 moveVelocity;
@property (assign) BOOL isAttacking;
@property (assign) BOOL fromOrigin;
@property (strong) GLKBaseEffect * effect;

@property (strong) GLKTextureInfo * textureInfo;

- (id)initWithFile:(NSString *)fileName effect:(GLKBaseEffect *)effect;
- (void)render;
- (void)update:(float)dt;
- (CGRect)boundingBox;


@end