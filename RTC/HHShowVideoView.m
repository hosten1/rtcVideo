//
//  HHShowVideoView.m
//  Linkdood
//
//  Created by VRV2 on 16/9/14.
//  Copyright © 2016年 xiong qing. All rights reserved.
//

#import "HHShowVideoView.h"
#import "RTCButton.h"

#define kRTCRate        ([UIScreen mainScreen].bounds.size.width / 320.0)
// 每个按钮的宽度
#define kBtnW           (60 * kRTCRate)
// 视频聊天时，小窗口的宽
#define kMicVideoW      (80 * kRTCRate)
// 视频聊天时，小窗口的高
#define kMicVideoH      (120 * kRTCRate)

#define kRTCWidth       (100 * kRTCRate)
@interface HHShowVideoView ()
/** 是否是视频聊天 */
@property (assign, nonatomic)   BOOL                    isVideo;
/** 是否是被呼叫方 */
@property (assign, nonatomic)   BOOL                    isCalle;
/** 头像 */
@property (strong, nonatomic)   UIImageView             *portraitImageView;
/** 对方的昵称 */
@property (copy, nonatomic)    UILabel                 *nickNameLabel;
/** 连接状态，如等待对方接听...、对方已拒绝、语音电话、视频电话 */
@property (strong, nonatomic)   UILabel                 *connectLabel;
/** 网络状态提示，如对方网络良好、网络不稳定等 */
@property (strong, nonatomic)   UILabel                 *netTipLabel;

/** 挂断按钮 视频被叫页面*/
@property (strong, nonatomic)   RTCButton               *hangupBtn;
/** 接听按钮 视频被叫页面*/
@property (strong, nonatomic)   RTCButton               *answerBtn;

@end

@implementation HHShowVideoView
-(instancetype)initShowVideoWithIsVideo:(BOOL)isVideo idCall:(BOOL)isCall frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.isVideo = isVideo;
        self.isCalle  = isCall;
        self.backgroundColor = [UIColor blueColor];
        [self setupUI];
    }
    return self;
}
/**
 *  初始化UI
 */
- (void)setupUI
{
    self.adverseVideoView.backgroundColor = [UIColor lightGrayColor];
    self.ownVideoView.backgroundColor = [UIColor grayColor];
    self.portraitImageView.backgroundColor = [UIColor clearColor];
    
    if (self.isVideo && self.isCalle) {
        // 视频通话时，呼叫方的UI初始化
        [self initUIForVideoCaller];
        
        
    } else if (!self.isVideo && self.isCalle) {
        // 语音通话时，呼叫方UI初始化
        [self initUIForAudioCaller];
        
        
    } else if (!self.isVideo && !self.isCalle) {
        // 语音通话时，被呼叫方UI初始化
        [self initUIForAudioCallee];
    } else {
        // 视频通话时，被呼叫方UI初始化
        [self initUIForVideoCallee];
    }
}

-(void)showCallVideoView{
    
}
/**
 *  视频通话时，呼叫方的UI设置(未接通)
 */
- (void)initUIForVideoCaller
{
    CGFloat centerX = self.center.x;
    
    CGFloat portraitW = 130 * kRTCRate;

  
    self.portraitImageView.frame = CGRectMake(0, 0, portraitW, portraitW);
    self.portraitImageView.center = CGPointMake(centerX, portraitW+20*kRTCRate);
    self.portraitImageView.layer.cornerRadius = portraitW * 0.5;
    self.portraitImageView.layer.masksToBounds = YES;
    self.portraitImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:_portraitImageView];
    
    self.nickNameLabel.frame = CGRectMake(0, 0, kRTCWidth, 30);
    self.nickNameLabel.center = CGPointMake(centerX, CGRectGetMaxY(self.portraitImageView.frame) + 20);
    [self addSubview:_nickNameLabel];
    self.nickNameLabel.textColor = [UIColor whiteColor];
    self.nickNameLabel.text = @"未知用户";
    [self headerImageViewAnimationWithView:self.portraitImageView];//加动画
    
    
    self.connectLabel.frame = CGRectMake(0, CGRectGetMaxY(self.nickNameLabel.frame)+30, self.bounds.size.width, 25);
    self.connectLabel.textColor = [UIColor whiteColor];
    self.connectLabel.textAlignment = NSTextAlignmentCenter;
    self.connectLabel.text = @"正在呼叫.....";
    [self addSubview:_connectLabel];
}
//视频接通后统一界面(接听后和呼叫接通后)
- (void)initUIForVideoCommom
{
   
    [self addSubview:self.adverseVideoView];
    self.adverseVideoView.backgroundColor = [UIColor grayColor];

    [self addSubview:self.ownVideoView];
    self.ownVideoView.backgroundColor = [UIColor redColor];
    
    
    self.ownVideoView.frame     = CGRectMake(10*kRTCRate, 64, 110*kRTCRate, 110*kRTCRate);
    self.adverseVideoView.frame = CGRectMake(0, 64, self.size.width, self.size.height);
//    }else{
//        self.ownVideoView.frame     =  CGRectMake(0, 64, self.size.width, self.size.height);
//        self.adverseVideoView.frame = CGRectMake(10, 64, 85, 85);
//    }

    self.connectLabel.frame = CGRectMake(20, 10, self.bounds.size.width, 35);
    self.connectLabel.textColor = [UIColor whiteColor];
    self.connectLabel.textAlignment = NSTextAlignmentCenter;
    self.connectLabel.text = self.connectText;
    [self addSubview:_connectLabel];
    
    //默认显示 工具栏   3s后自动隐藏进入全屏聊天
}

