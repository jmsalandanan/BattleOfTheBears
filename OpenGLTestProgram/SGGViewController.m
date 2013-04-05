//
//  ViewController.m
//  OpenGLTestProgram
//
//  Created by Jose Mari Salandanan on 11/20/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import "SGGViewController.h"
#import "ProtoSprite.h"
#import "SimpleAudioEngine.h"
#import "EndGameViewController.h"
#import "MainMenuViewController.h"
//testing


@interface SGGViewController ()

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

@property (strong) NSMutableArray * children;
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

@implementation SGGViewController

@synthesize context = _context;
@synthesize player = _player;
@synthesize children = _children;
@synthesize timeSinceLastSpawn = _timeSinceLastSpawn;
@synthesize shootAnimation;
@synthesize bombAnimation;
@synthesize teleportAnimation;
@synthesize actualVelocity;
@synthesize maxVelocity;
@synthesize minVelocity;
@synthesize rangeVelocity;
@synthesize explodeAnimation;
@synthesize x;
@synthesize y;
@synthesize backGround;
@synthesize playerScore;
@synthesize playerHealth;
@synthesize playerSpecialAmmo;
@synthesize playerMultiplier;
@synthesize enemyCounter;
@synthesize isBossStage;
@synthesize bossHealth;
@synthesize bossArr;
@synthesize gunAnimation;
@synthesize shieldAnimation;
@synthesize scoreLabel;
@synthesize healthLabel;
@synthesize multiplierLabel;
@synthesize specialAmmoLabel;
@synthesize scoreValLabel;
@synthesize pauseButton;
@synthesize isPaused;
@synthesize v;
@synthesize specialButton;

    static NSString * enemyType;
static int firepower;

@synthesize isShielded;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/30.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self]; [super viewDidLoad];
    [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"gamebgm.mp3"];
        GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    [EAGLContext setCurrentContext:self.context];
    self.effect = [[GLKBaseEffect alloc] init];
    SoundLayer *sound = [[SoundLayer alloc]init];
    [sound initializeSounds];
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, 480, 0, 320, -1024, 1024);
    self.effect.transform.projectionMatrix = projectionMatrix;
    self.children = [NSMutableArray array];
    scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(45,280,80,40)];
    healthLabel = [[UILabel alloc]initWithFrame:CGRectMake(450, 275, 40, 40)];
    pauseButton = [[UIButton alloc]initWithFrame:CGRectMake(435, 235, 39, 40)];
    specialButton = [[UIButton alloc]initWithFrame:CGRectMake(415, 195, 80, 40)];
    specialAmmoLabel = [[UILabel alloc]initWithFrame:CGRectMake(450,200,40,40)];
    multiplierLabel = [[UILabel alloc]initWithFrame:CGRectMake(450,150,40,40)];
    [pauseButton addTarget: self
               action: @selector(pauseButtonPressed:)
     forControlEvents: UIControlEventTouchDown];
    [specialButton addTarget:self action:@selector(specialButtonPressed:) forControlEvents:UIControlEventTouchDown];
    playerMultiplier = 1;
    [scoreLabel setText:@"0"];
    [healthLabel setText:@"5"];
