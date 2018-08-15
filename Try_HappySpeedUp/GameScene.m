//
//  GameScene.m
//  Try_HappySpeedUp
//
//  Created by irons on 2015/9/21.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "GameScene.h"
#import "Player.h"
#import "Wall.h"
#import "CommonUtil.h"
#import "BitmapUtil.h"

@implementation GameScene{
    BitmapUtil* bitmapUtil;
    int offsetX;
    int offsetY;
}

-(void)initGame{
    ((CommonUtil*)[CommonUtil sharedInstance]).screenHeight = self.frame.size.height;
    ((CommonUtil*)[CommonUtil sharedInstance]).screenWidth = self.frame.size.width;
    bitmapUtil = [BitmapUtil sharedInstance];
    offsetX = bitmapUtil.wall_size.width;
    offsetY = bitmapUtil.wall_size.height;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
    
    walls = [NSMutableArray array];
    direction = DIRECTION_RIGHT;
    [self initGame];
    [self createInitWall];
    [self createPlayer];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        
    }
    
    direction = -direction;
    speedX = -speedX;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if(!gameFlag){
        return;
    }
    
    [self move];
    [self draw];
}

int speedX = 2;
int speedY = 3;

bool gameFlag = true;
NSMutableArray* walls;
Player *player;
int playerStartX = 200;
int platerStartY = 200;



int DIRECTION_LEFT = -1;
int DIRECTION_RIGHT = 1;
int direction
;

-(void) createInitWall {
    int wallLeftX = 80, wallRightX = wallLeftX + 200;
    int wallY = ((CommonUtil*)[CommonUtil sharedInstance]).screenHeight;
    
    for (int i = 0; i < 20; i++) {
        [self createWallLineWithLeftX:wallLeftX WithRightX:wallRightX WithY:wallY];
    }
    
}

-(void) createWallLineWithLeftX:(int) wallLeftX WithRightX:(int) wallRightX WithY:(int) wallY{
    if (wallLeftX < 20) {
        offsetX = -offsetX;
    } else if (wallRightX > ((CommonUtil*)[CommonUtil sharedInstance]).screenWidth - 20
               - bitmapUtil.wall_size.width) {
        offsetX = -offsetX;
    }
    
    wallLeftX += offsetX;
    wallRightX += offsetX;
    
    if (wallY <= -offsetY)
        return;
    
    wallY -= offsetY;
    
//    System.out.println("wallY" + wallY);
    
    Wall* wallLeft = [Wall spriteNodeWithTexture:bitmapUtil.wall_bitmap];
    wallLeft.size = bitmapUtil.wall_size;
    wallLeft.position = CGPointMake(wallLeftX, wallY);
    Wall* wallRight = [Wall spriteNodeWithTexture:bitmapUtil.wall_bitmap];
    wallRight.size = bitmapUtil.wall_size;
    wallRight.position = CGPointMake(wallRightX, wallY);
    [self addChild:wallLeft];
    [self addChild:wallRight];
    
    NSMutableArray* wallLine = [NSMutableArray array];
    [wallLine addObject:wallLeft];
    [wallLine addObject:wallRight];
    [walls addObject:wallLine];
}

-(void) createPlayer {
//    player = new Player(playerStartX, platerStartY);
    player = [Player spriteNodeWithImageNamed:@"yellow_point.png"];
    player.size = CGSizeMake(20, 20);
    player.position = CGPointMake(playerStartX, platerStartY);
    [self addChild:player];
}

-(void) move{
    
//    player.move(speedX);
//    player.position = CGPointMake(player.position.x+speedX, player.position.y);
    
    for(SKNode* node in self.children){
        node.position = CGPointMake(node.position.x-speedX, node.position.y);
    }
    
    [self doWallMoveAndCollisionDetectedAndCreateAndRemoveWall];
    
}

-(bool) isCollision:(Player*)player withWall:(Wall*)wall {
    CGRect rectPlayer = player.calculateAccumulatedFrame;
    CGRect rectWall = wall.calculateAccumulatedFrame;
    return CGRectIntersectsRect(rectPlayer, rectWall);
}

-(void) doWallMoveAndCollisionDetectedAndCreateAndRemoveWall {
    bool isCollision = false;
    bool isNeedCreateNewInstance = false;
    bool isNeedRemoveInstance = false;
    int firstCarPosition = 0;
    int LastCatPosition = walls.count - 1;
    Wall* lastLeftWall = nil;
    for (int wallLinePosition = 0; wallLinePosition < walls.count; wallLinePosition++) {
        bool isChecked = false;
        for (Wall* wall in walls[wallLinePosition]) {
            
//            [wall move(speedY)];
            [wall move];
            if(!isChecked){
                isChecked = true;
                if (wallLinePosition == LastCatPosition) {
                    isNeedCreateNewInstance =[wall isNeedCreateNewInstance];
                    lastLeftWall = wall;
                }
                if (wallLinePosition == firstCarPosition) {
                    isNeedRemoveInstance = [wall isNeedRemoveInstance];
                }
            }
            if (!isCollision)
                isCollision = [self isCollision:player withWall:wall];
        }
    }
    
    if (isNeedCreateNewInstance) {
        int wallLeftX = lastLeftWall.position.x;
        int wallRightX = wallLeftX + 190;
        int wallY = lastLeftWall.position.y;
        [self createWallLineWithLeftX:wallLeftX WithRightX:wallRightX WithY:wallY];
    }
    if (isNeedRemoveInstance) {
        NSMutableArray* wallWithLine = walls[firstCarPosition];
        [walls removeObject:wallWithLine];
//        walls.remove(walls.get(firstCarPosition));
        for(Wall* wall in wallWithLine){
            [wall removeFromParent];
        }
    }
    gameFlag = !isCollision;
}

-(void) draw{
//    Canvas canvas = surfaceHolder.lockCanvas();
//    canvas.drawColor(Color.WHITE);
//    
//    player.draw(canvas);
//    
//    for (ArrayList<Wall> wallLine : walls) {
//        for (Wall wall : wallLine) {
//            wall.draw(canvas);
//        }
//    }
//    surfaceHolder.unlockCanvasAndPost(canvas);
}

@end