/**
 *  视频通话，被呼叫方UI初始化
 */
- (void)initUIForVideoCallee
{
    // 上面 通用部分
    [self initUIForTopCommonViews];
    CGFloat btnW = 55*kRTCRate;
    CGFloat btnH = 55*kRTCRate;
    
    //添加两个按钮事件
    CGFloat btnY =  CGRectGetMaxY(self.connectLabel.frame)+150*kRTCRate;
    CGPoint conCenter = self.center;
    self.hangupBtn.bounds = CGRectMake(0, 0, btnW, btnH);
    self.hangupBtn.center = CGPointMake(conCenter.x*0.5,btnY);
    [self addSubview:_hangupBtn];
    UILabel *hanLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, btnW, 30*kRTCRate)];
    hanLab.center = CGPointMake(self.hangupBtn.center.x, CGRectGetMaxY(self.hangupBtn.frame)+20*kRTCRate);
    hanLab.textAlignment = NSTextAlignmentCenter;
    hanLab.text = @"挂断";
    hanLab.textColor = [UIColor whiteColor];
    [self addSubview:hanLab];
    
    self.answerBtn.bounds = CGRectMake(0, 0, btnW, btnH);
    self.answerBtn.center = CGPointMake(conCenter.x*0.5+conCenter.x, btnY);
   
    [self addSubview:_answerBtn];
    UILabel *ansLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, btnW, 30*kRTCRate)];
    ansLab.textColor = [UIColor whiteColor];
    ansLab.textAlignment = NSTextAlignmentCenter;
    ansLab.center = CGPointMake(self.answerBtn.center.x, CGRectGetMaxY(self.answerBtn.frame)+20*kRTCRate);
    ansLab.text = @"接听";
    [self addSubview:ansLab];
    
}

/**
 *  语音通话，呼叫方UI初始化
 */
- (void)initUIForAudioCaller
{
    // 上面 通用部分
    [self initUIForTopCommonViews];
    
}

/**
 *  语音通话时，被呼叫方的UI初始化
 */
- (void)initUIForAudioCallee
{
    // 上面 通用部分
    [self initUIForTopCommonViews];
    
}
/**
 *  上半部分通用视图
 *  语音通话呼叫方、语音通话接收方、视频通话接收方上半部分视图布局都一样
 */
- (void)initUIForTopCommonViews
{
    CGFloat centerX = self.center.x;
    
    CGFloat portraitW = 130 * kRTCRate;
    
    
    self.portraitImageView.frame = CGRectMake(0, 0, portraitW, portraitW);
    self.portraitImageView.center = CGPointMake(centerX, portraitW+20*kRTCRate);
    self.portraitImageView.layer.cornerRadius = portraitW * 0.5;
    self.portraitImageView.layer.masksToBounds = YES;
    self.portraitImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:_portraitImageView];
    
    self.nickNameLabel.frame = CGRectMake(0, 0, kRTCWidth, 30);
    self.nickNameLabel.center = CGPointMake(centerX, CGRectGetMaxY(self.portraitImageView.frame) + 20);
    [self addSubview:_nickNameLabel];
    self.nickNameLabel.textColor = [UIColor whiteColor];
    self.nickNameLabel.text = @"未知用户";
    [self headerImageViewAnimationWithView:self.portraitImageView];//加动画
    
    
    self.connectLabel.frame = CGRectMake(0, CGRectGetMaxY(self.nickNameLabel.frame)+30, self.bounds.size.width, 25);
    self.connectLabel.textColor = [UIColor whiteColor];
    self.connectLabel.textAlignment = NSTextAlignmentCenter;
    self.connectLabel.text = @"正在呼叫.....";
    [self addSubview:_connectLabel];
    
    self.netTipLabel.frame = CGRectMake(0, 0, kRTCWidth, 30);
    self.netTipLabel.center = CGPointMake(centerX, CGRectGetMaxY(self.connectLabel.frame) + 40);
    [self addSubview:_netTipLabel];
   
}