//    [multiplierLabel setText:@"1"];
    [specialAmmoLabel setText:@"0"];
    [pauseButton setImage:[UIImage imageNamed:@"button_home.png"] forState:UIControlStateNormal];
    [pauseButton setImage:[UIImage imageNamed:@"buttonpressed_home.png"] forState:UIControlStateHighlighted];
    [specialButton setImage:[UIImage imageNamed:@"button_specialammo.png"] forState:UIControlStateNormal];
    [specialButton setEnabled:NO];
    
    self.backGround = [[ProtoSprite alloc] initWithFile:@"bg_gameview.png" effect:self.effect];
    self.backGround.position = GLKVector2Make(0, 0);
    
    self.player = [[ProtoSprite alloc] initWithFile:@"player_koala.png" effect:self.effect];
    self.player.position = GLKVector2Make(190, 0);

    self.shield = [[ProtoSprite alloc]initWithFile:@"powerup_shield.png" effect:self.effect];
    self.shield.position = GLKVector2Make(900, 900);
    self.playerHealthBar = [[ProtoSprite alloc]initWithFile:@"healthbar.png" effect:self.effect];
    self.playerHealthBar.position = GLKVector2Make(440,10);
    
    self.playerScoreBar = [[ProtoSprite alloc]initWithFile:@"medal.png" effect: self.effect];
    self.playerScoreBar.position = GLKVector2Make(10, 0);
    
    [healthLabel setBackgroundColor:[UIColor clearColor]];
    [healthLabel setTextColor:[UIColor whiteColor]];
    healthLabel.font = [UIFont fontWithName:@"Chalkduster" size:17.0];
    
    [multiplierLabel setBackgroundColor:[UIColor clearColor]];
    [multiplierLabel setTextColor:[UIColor whiteColor]];
    multiplierLabel.font = [UIFont fontWithName:@"Chalkduster" size:17.0];
    
    [scoreLabel setBackgroundColor:[UIColor clearColor]];
    [scoreLabel setTextColor:[UIColor whiteColor]];
    scoreLabel.font = [UIFont fontWithName:@"Chalkduster" size:17.0];
    
    [specialAmmoLabel setBackgroundColor:[UIColor clearColor]];
    [specialAmmoLabel setTextColor:[UIColor whiteColor]];
    specialAmmoLabel.font = [UIFont fontWithName:@"Chalkduster" size:17.0];
    
    [self.children addObject:self.backGround];
    [self.children addObject:self.player];
    [self.children addObject:self.shield];
    [self.children addObject:self.playerHealthBar];
    [self.children addObject:self.playerScoreBar];
   
    //Resized images
    self.player.contentSize = CGSizeMake(self.player.contentSize.width/2, self.player.contentSize.height/2);
    self.shield.contentSize = CGSizeMake(self.shield.contentSize.width/2, self.shield.contentSize.height/2);
    self.playerScoreBar.contentSize = CGSizeMake(self.playerScoreBar.contentSize.width/2, self.playerScoreBar.contentSize.height/2);
    self.backGround.contentSize = CGSizeMake(self.backGround.contentSize.width/2, self.backGround.contentSize.height/2);
    
    UIWindow* wnd = [UIApplication sharedApplication].keyWindow;
    v = [[UIView alloc] initWithFrame: CGRectMake(0, 0, wnd.frame.size.width, wnd.frame.size.height)];
    [wnd addSubview: v];
    [view addSubview:specialButton];
    [view addSubview:scoreLabel];
    [view addSubview:multiplierLabel];
    [view addSubview:specialAmmoLabel];
    [view addSubview:healthLabel];
    [view addSubview:pauseButton];


    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    //array initializers
    self.projectiles = [NSMutableArray array];
    self.targets = [NSMutableArray array];
    self.bomber = [NSMutableArray array];
    self.suicideBomber = [NSMutableArray array];
    self.fastBomber = [NSMutableArray array];
    self.bomb = [NSMutableArray array];
    self.bossArr = [NSMutableArray array];
    self.powerUps = [NSMutableArray array];
    //***********************************************
    
    //BombAnimation
    shootAnimation = [[UIImageView alloc] initWithFrame:
                             CGRectMake(185, -60, 0, 320)];

    NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"1.png"],
                             [UIImage imageNamed:@"2.png"],
                             [UIImage imageNamed:@"3.png"],
                             [UIImage imageNamed:@"4.png"],
                             [UIImage imageNamed:@"5.png"],
                             [UIImage imageNamed:@"6.png"],
                             [UIImage imageNamed:@"7.png"],
                             [UIImage imageNamed:@"8.png"],
                             [UIImage imageNamed:@"9.png"],
                             [UIImage imageNamed:@"10.png"],
                             [UIImage imageNamed:@"11.png"],
                             [UIImage imageNamed:@"12.png"],
                             [UIImage imageNamed:@"13.png"],
                             [UIImage imageNamed:@"14.png"],
                             [UIImage imageNamed:@"15.png"],
                             nil];
    shootAnimation.animationImages = imageArray;
    shootAnimation.contentMode = UIViewContentModeBottomLeft;
    [self.view addSubview:shootAnimation];
    [shootAnimation setAnimationDuration:0.3];
    //shield
    shieldAnimation = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"powerup_shield.png"]];
    
    //Resized image

    //**********
    
    //***********************************************
    //BombAnimation
    bombAnimation = [[UIImageView alloc] initWithFrame:
                      CGRectMake(185, -60, 0, 320)];
    
    NSArray * imageBombArray  = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"bomb1.png"],
                             [UIImage imageNamed:@"bomb2.png"],
                             [UIImage imageNamed:@"bomb3.png"],
                             [UIImage imageNamed:@"bomb4.png"],
                             nil];
    bombAnimation.animationImages = imageBombArray;
    bombAnimation.contentMode = UIViewContentModeBottomLeft;
    [self.view addSubview:bombAnimation];
    [bombAnimation setAnimationDuration:0.2];
    
    //***********************************************
    
    //***********************************************
    //teleportAnimation
    teleportAnimation = [[UIImageView alloc] initWithFrame:
                     CGRectMake(185, -60, 0, 320)];
    
    NSArray * imageteleportArray  = [[NSArray alloc] initWithObjects:
                                 [UIImage imageNamed:@"b1.png"],
                                 [UIImage imageNamed:@"b2.png"],
                                 [UIImage imageNamed:@"b3.png"],
                                 [UIImage imageNamed:@"b4.png"],
                                 [UIImage imageNamed:@"b5.png"],
                                 [UIImage imageNamed:@"b6.png"],
                                 [UIImage imageNamed:@"b7.png"],
                                 [UIImage imageNamed:@"b8.png"],
                                 nil];
    teleportAnimation.animationImages = imageteleportArray;
    teleportAnimation.contentMode = UIViewContentModeBottomLeft;
    [self.view addSubview:teleportAnimation];
    [teleportAnimation setAnimationDuration:0.2];
    
    //***********************************************
    
    //PlayerGun Animation
    gunAnimation = [[UIImageView alloc] initWithFrame:
                      CGRectMake(185, -60, 0, 320)];
    NSArray * imageGunArray = [[NSArray alloc]initWithObjects:
                                 [UIImage imageNamed:@"gun1.png"],
                                 [UIImage imageNamed:@"gun2.png"],
                                 [UIImage imageNamed:@"gun3.png"],
                                 [UIImage imageNamed:@"gun4.png"],
                                 [UIImage imageNamed:@"gun5.png"],
                                 [UIImage imageNamed:@"gun6.png"],
                                 [UIImage imageNamed:@"gun7.png"],
                                 [UIImage imageNamed:@"gun8.png"],
                                 [UIImage imageNamed:@"gun9.png"],
                                 [UIImage imageNamed:@"gun10.png"],
                                 [UIImage imageNamed:@"gun11.png"],
                                 [UIImage imageNamed:@"gun12.png"],
                                 [UIImage imageNamed:@"gun13.png"],
                                 [UIImage imageNamed:@"gun14.png"],

                                 nil];
    gunAnimation.animationImages = imageGunArray;
    gunAnimation.contentMode = UIViewContentModeBottomLeft;
    [self.view addSubview:gunAnimation];
    [gunAnimation setAnimationDuration:0.5];
    //***********************************************
    
    //Enemy Explosion Animation
    explodeAnimation = [[UIImageView alloc] initWithFrame:
                        CGRectMake(0, 0, 0, 320)];
    NSArray * imageExplosionArray  = [[NSArray alloc] initWithObjects:
                                      [UIImage imageNamed:@"ship1.png"],
                                      [UIImage imageNamed:@"ship2.png"],
                                      [UIImage imageNamed:@"ship3.png"],
                                      [UIImage imageNamed:@"ship4.png"],
                                      [UIImage imageNamed:@"ship5.png"],
                                      [UIImage imageNamed:@"ship6.png"],
                                      [UIImage imageNamed:@"ship7.png"],
                                      [UIImage imageNamed:@"ship8.png"],
                                      [UIImage imageNamed:@"ship9.png"],
                                      [UIImage imageNamed:@"ship10.png"],
                                      [UIImage imageNamed:@"ship11.png"],
                                      [UIImage imageNamed:@"ship12.png"],
                                      nil];
    explodeAnimation.animationImages = imageExplosionArray;
    explodeAnimation.contentMode = UIViewContentModeBottomLeft;
    [explodeAnimation setAnimationDuration:0.2];
    explodeAnimation.animationRepeatCount = 1;
    [self.view addSubview:explodeAnimation];
    
    /*Shield Animation
    shieldAnimation = [[UIImageView alloc]initWithFrame:CGRectMake(50,50,0,320)];
    NSArray *shieldArray = [[NSArray alloc]initWithObjects:
                            [UIImage imageNamed:@"sh1.png"],
                            [UIImage imageNamed:@"sh2.png"],
                            [UIImage imageNamed:@"sh3.png"],
                            [UIImage imageNamed:@"sh4.png"],
                            [UIImage imageNamed:@"sh5.png"],
                            [UIImage imageNamed:@"sh6.png"],
                            [UIImage imageNamed:@"sh7.png"],
                            [UIImage imageNamed:@"sh8.png"],
                            [UIImage imageNamed:@"sh9.png"],
                            [UIImage imageNamed:@"sh10.png"],
                            nil];
    shieldAnimation.animationImages = shieldArray;
    shieldAnimation.contentMode = UIViewContentModeBottomLeft;
    [explodeAnimation setAnimationDuration:0.2];
    explodeAnimation.animationRepeatCount = 1;
    [self.view addSubview:shieldAnimation];
*/
    //***********************************************
    playerHealth = 5;
    [self flashScreen];
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = CGPointMake(touchLocation.x, 320 - touchLocation.y);
    GLKVector2 target = GLKVector2Make(touchLocation.x, touchLocation.y);
    GLKVector2 offset = GLKVector2Subtract(target, self.player.position);
    GLKVector2 normalizedOffset = GLKVector2Normalize(offset);
    static float POINTS_PER_SECOND = 480;
    GLKVector2 moveVelocity = GLKVector2MultiplyScalar(normalizedOffset, POINTS_PER_SECOND);
    if(!gunAnimation.isAnimating)
    {
    [SoundLayer playSound:@"playershoot1.mp3"];
        NSString *ammo = (firepower == 0? @"weapon_playerammo1.png": (firepower % 2 == 0?@"weapon_playerammo3.png":@"weapon_playerammo2.png"));
    ProtoSprite * sprite = [[ProtoSprite alloc] initWithFile:ammo effect:self.effect];
        //Resized image
        sprite.contentSize = CGSizeMake(sprite.contentSize.width/2, sprite.contentSize.height/2);
    sprite.position = GLKVector2Make(self.player.position.x+20, self.player.position.y +50);
    sprite.moveVelocity = moveVelocity;
    [self.children addObject:sprite];
    [self.projectiles addObject:sprite];
    gunAnimation.animationRepeatCount = 1;
    [gunAnimation setFrame:CGRectMake(self.player.position.x-10, -60, 0, 320)];
    [gunAnimation startAnimating];
    [self performSelector:@selector(gunAnimationDone) withObject:nil afterDelay:0.5];
    } 
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
     return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

