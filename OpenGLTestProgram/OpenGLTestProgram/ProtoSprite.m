//
//  ProtoSprite.m
//  OpenGLTestProgram
//
//  Created by Jose Mari Salandanan on 11/20/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import "ProtoSprite.h"

typedef struct {
    CGPoint geometryVertex;
    CGPoint textureVertex;
} TexturedVertex;

typedef struct {
    TexturedVertex bl;
    TexturedVertex br;
    TexturedVertex tl;
    TexturedVertex tr;
} TexturedQuad;
@interface ProtoSprite()

@property (assign) TexturedQuad quad;

@end

@implementation ProtoSprite
@synthesize effect = _effect;
@synthesize quad = _quad;
@synthesize textureInfo = _textureInfo;
@synthesize position = _position;
@synthesize contentSize = _contentSize;
@synthesize moveVelocity = _moveVelocity;
@synthesize isAttacking;
@synthesize fromOrigin;
@synthesize specialKey;
@synthesize rotation = _rotation;
@synthesize scale = _scale;


- (id)initWithFile:(NSString *)fileName effect:(GLKBaseEffect *)effect {
    if ((self = [super init])) {
        // 1
        self.effect = effect;
        self.scale = 0.2;
        
        // 2
        NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithBool:YES],
                                  GLKTextureLoaderOriginBottomLeft,
                                  nil];
        
        // 3
        NSError * error;
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        // 4
        self.textureInfo = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
        if (self.textureInfo == nil) {
            NSLog(@"Error loading file: %@", [error localizedDescription]);
            return nil;
        }
        self.contentSize = CGSizeMake(self.textureInfo.width, self.textureInfo.height);
        // TODO: Set up Textured Quad
        TexturedQuad newQuad;
        newQuad.bl.geometryVertex = CGPointMake(0, 0);
        newQuad.br.geometryVertex = CGPointMake(self.textureInfo.width/2, 0);
        newQuad.tl.geometryVertex = CGPointMake(0, self.textureInfo.height/2);
        newQuad.tr.geometryVertex = CGPointMake(self.textureInfo.width/2, self.textureInfo.height/2);
        
        newQuad.bl.textureVertex = CGPointMake(0, 0);
        newQuad.br.textureVertex = CGPointMake(1, 0);
        newQuad.tl.textureVertex = CGPointMake(0, 1);
        newQuad.tr.textureVertex = CGPointMake(1, 1);
        self.quad = newQuad;
        
    }
    return self;
}
- (GLKMatrix4) modelMatrix {
    
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, 0);
    return modelMatrix;
    
}
- (void)render {
    
    // 1
    self.effect.texture2d0.name = self.textureInfo.name;
    self.effect.texture2d0.enabled = YES;
    self.effect.transform.modelviewMatrix = self.modelMatrix;
    // 2
    [self.effect prepareToDraw];
    
    // 3
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    // 4
    long offset = (long)&_quad;
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(TexturedVertex), (void *) (offset + offsetof(TexturedVertex, geometryVertex)));
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(TexturedVertex), (void *) (offset + offsetof(TexturedVertex, textureVertex)));
    
    // 5
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    
}
- (void)update:(float)dt {
    GLKVector2 curMove = GLKVector2MultiplyScalar(self.moveVelocity, dt);
    self.position = GLKVector2Add(self.position, curMove);
}
- (CGRect)boundingBox {
    CGRect rect = CGRectMake(self.position.x, self.position.y, self.contentSize.width, self.contentSize.height);
    return rect;
}
- (GLKMatrix4) modelMatrix:(BOOL)renderingSelf {
    
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, 0);
    if (renderingSelf) {
        modelMatrix = GLKMatrix4Translate(modelMatrix, -self.contentSize.width/4, -self.contentSize.height/4, 0);
    }
    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, 0);
    

    return modelMatrix;
    
}




@end