-(void)setPortraitImageString:(NSString *)portraitImageString{
    _portraitImageString = portraitImageString;
    NSString *msgFrom;
    
        msgFrom = @"MaleIcon";
        
 
    [[LDClient sharedInstance] avatar:portraitImageString withDefault:msgFrom complete:^(UIImage *avatar) {
        self.portraitImageView.image = avatar;
    }];

}
-(void)setNickNameStr:(NSString *)nickNameStr{
    _nickNameStr = nickNameStr;
    self.nickNameLabel.text = nickNameStr;
}
-(void)setContentModel:(LDUserModel *)contentModel{
    _contentModel = contentModel;
    if (contentModel) {
        self.nickNameLabel.text = contentModel.name;
        NSString *msgFrom;
        if (contentModel.sex == msg_owner_male) {
            msgFrom = @"MaleIcon";
        }
        if (contentModel.sex == msg_owner_female) {
            msgFrom = @"FemaleIcon";
        }else{
            msgFrom = @"MaleIcon";
            
        }
        [[LDClient sharedInstance] avatar:contentModel.avatar withDefault:msgFrom complete:^(UIImage *avatar) {
            self.portraitImageView.image = avatar;
        }];

    }
}
-(void)setConnectText:(NSString *)connectText{
    _connectText = connectText;
    self.connectLabel.text = connectText;
}
-(UIView *)adverseVideoView{
    if (!_adverseVideoView) {
        _adverseVideoView = [[UIView alloc]init];
    }
    return _adverseVideoView;
}

-(UIView *)ownVideoView{
    if (!_ownVideoView) {
        _ownVideoView = [[UIView alloc]init];
    }
    return _ownVideoView;
}

- (UIImageView *)portraitImageView
{
    if (!_portraitImageView) {
        _portraitImageView = [[UIImageView alloc]init];
    }
    
    return _portraitImageView;
}

- (UILabel*)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = [UIFont systemFontOfSize:15.0f];
        _nickNameLabel.textColor = [UIColor darkGrayColor];
        _nickNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _nickNameLabel;
}

- (UILabel*)connectLabel
{
    if (!_connectLabel) {
        _connectLabel = [[UILabel alloc] init];
        _connectLabel.text = @"等待对方接听...";
        _connectLabel.font = [UIFont systemFontOfSize:17.0f];
        _connectLabel.textColor = [UIColor grayColor];
        _connectLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _connectLabel;
}
- (RTCButton *)hangupBtn
{
    if (!_hangupBtn) {
        if (!self.isCalle && _isVideo) {
            _hangupBtn = [[RTCButton alloc] initWithTitle:@"拒绝"  noHandleImageName:@"icon_call_reject_normal" selectImage:nil];
        } else {
            _hangupBtn = [[RTCButton alloc] initWithTitle:nil noHandleImageName:@"icon_call_reject_normal" selectImage:nil];
        }
        
        [_hangupBtn addTarget:self action:@selector(hangupClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hangupBtn;
}
-(void)hangupClick:(UIButton*)btn{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(showVieo:didButtonClickWithHangup:)]) {
        [self.delegate showVieo:self didButtonClickWithHangup:btn];
    }
}

- (RTCButton *)answerBtn
{
    if (!_answerBtn) {
        _answerBtn = [[RTCButton alloc] initWithTitle:@"接听" noHandleImageName:@"icon_audio_receive_normal" selectImage:nil];
        [_answerBtn addTarget:self action:@selector(answerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _answerBtn;
}
-(void)answerClick:(UIButton*)btn{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(showVieo:didButtonClickWithAnswer:)]) {
        [self.delegate showVieo:self didButtonClickWithAnswer:btn];
    }
}
- (void)headerImageViewAnimationWithView:(UIView*)aniView{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
                                    
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
     animation.fromValue = [NSNumber numberWithFloat:0.f];
                                    
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
                                    
    animation.duration  = 3;
                                    
    animation.autoreverses = NO;
                                    
    animation.fillMode =kCAFillModeForwards;
                                    
    animation.repeatCount = 500;
                                    
   [aniView.layer addAnimation:animation forKey:nil];
}



-(void)removewAllSubView{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _nickNameLabel = nil;
    _connectLabel = nil;
    _netTipLabel = nil;
    
    [self clearBottomViews];
}

- (void)clearBottomViews
{
    _hangupBtn = nil;
//    _msgReplyBtn = nil;
//    _voiceAnswerBtn = nil;
    _answerBtn = nil;
}

-(void)dealloc{
    [self removewAllSubView];
}














@end
