//
//  RTCButton.m
//  RTCDemo
//
//  Created by Harvey on 16/5/24.
//  Copyright © 2016年 Haley. All rights reserved.
//

#import "RTCButton.h"

@interface RTCButton ()

@end

@implementation RTCButton

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName isVideo:(BOOL)isVideo
{
    self = [super init];
    if (self) {
        if (title) {
            [self setTitle:title forState:UIControlStateNormal];
            self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
            if (isVideo) {
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
            }
            
            UIColor *blueColor = [UIColor colorWithRed:57/255.0 green:163/255.0 blue:248/255.0 alpha:1.0];
            [self setTitleColor:blueColor forState:UIControlStateSelected];
        }
        
        if (imageName) {
            NSString *normalName = [NSString stringWithFormat:@"%@_black",imageName];
            NSString *disableName = [NSString stringWithFormat:@"%@_gray",imageName];
            NSString *selectedName = [NSString stringWithFormat:@"%@_blue",imageName];
            
            if (isVideo) {
                disableName = [NSString stringWithFormat:@"%@_white",imageName];
                normalName = [NSString stringWithFormat:@"%@_black",imageName];
            }
            
            [self setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:disableName] forState:UIControlStateDisabled];
            [self setImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
        }
    }
    
    return self;
}

+ (instancetype)rtcButtonWithTitle:(NSString *)title imageName:(NSString *)imageName isVideo:(BOOL)isVideo;
{
    return [[[self class] alloc] initWithTitle:title imageName:imageName isVideo:isVideo];
}

- (instancetype)initWithTitle:(NSString *)title noHandleImageName:(NSString *)noHandleImageName selectImage:(NSString*)selectImageName
{
    self = [super init];
    if (self) {
        if (title) {
            [self setTitle:title forState:UIControlStateNormal];
            self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [self setTintColor:[UIColor blueColor]];
            [self setTintColor:[UIColor blackColor]];
            UIColor *blueColor = [UIColor colorWithRed:57/255.0 green:163/255.0 blue:248/255.0 alpha:1.0];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
             [self setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        }
        if (noHandleImageName) {
            [self setImage:[UIImage imageNamed:noHandleImageName] forState:UIControlStateNormal];
            
        }
        if (![selectImageName isEmpty]) {
            [self setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateHighlighted];
        }
    }
    return self;
}

+ (instancetype)rtcButtonWithTitle:(NSString *)title noHandleImageName:(NSString *)noHandleImageName selectImageName:(NSString*)selectImageName
{
    return [[[self class] alloc] initWithTitle:title noHandleImageName:noHandleImageName selectImage:selectImageName];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.currentImage && self.currentImage) {
        // Center image
        CGPoint center = self.imageView.center;
        center.x = self.frame.size.width/2;
        center.y = self.imageView.frame.size.height/2 + 5;
        self.imageView.center = center;
        
        //Center text
        CGRect newFrame = [self titleLabel].frame;
        newFrame.origin.x = 0;
        newFrame.origin.y = self.imageView.frame.size.height + 5;
        newFrame.size.width = self.frame.size.width;
        
        self.titleLabel.frame = newFrame;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

@end