#pragma mark - GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(1, 1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    for (ProtoSprite * sprite in self.children) {
        [sprite render];
    }
}

//addTarget function creates instances of enemy.
- (void)addTarget{
        ProtoSprite * target = [[ProtoSprite alloc] initWithFile:@"enemy_polarbear.png" effect:self.effect];
    //Resized image
    target.contentSize = CGSizeMake(target.contentSize.width/2, target.contentSize.height/2);
        target.isAttacking = FALSE;
        [self.children addObject:target];
        BOOL originRand = arc4random_uniform(2);
        int minY = 200;
        int maxY = 280;
        int rangeY = maxY - minY;
        int actualY = (arc4random() % rangeY) + minY;
        minVelocity = 480.0/4.0;
        maxVelocity = 480.0/2.0;
        rangeVelocity = maxVelocity - minVelocity;
        actualVelocity = (arc4random() % rangeVelocity) + minVelocity;
            if(originRand)
            {
                target.position = GLKVector2Make(480 + (target.contentSize.width/2), actualY);
                target.moveVelocity = GLKVector2Make(-100, 0);
                target.fromOrigin = originRand;
            }
            else
            {
                target.position = GLKVector2Make(-20 + (target.contentSize.width/2), actualY);
                target.moveVelocity = GLKVector2Make(100, 0);
                target.fromOrigin = originRand;
            }
        [self.targets addObject:target];
        enemyCounter++;
        NSLog(@"enemy count: %d", enemyCounter);
}


