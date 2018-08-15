//
//  BitmapUtil.m
//  Try_downStage
//
//  Created by irons on 2015/5/20.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "BitmapUtil.h"

@implementation BitmapUtil

static BitmapUtil* instance;

-(id)init{
    if(self = [super init]){
        self.PLAYER_WIDTH_PERSENT = 2.5;
        self.TOOL_WIDTH_PERSENT = 4;
        self.FIREBALL_WIDTH_PERSENT = 3;
        
        self.sreenWidth = 300.0;
        self.sreenHeight = 600.0;
        
        int footbarWidth = self.sreenWidth / 4;
        int playerWidth = footbarWidth / self.PLAYER_WIDTH_PERSENT;
        int toolWidth = footbarWidth / self.TOOL_WIDTH_PERSENT;
        int fireballWidth = footbarWidth / self.FIREBALL_WIDTH_PERSENT;
        
        self.wall_bitmap = [SKTexture textureWithImageNamed:@"bubble_1"];
        self.wall_size = CGSizeMake(playerWidth, (int)((float)self.wall_bitmap.size.height/ self.wall_bitmap.size.width * playerWidth));
        
        self.player_girl_left01_bitmap = [SKTexture textureWithImageNamed:@"player_girl_left01"];
        self.player_girl_left02_bitmap = [SKTexture textureWithImageNamed:@"player_girl_left02"];
        self.player_girl_left03_bitmap = [SKTexture textureWithImageNamed:@"player_girl_left03"];
        self.player_girl_right01_bitmap = [SKTexture textureWithImageNamed:@"player_girl_right01"];
        self.player_girl_right02_bitmap = [SKTexture textureWithImageNamed:@"player_girl_right02"];
        self.player_girl_right03_bitmap = [SKTexture textureWithImageNamed:@"player_girl_right03"];
        
        self.player_girl_injure_left_bitmap = [SKTexture textureWithImageNamed:@"player_girl_injure_left"];
        self.player_girl_injure_right_bitmap = [SKTexture textureWithImageNamed:@"player_girl_injure_right"];
        self.player_girl_down_left_bitmap = [SKTexture textureWithImageNamed:@"player_girl_down_left"];
        self.player_girl_down_right_bitmap = [SKTexture textureWithImageNamed:@"player_girl_down_right"];
        
        int x = self.player_girl_left01_bitmap.size.height;

        
        self.player_girl_left01_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_left01_bitmap.size.height/ self.player_girl_left01_bitmap.size.width * playerWidth));
        
        self.player_girl_left02_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_left02_bitmap.size.height/ self.player_girl_left02_bitmap.size.width * playerWidth));
                
        self.fire_ball_size = CGSizeMake(fireballWidth, (int)((float)self.fire_ball.size.height/ self.fire_ball.size.height * fireballWidth));
        
        self.numberImageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"s0"], [UIImage imageNamed:@"s1"], [UIImage imageNamed:@"s2"], [UIImage imageNamed:@"s3"], [UIImage imageNamed:@"s4"], [UIImage imageNamed:@"s5"], [UIImage imageNamed:@"s6"], [UIImage imageNamed:@"s7"], [UIImage imageNamed:@"s8"], [UIImage imageNamed:@"s9"], nil];
        
    }
    return self;
}

-(UIImage*)getNumberImage:(int)number{
    UIImage* numberImage;
    switch (number) {
        case 0:
            numberImage = self.numberImageArray[0];
            break;
        case 1:
            numberImage = self.numberImageArray[1];
            break;
        case 2:
            numberImage = self.numberImageArray[2];
            break;
        case 3:
            numberImage = self.numberImageArray[3];
            break;
        case 4:
            numberImage = self.numberImageArray[4];
            break;
        case 5:
            numberImage = self.numberImageArray[5];
            break;
        case 6:
            numberImage = self.numberImageArray[6];
            break;
        case 7:
            numberImage = self.numberImageArray[7];
            break;
        case 8:
            numberImage = self.numberImageArray[8];
            break;
        case 9:
            numberImage = self.numberImageArray[9];
            break;
    }
    return numberImage;
}

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}



@end
