//
//  SGGViewController.h
//  OpenGLTestProgram
//
//  Created by Jose Mari Salandanan on 11/20/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Bomber.h"
#import "Bomb.h"
#import "SuicideBomber.h"
#import "FastBomber.h"
#import "NormalEnemy.h"
#import "Powerup.h"
#import "SoundLayer.h"
#import "Boss.h"

#define player_Radius 40
#define default_Height 320
#define default_Width 0
#define repeatAnimationOnce 1
#define defaultAnimationDuration 0.3
#define randomAttackProbability 10
#define groundCoordinate 10

@interface SGGViewController : GLKViewController <UIAccelerometerDelegate>

@property (strong, nonatomic) EAGLContext *context;
@property (strong) GLKBaseEffect * effect;

@property (strong) ProtoSprite * player;
@property (strong) ProtoSprite * backGround;
@property (strong) ProtoSprite * playerHealthBar;
@property (strong) ProtoSprite * playerScoreBar;
@property (strong) ProtoSprite * shield;

@property (assign) float timeSinceLastSpawn;
@property (assign) float x;
@property (assign) float y;

@property (strong) NSMutableArray *children;
@property (strong) NSMutableArray *projectiles;

@property (strong) NSMutableArray *targets;
@property (strong) NSMutableArray *bomber;
@property (strong) NSMutableArray *suicideBomber;
@property (strong) NSMutableArray *fastBomber;
@property (strong) NSMutableArray *bomb;
@property (strong) NSMutableArray *bossArr;
@property (strong) NSMutableArray *powerUps;

@property (assign) int playerScore;
@property (assign) int playerHealth;
@property (assign) int playerSpecialAmmo;
@property (assign) int enemyCounter;
@property (assign) int  bossHealth;
@property (assign) int actualVelocity;
@property (assign) int maxVelocity;
@property (assign) int minVelocity;
@property (assign) int rangeVelocity;
@property (assign) int levelCount;
@property (assign) int playerMultiplier;

@property (strong)UILabel *scoreLabel;
@property (strong)UILabel *healthLabel;
@property (strong)UILabel *specialAmmoLabel;
@property (strong)UIButton *pauseButton;
@property (strong)UIButton *specialButton;
@property (strong)UILabel *multiplierLabel;
@property (strong)UILabel *scoreValLabel;

@property (assign) BOOL isBossStage;
@property (assign) BOOL isPaused;
@property (assign) BOOL isShielded;

@property (strong)UIImageView *shootAnimation;
@property (strong)UIImageView *explodeAnimation;
@property (strong)UIImageView *gunAnimation;
@property (strong)UIImageView *bombAnimation;
@property (strong)UIImageView *teleportAnimation;
@property (strong)UIImageView *shieldAnimation;
@property (strong)UIView *v;



@end
