//
//  LDVideoVoiceMessageView.h
//  Linkdood
//
//  Created by VRV2 on 16/9/19.
//  Copyright © 2016年 xiong qing. All rights reserved.
//

#import <JSQMessagesViewController/JSQMessagesViewController.h>
@protocol LDVideoVoiceMessageViewDelegate <NSObject>
@optional
- (void)videoVoiceMessageWileSendMessageWithCallback:(LDMessageModel*)testMessage;
@end

@interface LDVideoVoiceMessageView : JSQMediaItem

@property (strong,nonatomic) LDTextMessageModel *message;
@property (strong,nonatomic) UILabel *messageLabel;
- (instancetype)initWithMessage:(LDMessageModel*)message;
@end