-(void)addBomber{
        ProtoSprite * target2 = [[ProtoSprite alloc]initWithFile:@"enemy_teddybear.png" effect:self.effect];
    //Resized image
    target2.contentSize = CGSizeMake(target2.contentSize.width/2, target2.contentSize.height/2);
        [self.children addObject:target2];
        BOOL originRand = arc4random_uniform(2);    
        int rangeY2 = 110;
        int actualY2 = (arc4random() % rangeY2) + 150;
            if(originRand)
            {        
                target2.position = GLKVector2Make(480 + (target2.contentSize.width/2), actualY2);
                target2.moveVelocity = GLKVector2Make(-actualVelocity,0);
            }
            else
            {
                target2.position = GLKVector2Make(-20 + (target2.contentSize.width/2), actualY2);
                target2.moveVelocity = GLKVector2Make(actualVelocity,0);
            }
        [self.bomber addObject:target2];
        enemyCounter++;
   
}
//Code for spawning suicide panda
-(void)addSuicideBomber{
    ProtoSprite * target3 = [[ProtoSprite alloc]initWithFile:@"enemy_suicidepanda.png" effect:self.effect];
    //Resized image
    target3.contentSize = CGSizeMake(target3.contentSize.width/2, target3.contentSize.height/2);
    [self.children addObject:target3];    
    int rangeY3 = arc4random_uniform(320);
    target3.position = GLKVector2Make(rangeY3, 320);
    target3.moveVelocity = GLKVector2Make(0,-60);
    [self.suicideBomber addObject:target3];
    enemyCounter++;
}
//Code for spawning fast bomber
-(void)addFastBomber{
    ProtoSprite * target4 = [[ProtoSprite alloc]initWithFile:@"enemy_hybridbear.png" effect:self.effect];
    //Resized image
    target4.contentSize = CGSizeMake(target4.contentSize.width/2, target4.contentSize.height/2);
    [self.children addObject:target4];
    BOOL originRand = arc4random_uniform(2);    
    int rangeY2 = 110;
    int actualY2 = (arc4random() % rangeY2) + 150;
        if(originRand)
        {
            target4.position = GLKVector2Make(480 + (target4.contentSize.width/2), actualY2);
            target4.moveVelocity = GLKVector2Make(-300,0);
        }
        else
        {
            target4.position = GLKVector2Make(-20 + (target4.contentSize.width/2), actualY2);
            target4.moveVelocity = GLKVector2Make(300,0);
        }
        [self.fastBomber addObject:target4];
        enemyCounter++;
}


-(void)addBomb:(float )bombX : (float ) bombY {
    NSString * bomb = ([enemyType isEqualToString:@"firstboss"] && isBossStage? @"weapon_boss1.png": ([enemyType isEqualToString:@"secondboss"] && isBossStage? @"weapon_boss2.png": @"weapon_enemybomb.png"));
    ProtoSprite * alienBomb = [[ProtoSprite alloc] initWithFile:bomb effect:self.effect];
    //Resized image
    alienBomb.contentSize = CGSizeMake(alienBomb.contentSize.width/2, alienBomb.contentSize.height/2);
    alienBomb.moveVelocity = GLKVector2Make(0, -50);
    alienBomb.position = GLKVector2Make(bombX, bombY);
    [SoundLayer playSound:@"bombDrop.wav"];
    [self.children addObject:alienBomb];
    [self.bomb addObject:alienBomb];
}

-(void)addShield{

    self.shield.position = GLKVector2Make(self.player.position.x,self.player.position.y);
    /*[self.view addSubview:shieldAnimation];
    shieldAnimation.animationDuration = .3;
    shieldAnimation.animationRepeatCount = 0;
    [shieldAnimation setFrame:CGRectMake(self.player.position.x - 20, self.player.position.y, 0, 320)];
    [shieldAnimation startAnimating];
     */

}
-(void)addPowerup:(float )powerUpX : (float ) powerUpY {
    int powerupRandomizer = arc4random_uniform(3);
    NSString *powerUpSprite;
        if(powerupRandomizer == 0)
        {
            powerUpSprite = @"healthbar.png";
        }
        if(powerupRandomizer == 1)
        {
            powerUpSprite =@"powerup_shield.png";
        }
        if(powerupRandomizer == 2)
        {
            powerUpSprite=@"powerup_weapon.png";
        }

    ProtoSprite * powerUp = [[ProtoSprite alloc] initWithFile:powerUpSprite effect:self.effect];
    
        if([powerUpSprite isEqual:@"healthbar.png"])
        {
            powerUp.specialKey =@"health";

        }
        if([powerUpSprite isEqual:@"powerup_shield.png" ])
        {
            powerUp.specialKey = @"shield";

        }
        if([powerUpSprite isEqual:@"powerup_weapon.png"])
        {
            powerUp.specialKey =@"ammo";
        }
    //Resized image
    powerUp.contentSize = CGSizeMake(powerUp.contentSize.width/2, powerUp.contentSize.height/2);
        powerUp.moveVelocity = GLKVector2Make(0, -50);
        powerUp.position = GLKVector2Make(powerUpX, powerUpY);
        [SoundLayer playSound:@"bombDrop.wav"];
        [self.children addObject:powerUp];
        [self.powerUps addObject:powerUp];
}

-(void)addBoss{
        _levelCount += 1;
        if(!isBossStage)
        {
            NSString *bossSprite;
            if (_levelCount == 1)
            {
                bossSprite = @"enemy_boss1_carebear.png";
                bossHealth = 10;
                enemyType = @"firstboss";
            }
            if (_levelCount == 2)
            {
                bossSprite = @"enemy_boss2_cybear.png";
                bossHealth = 20;
                enemyType = @"secondboss";
            }
            if (_levelCount == 3)
            {
                bossSprite = @"enemy_boss3_giantpanda.png";
                bossHealth = 30;
            }
            
            ProtoSprite * boss = [[ProtoSprite alloc]initWithFile:bossSprite effect:self.effect];
            //Resized image
            boss.contentSize = CGSizeMake(boss.contentSize.width/2, boss.contentSize.height/2);
            [self.children addObject:boss];
            [self.bossArr addObject:boss];
            boss.position = GLKVector2Make(480 +(boss.contentSize.width/2),250);
            boss.moveVelocity = GLKVector2Make(-300,0);
        }
}

