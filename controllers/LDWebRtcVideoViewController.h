//
//  LDWebRtcVideoViewController.h
//  Linkdood
//
//  Created by VRV2 on 16/9/12.
//  Copyright © 2016年 xiong qing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDWebRtcVideoViewController : UIViewController
@property (assign,nonatomic) bool isRequest;
@property (assign,nonatomic) bool isVideo;
@property (strong,nonatomic) LDChatModel *chatModel;

-(instancetype)initWithChatModel:(LDChatModel*)chatModel;
@end
