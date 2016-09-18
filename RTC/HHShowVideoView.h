//
//  HHShowVideoView.h
//  Linkdood
//
//  Created by VRV2 on 16/9/14.
//  Copyright © 2016年 xiong qing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHShowVideoView;

@protocol HHShowVideoViewDelegate <NSObject>

@optional
//接听按钮回调
-(void)showVieo:(HHShowVideoView*)showVideoView didButtonClickWithAnswer:(UIButton*)answerButton;
//挂断按钮回调
-(void)showVieo:(HHShowVideoView*)showVideoView didButtonClickWithHangup:(UIButton*)hangupButton;
@end

@interface HHShowVideoView : UIView

@property (assign,nonatomic) id<HHShowVideoViewDelegate> delegate;

@property (strong, nonatomic) UIImage            *avarstImage;
/** 连接信息，如等待对方接听...、对方已拒绝、语音通话、视频通话 */
@property (copy, nonatomic) NSString            *connectText;
/** 网络提示信息，如网络状态良好、 */
@property (copy, nonatomic) NSString            *netTipText;
/** 头像 */
@property (strong, nonatomic)   NSString             *portraitImageString;
/** 对方的昵称 */
@property (copy, nonatomic)    NSString                 *nickNameStr;
/** 是否是被挂断 */
@property (assign, nonatomic)   BOOL            isHanged;
/** 是否已接听 */
@property (assign, nonatomic)   BOOL            answered;
/** 对方是否开启了摄像头 */
@property (assign, nonatomic)   BOOL            oppositeCamera;

@property (strong,nonatomic) LDUserModel *contentModel;
/**
 *  对方的视频视频画面
 */

@property (strong,nonatomic) UIView *adverseVideoView;
/**
 *  自己的视频画面
 */
@property (strong,nonatomic) UIView *ownVideoView;




-(instancetype)initShowVideoWithIsVideo:(BOOL)isVideo idCall:(BOOL)isCall frame:(CGRect)frame;

-(void)showCallVideoView;
/**
 *  接通后调用的方法 (视频呼叫 和 被叫方)
 */
-(void)initUIForVideoCommom;
/**
 *  移除当前所有的子视图
 */
-(void)removewAllSubView;
@end