//First Boss AI
-(void)firstBoss{
for(ProtoSprite *boss in self.bossArr)
{
    int rand = arc4random_uniform(10);
    if(rand==3)
    {
        boss.isAttacking = TRUE;
        [self addBomb:boss.position.x :boss.position.y];
    }    
    if(boss.position.x<=0)
    {
        boss.moveVelocity = GLKVector2Make(300,0);
    }
    else if(boss.position.x>=460)
    {
        boss.moveVelocity = GLKVector2Make(-300,0);
    }
}
}
//2nd Boss AI, Teleport Behavior
-(void)secondBoss{
    static int attackCounter = 0;
    for(ProtoSprite *boss in self.bossArr)
    {
        int rand = arc4random_uniform(10);
        if(rand==3)
        {
            attackCounter++;
            NSLog(@"%d",attackCounter);
            boss.isAttacking = TRUE;
            [self addBomb:boss.position.x :boss.position.y];
        }           
        if(attackCounter ==10)
        {
            NSLog(@"Teleport!");
            [SoundLayer playSound:@"Teleport2.mp3"];
            int teleportRandCoordX = arc4random_uniform(320);
            int teleportRandCoordY = arc4random_uniform(120);
            boss.position = GLKVector2Make(teleportRandCoordX,teleportRandCoordY+150);
            teleportAnimation.animationRepeatCount = 1;
            [teleportAnimation setFrame:CGRectMake(boss.position.x, -boss.position.y, 0, 320)];
            [teleportAnimation startAnimating];
            [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];
            attackCounter = 0;
        }        
        if(boss.position.x<=0)
        {
            boss.moveVelocity = GLKVector2Make(300,0);
        }
        else if(boss.position.x>=460)
        {
            boss.moveVelocity = GLKVector2Make(-300,0);
        }
        
    }
}
//Third Boss Behavior, spawns suicide pandas 
-(void)thirdBoss{
    for(ProtoSprite *boss in self.bossArr)
    {
        int rand = arc4random_uniform(10);
        if(rand==3)
        {
            boss.isAttacking = TRUE;
            [self addBossSuicideBomber:boss.position.x :boss.position.y];
        }        
        if(boss.position.x<=0)
        {
            boss.moveVelocity = GLKVector2Make(300,0);
        }
        else if(boss.position.x>=460)
        {
            boss.moveVelocity = GLKVector2Make(-300,0);
        }
    }
}

//3rd Boss Suicide panda spawning
-(void)addBossSuicideBomber:(float )originX : (float ) originY{
    ProtoSprite * target3 = [[ProtoSprite alloc]initWithFile:@"enemy_suicidepanda.png" effect:self.effect];
    //Resized image
    target3.contentSize = CGSizeMake(target3.contentSize.width/2, target3.contentSize.height/2);
    [self.children addObject:target3];
    target3.position = GLKVector2Make(originX, originY);
    target3.moveVelocity = GLKVector2Make(0,-60);
    [self.suicideBomber addObject:target3];
    enemyCounter++;
}


