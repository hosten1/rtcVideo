//
//  RTCVIewToolBar.h
//  Linkdood
//
//  Created by VRV2 on 16/9/14.
//  Copyright © 2016年 xiong qing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RTCButton;


@protocol RTCBtnDelegate <NSObject>

-(void)RTCButtonClicked:(UIButton*)btn;

@end
@interface RTCVIewToolBar : UIView
@property (assign, nonatomic) id<RTCBtnDelegate> delegate;

/**
 *  是否开启扬声器
 */
@property (assign,nonatomic) BOOL                       loudSpeaker;
/** 是否是视频聊天 */
@property (assign, nonatomic)   BOOL                    isVideo;
/** 是否是被呼叫方 */
@property (assign, nonatomic)   BOOL                    isCalled;
/** 静音按钮 */
@property (strong, nonatomic)   RTCButton               *muteBtn;
/** 摄像头按钮 */
@property (strong, nonatomic)   RTCButton               *cameraBtn;
/** 扬声器按钮 */
@property (strong, nonatomic)   RTCButton               *loudspeakerBtn;
/** 邀请成员按钮 */
@property (strong, nonatomic)   RTCButton               *inviteBtn;
/** 消息回复按钮 */
@property (strong, nonatomic)   UIButton                *msgReplyBtn;
/** 收到视频通话时，语音接听按钮 */
@property (strong, nonatomic)   RTCButton               *voiceAnswerBtn;
/** 挂断按钮 */
@property (strong, nonatomic)   RTCButton               *hangupBtn;
/** 接听按钮 */
@property (strong, nonatomic)   RTCButton               *answerBtn;
/** 收起按钮 */
@property (strong, nonatomic)   RTCButton               *packupBtn;
/** 视频通话缩小后的按钮 */
@property (strong, nonatomic)   UIButton                *videoMicroBtn;
/** 音频通话缩小后的按钮 */
@property (strong, nonatomic)   RTCButton               *microBtn;
+(instancetype)RTCVIewToolBarInstance;

-(void)showToolBarInView:(UIView*)view;
-(void)hiddenToolBar;
@end