- (void)update {
   //int temp;
    NSMutableArray * projectilesToDelete = [NSMutableArray array];
    NSMutableArray * targetsToDelete = [NSMutableArray array];
    if(isShielded)
    {
       self.shield.position = GLKVector2Make(self.player.position.x,self.player.position.y);
    }
    
    if(_levelCount == 1)
    {
        [self firstBoss];
    }
    if(_levelCount == 2)
    {
        [self secondBoss];
    }
    if(_levelCount == 3)
    {
        [self thirdBoss];
    }
  
    //checks if bomb's coordinates reaches ground.
    for(ProtoSprite *alienBomb in self.bomb)
    {
        if(alienBomb.position.y<=10)
        {
            [SoundLayer playSound:@"bombground.mp3"];
            shootAnimation.animationRepeatCount = 1;
            [shootAnimation setFrame:CGRectMake(alienBomb.position.x-10, 0, 0, 320)];
            [shootAnimation startAnimating];
            [self.bomb removeObject:alienBomb];
            [self.children removeObject:alienBomb];
            [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];
            break;
        }
    //check if bomb's coordinates collides w/player, reduces player health by 1 point
        if(CGRectIntersectsRect(alienBomb.boundingBox, self.player.boundingBox))
        {
            [SoundLayer playSound:@"bearHit.mp3"];
            [SoundLayer playSound:@"playerHit.mp3"];
            [self flashScreen];
            if(isShielded)
            {
                isShielded = false;
                self.shield.position = GLKVector2Make(700,700);
            }
            else
            {
               playerHealth -=1;
            }
            shootAnimation.animationRepeatCount = 1;
            [shootAnimation setFrame:CGRectMake(alienBomb.position.x-10, 0, 0, 320)];
            [shootAnimation startAnimating];
            [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];
            [self.bomb removeObject:alienBomb];
            [self.children removeObject:alienBomb];
            [healthLabel setText:[NSString stringWithFormat:@"%d",playerHealth]];
                if(playerHealth <=0)
                {
                    EndGameViewController *endGameViewController = [[EndGameViewController alloc]init];
                    endGameViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    firepower = 0;
                    endGameViewController.temp = playerScore;
                    //[self presentModalViewController:endGameViewController animated:YES];
                    [self presentViewController:endGameViewController animated:YES completion:nil];
                }
            break;
        }
    }
    for(ProtoSprite *powerUp in self.powerUps)
    {
        if(powerUp.position.y<=10)
        {
            [self.powerUps removeObject:powerUp];
            [self.children removeObject:powerUp];
            break;
        }
        if(CGRectIntersectsRect(powerUp.boundingBox, self.player.boundingBox))
        {
            [self flashScreen];
            if([powerUp.specialKey isEqual: @"health"])
            {
                playerHealth +=1;
                [healthLabel setText:[NSString stringWithFormat:@"%d",playerHealth]];
            }
            
            if([powerUp.specialKey isEqual: @"shield"])
            {
                if(isShielded)
                {
                    playerScore +=100;
                }
                isShielded = TRUE;
                [self addShield];
            }
            if([powerUp.specialKey isEqual: @"ammo"])
            {
              NSLog(@"Ammo picked up");
              playerSpecialAmmo+=1;
              firepower++;
              [specialAmmoLabel setText:[NSString stringWithFormat:@"%d",playerSpecialAmmo]];
                if(playerSpecialAmmo > 0)
                {
                    [specialButton setEnabled:YES];
                }
            }
            [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];
            [self.powerUps removeObject:powerUp];
            [self.children removeObject:powerUp];
            break;
        }
    }

    //Checks if every instance of target reaches the end of the screen, therefore destroying it.
    for(ProtoSprite *target in self.targets)
    {
        if(target.position.x<=-800)
        {
            [self.targets removeObject:target];
            [self.children removeObject:target];            
            return;
        }
        if(target.position.x>=550)
        {
            [self.targets removeObject:target];
            [self.children removeObject:target];            
            return;
        }
    }
    
    //AI behavior of bombers on when to drop bomb.
    for(ProtoSprite *target2 in self.bomber)
    {
        if(target2.position.x<=self.player.position.x+80&&!target2.isAttacking)
        {
            int rand = arc4random_uniform(10);
            if(rand==3)
            {
                target2.isAttacking = TRUE;
                [self addBomb:target2.position.x :target2.position.y];
            }
        }
        if(target2.position.x<=-50)
        {
            [self.bomber removeObject:target2];
            [self.children removeObject:target2];
            return;
        }
        if(target2.position.y>=550)
        {
            [self.bomber removeObject:target2];
            [self.children removeObject:target2];
            return;
        }
    }


    //Check suicide bombers if they reach ground or collide with player
    for(ProtoSprite *target3 in self.suicideBomber)
    {
        if(target3.position.y<=10)
        {
            [SoundLayer playSound:@"bombground.mp3"];
            shootAnimation.animationRepeatCount = 1;
            [shootAnimation setFrame:CGRectMake(target3.position.x-10, 0, 0, 320)];
            [shootAnimation startAnimating];
            [self.suicideBomber removeObject:target3];
            [self.children removeObject:target3];
            [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];
            break;
        }
        if(CGRectIntersectsRect(target3.boundingBox, self.player.boundingBox))
        {
            [SoundLayer playSound:@"bombground.mp3"];
            [SoundLayer playSound:@"bearHit2.mp3"];
            [self flashScreen];            
            if(!isShielded)
            {
                playerHealth -=1;
            }
            else
            {
                self.shield.position = GLKVector2Make(700,700);
                isShielded = FALSE;
                [shieldAnimation stopAnimating];
            }
            shootAnimation.animationRepeatCount = 1;
            [shootAnimation setFrame:CGRectMake(target3.position.x-10, 0, 0, 320)];
            [shootAnimation startAnimating];
            [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];
            [self.suicideBomber removeObject:target3];
            [self.children removeObject:target3];
            [healthLabel setText:[NSString stringWithFormat:@"%d",playerHealth]];
            
            if(playerHealth <=0)
            {
                EndGameViewController *endGameViewController = [[EndGameViewController alloc]init];
                endGameViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                endGameViewController.temp = playerScore;
                //[self presentModalViewController:endGameViewController animated:YES];
                [self presentViewController:endGameViewController animated:YES completion:nil];
                NSLog(@"Game Ends");
            }
            break;
        }


    }

    //Checks if every instance of target4 reaches the end of the screen, therefore destroying it.
    for(ProtoSprite *target4 in self.fastBomber)
    {
        if(target4.position.x<=self.player.position.x+80&&!target4.isAttacking)
        {
            int rand = arc4random_uniform(10);
            if(rand==3)
            {
                target4.isAttacking = TRUE;
                [self addBomb:target4.position.x :target4.position.y];
            }
        }

        if(target4.position.x<=-800)
        {
            [self.fastBomber removeObject:target4];
            [self.children removeObject:target4];
            
            return;
        }
        if(target4.position.x>=550)
        {
            [self.fastBomber removeObject:target4];
            [self.children removeObject:target4];
            
            return;
        }
        
    }
  
    //Checks if player projectile reaches end of screen. If condition is met, projectile is removed and dealloced.
    for(ProtoSprite *projectile in self.projectiles){
            if(projectile.position.x>=480||projectile.position.x<=-20||projectile.position.y>=320)
            {
                NSLog(@"%f",projectile.position.y);
                playerMultiplier = 1;
                [multiplierLabel setText:(playerMultiplier == 1? [NSString stringWithFormat:@" "]: [NSString stringWithFormat:@"%d",playerMultiplier])];
                [self.projectiles removeObject:projectile];
                [self.children removeObject:projectile];
                return;
            
            }
    }
    //Checks if player projectile collides with target, adds score and destroys both projectiles and targets.
    for (ProtoSprite * projectile in self.projectiles)
    {
        for (ProtoSprite * target in self.targets)
        {
            x=target.position.x;
            y=-target.position.y;
            if (CGRectIntersectsRect(projectile.boundingBox, target.boundingBox))
            {
                [SoundLayer playSound:@"playerHit.mp3"];
                
                [self.view addSubview:explodeAnimation];
                [explodeAnimation setFrame:CGRectMake(x, y, 0, 320)];
                [explodeAnimation startAnimating];
                
                playerScore += (15*playerMultiplier);
                [self flashMultiplier:x+20 setCoordinateY:280-target.position.y setFlashScoreVal:(15*playerMultiplier)];
                playerMultiplier +=1;
                [multiplierLabel setText:[NSString stringWithFormat:@"%d",playerMultiplier]];
                [scoreLabel setText:[NSString stringWithFormat:@"%d",playerScore]];

                [targetsToDelete addObject:target];
                [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];
            }
        }
        
        //Same as above function, for bomber enemy.
        for(ProtoSprite *target2 in self.bomber)
        {
                x=target2.position.x;
                y=-target2.position.y;            
                if (CGRectIntersectsRect(projectile.boundingBox, target2.boundingBox))
                {
                    [SoundLayer playSound:@"playerHit.mp3"];
                    [self.view addSubview:explodeAnimation];
                    [explodeAnimation setFrame:CGRectMake(x, y, 0, 320)];
                    [explodeAnimation startAnimating];

                                [self flashMultiplier:x+20 setCoordinateY:280-target2.position.y setFlashScoreVal:(30*playerMultiplier)];                    playerMultiplier +=1;
                    playerScore += (30 *playerMultiplier);
                    [multiplierLabel setText:[NSString stringWithFormat:@"%d",playerMultiplier]];
                    [scoreLabel setText:[NSString stringWithFormat:@"%d",playerScore]];

                    [projectilesToDelete addObject:projectile];
                    [self.bomber removeObject:target2];
                    [self.children removeObject:target2];
                    [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];
                    break;
                }
        }
        //same as above function, for suicide bomber enemy
        for(ProtoSprite *target3 in self.suicideBomber)
        {
            x=target3.position.x;
            y=-target3.position.y;
            if (CGRectIntersectsRect(projectile.boundingBox, target3.boundingBox))
            {
                [SoundLayer playSound:@"playerHit.mp3"];
                [self.view addSubview:explodeAnimation];
                [explodeAnimation setFrame:CGRectMake(x, y, 0, 320)];                
                [explodeAnimation startAnimating];
               
                [self addBomb:target3.position.x :target3.position.y];
                [self addBomb:target3.position.x - 50 :target3.position.y];
                [self addBomb:target3.position.x + 50:target3.position.y];
                
                playerScore += (50*playerMultiplier);
                [scoreLabel setText:[NSString stringWithFormat:@"%d",playerScore]];
                [self flashMultiplier:x+20 setCoordinateY:280-target3.position.y setFlashScoreVal:(50*playerMultiplier)];
                playerMultiplier +=1;
                [multiplierLabel setText:[NSString stringWithFormat:@"%d",playerMultiplier]];
                
                [projectilesToDelete addObject:projectile];
                [self.suicideBomber removeObject:target3];
                [self.children removeObject:target3];
                [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];
                break;
            }
        }
        for(ProtoSprite *target4 in self.fastBomber)
        {
            x=target4.position.x;
            y=-target4.position.y;
            if (CGRectIntersectsRect(projectile.boundingBox, target4.boundingBox))
            {
                [SoundLayer playSound:@"playerHit.mp3"];
                [self.view addSubview:explodeAnimation];
                [explodeAnimation setFrame:CGRectMake(x, y, 0, 320)];
                [explodeAnimation startAnimating];
                
                [self addPowerup:target4.position.x :target4.position.y];
                
                playerScore += (70*playerMultiplier);
                [self flashMultiplier:x+20 setCoordinateY:280-target4.position.y setFlashScoreVal:(70*playerMultiplier)];
                [scoreLabel setText:[NSString stringWithFormat:@"%d",playerScore]];
                playerMultiplier +=1;
                [multiplierLabel setText:[NSString stringWithFormat:@"%d",playerMultiplier]];
                
                [projectilesToDelete addObject:projectile];
                [self.fastBomber removeObject:target4];
                [self.children removeObject:target4];
                [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];

                break;
            }
        }

        //Same as above function, bomb.
        for(ProtoSprite *alienBomb in self.bomb)
        {
            x=alienBomb.position.x;
            y=-alienBomb.position.y;
            if (CGRectIntersectsRect(projectile.boundingBox, alienBomb.boundingBox)) {
                [SoundLayer playSound:@"playerHit.mp3"];
                NSLog(@"Bomb Destroyed");
                [self.view addSubview:bombAnimation];
                [bombAnimation setAnimationRepeatCount:1];
                [bombAnimation setFrame:CGRectMake(x, y, 0, 320)];
                [bombAnimation startAnimating];
                [self.bomb removeObject:alienBomb];
                [self.children removeObject:alienBomb];
                [self performSelector:@selector(animation2Done) withObject:nil afterDelay:0.3];
                break;
            }
        }

        //Same as above function, boss
        for(ProtoSprite *boss in self.bossArr )
        {
            x=boss.position.x;
            y=-boss.position.y;
            if (CGRectIntersectsRect(projectile.boundingBox, boss.boundingBox))
            {
                [SoundLayer playSound:@"playerHit.mp3"];
                [self.view addSubview:explodeAnimation];
                [explodeAnimation setFrame:CGRectMake(x, y, 0, 320)];
                [explodeAnimation startAnimating];
                [projectilesToDelete addObject:projectile];
                bossHealth--;
 
                [self performSelector:@selector(explodeAnimationDone) withObject:nil afterDelay:0.3];
                if(bossHealth<=0)
                {
                    playerScore +=100;
                    enemyType = @"";
                    [self.bossArr removeObject:boss];
                    [self.children removeObject:boss];
                        if(_levelCount == 3)
                        {
                            EndGameViewController *endGameViewController = [[EndGameViewController alloc]init];
                            endGameViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                            endGameViewController.temp = playerScore;
                           // [self presentModalViewController:endGameViewController animated:YES];
                            [self presentViewController:endGameViewController animated:YES completion:nil];
                        }
                    isBossStage =FALSE;
                    enemyCounter = 0;                    
                }
                break;
            }
        }
        
        //deletes dealloced objects
        for (ProtoSprite * target in targetsToDelete)
        {
            [self.targets removeObject:target];
            [self.children removeObject:target];
        }        
        if (targetsToDelete.count > 0)
        {
            [projectilesToDelete addObject:projectile];
        }
    }
    
    for (ProtoSprite * projectile in projectilesToDelete)
    {
        [self.projectiles removeObject:projectile];
        [self.children removeObject:projectile];
    }
    for (ProtoSprite * target2 in targetsToDelete)
    {
        [self.projectiles removeObject:target2];
        [self.children removeObject:target2];
    }
    for (ProtoSprite * target3 in targetsToDelete)
    {
        [self.projectiles removeObject:target3];
        [self.children removeObject:target3];
    }
    for (ProtoSprite * target4 in targetsToDelete)
    {
        [self.projectiles removeObject:target4];
        [self.children removeObject:target4];
    }
    for (ProtoSprite * projectile in projectilesToDelete)
    {
        [self.projectiles removeObject:projectile];
        [self.children removeObject:projectile];
    }
    
    self.timeSinceLastSpawn += self.timeSinceLastUpdate;
    if (self.timeSinceLastSpawn > 1.0)
    {
        self.timeSinceLastSpawn = 0;
        if(!isBossStage)
        {
            [self addTarget];
            int r = arc4random_uniform(74);
            if(r<25)
            {
                return;
            }
            if(r>25&&r<60)
            {
                [self addBomber];
            }
            if(r>40&&r<60)
            {
                [self addSuicideBomber];
            }
            if(r>60)
            {
                [self addFastBomber];
            }
        }
    }
    
    for (ProtoSprite * sprite in self.children)
    {
        [sprite update:self.timeSinceLastUpdate];
    }
    
    if(enemyCounter >=50)
    {
        if(!isBossStage)
        {
            [self addBoss];
            isBossStage=TRUE;        
        }
    }
}

-(void)explodeAnimationDone
{
    [explodeAnimation stopAnimating];
    [self.children removeObject:explodeAnimation];
}
-(void)animation2Done
{
    [shootAnimation stopAnimating];
    [self.children removeObject:shootAnimation];
}
-(void)gunAnimationDone
{
    [gunAnimation stopAnimating];
    [self.children removeObject:gunAnimation];
}
- (void)viewDidUnload {
    [self setScoreLabel:nil];
    firepower = 0;
    [super viewDidUnload];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    float valueX = acceleration.y*30.0;
    int newX = (int)(self.player.position.x + valueX);
    
    if (newX > 440-player_Radius)
    {
        newX = 440-player_Radius;
    }
    
    if (newX < 0 + player_Radius)
    {
        newX = 0 + player_Radius;
    }
    self.player.position = GLKVector2Make(newX, 0);
}

-(void)pauseButtonPressed: (id)sender
{
    NSLog(@"Button PResesed");
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    //[self presentModalViewController:mainMenuViewController animated:YES];
    [self presentViewController:mainMenuViewController animated:YES completion:nil];
}

-(void)specialButtonPressed: (id)sender
{
    int specialX = 50, specialY = 50;
    if(gunAnimation.isAnimating == false &&playerSpecialAmmo!=0)
    {
        for(int shootCounter = 0; shootCounter <=5;shootCounter++)
        {
            GLKVector2 target = GLKVector2Make(specialX , specialY);
            GLKVector2 offset = GLKVector2Subtract(target, self.player.position);
            GLKVector2 normalizedOffset = GLKVector2Normalize(offset);
            static float POINTS_PER_SECOND = 480;
            GLKVector2 moveVelocity = GLKVector2MultiplyScalar(normalizedOffset, POINTS_PER_SECOND);
            [SoundLayer playSound:@"playershoot1.mp3"];
            ProtoSprite * sprite = [[ProtoSprite alloc] initWithFile:@"weapon_playerammo3.png" effect:self.effect];
            sprite.position = GLKVector2Make(self.player.position.x+20, self.player.position.y +50);
            sprite.moveVelocity = moveVelocity;
            [self.children addObject:sprite];
            [self.projectiles addObject:sprite];
            specialX +=50;
            NSLog(@"Projectile :%d is shooting at X: %d",shootCounter,specialX);
        }
            gunAnimation.animationRepeatCount = 1;
            [gunAnimation setFrame:CGRectMake(self.player.position.x-10, -60, 0, 320)];
            [gunAnimation startAnimating];
            [self flashScreen];
            playerSpecialAmmo -=1;
            [specialAmmoLabel setText:[NSString stringWithFormat:@"%d",playerSpecialAmmo]];
            if(playerSpecialAmmo == 0)
                {
                    [specialButton setEnabled:NO];
                }
    }
    else
    {
        return;
    }
}

-(void) flashScreen
{
    v.alpha = 1;
    v.backgroundColor = [UIColor whiteColor];
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration: .3];
    v.alpha = 0.0f;
    [UIView commitAnimations];
}

-(void) flashMultiplier:(float)coordinatex setCoordinateY:(float)coordinatey  setFlashScoreVal:(int)val
{
    // Create a blinking text
    UILabel* labelText = [[UILabel alloc] initWithFrame:CGRectMake(coordinatex, coordinatey, 400, 50)];
    labelText.text = [NSString stringWithFormat:@"%d",val];
    labelText.font = [UIFont fontWithName:@"Chalkduster" size:17.0];
    labelText.backgroundColor = [UIColor clearColor];
    labelText.textColor = [UIColor whiteColor];
    [self.view addSubview:labelText];
    NSLog(@"%f, %f",coordinatex,coordinatey);
    
    void (^animationLabel) (void) = ^{
        labelText.alpha = 0;
    };
    void (^completionLabel) (BOOL) = ^(BOOL f) {
        labelText.alpha = 1;
    };
    void (^animationLabel2) (void) = ^{
        labelText.alpha = 1;
    };
    void (^completionLabel2) (BOOL) = ^(BOOL f) {
        labelText.alpha = 0;
    };
    [UIView animateWithDuration:1 animations:animationLabel completion:completionLabel];
    [UIView animateWithDuration:1 animations:animationLabel2 completion:completionLabel2];
}

@end