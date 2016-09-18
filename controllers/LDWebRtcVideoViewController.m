//
//  LDWebRtcVideoViewController.m
//  Linkdood
//
//  Created by VRV2 on 16/9/12.
//  Copyright © 2016年 xiong qing. All rights reserved.
//

#import "LDWebRtcVideoViewController.h"
#import "HHShowVideoView.h"
#import "RTCButton.h"


#import "RTCVIewToolBar.h"
//#import <SDKClient/AVSipObject.h>
//#import <SDKClient/RTCEAGLVideoView.h>
//#import <SDKClient/RTCCameraPreviewView.h>

#define KTootsBarHeight 150.0f

@interface LDWebRtcVideoViewController ()<HHShowVideoViewDelegate>

@property(nonatomic,strong) HHShowVideoView *presentView;
@property(nonatomic,strong)LDUserModel *sendUserModel;//会话对象的model
/** 前置、后置摄像头切换按钮 */
@property (strong, nonatomic)   RTCButton               *swichBtn;
@property (strong, nonatomic)   RTCVIewToolBar             *toolBarView;

/**
 *  RTC 本地视频
 */
//@property(nonatomic) RTCCameraPreviewView *localVideoView;
/**
 *  RTC 远端视频
 */
//@property(nonatomic) RTCEAGLVideoView *remoteVideoView;
//@property(nonatomic) AVSipObject *sipObj;
@end

@implementation LDWebRtcVideoViewController
- (RTCButton *)swichBtn
{
    if (!_swichBtn) {
        _swichBtn = [[RTCButton alloc] initWithTitle:nil noHandleImageName:@"icon_avp_camera_black" selectImage:@"icon_avp_camera_white"];
        [_swichBtn addTarget:self action:@selector(switchClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _swichBtn;
}

/**
 *  懒加载 初始化音视频界面数据
 */
//-(RTCCameraPreviewView*)localVideoView{
//    if (!_localVideoView) {
//          _localVideoView = [[RTCCameraPreviewView alloc] initWithFrame:CGRectZero];
//    }
//    return _localVideoView;
//}
//-(RTCEAGLVideoView*)remoteVideoView{
//    if (_remoteVideoView) {
//        _remoteVideoView = [[RTCEAGLVideoView alloc] initWithFrame:CGRectZero];
//        _remoteVideoView.delegate = self;
//
//    }
//    return _remoteVideoView;
//}
//
//#pragma mark - RTCEAGLVideoViewDelegate
//
//- (void)videoView:(RTCEAGLVideoView*)videoView didChangeVideoSize:(CGSize)size {
//    if (videoView == _remoteVideoView) {
//        
//    }
//   
//}

-(instancetype)initWithChatModel:(LDChatModel *)chatModel{
    self = [super init];
    if (self) {
        self.chatModel = chatModel;
//        初始化和处理音视频数据
        [self initRTCData];
    }
    return self;
}
#pragma mark - 初始化rtc数据
-(void)initRTCData{
    
//    AVSipObject *av = [[AVSipObject alloc]init];
//    self.sipObj = av;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    RTCVIewToolBar *tool = [RTCVIewToolBar RTCVIewToolBarInstance];
    tool.isCalled = YES;
    tool.isVideo = YES;
    tool.loudSpeaker = YES;
    self.toolBarView = tool;

    if (self.isVideo && self.isRequest) {
        _presentView = [[HHShowVideoView alloc] initShowVideoWithIsVideo:YES idCall:YES frame:CGRectMake(0, 0, self.view.size.width, self.view.size.height-KTootsBarHeight)];
        self.title = @"视频通话";
        self.swichBtn.bounds = CGRectMake(0, 0, 30, 30);
        UIBarButtonItem *switchButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_swichBtn];
        self.navigationItem.rightBarButtonItem = switchButtonItem;
        _presentView.connectText = @"正在呼叫...";
        [tool showToolBarInView:self.view];

    }else if (self.isVideo && !self.isRequest) {
        _presentView = [[HHShowVideoView alloc] initShowVideoWithIsVideo:YES idCall:NO frame:CGRectMake(0, 0, self.view.size.width, self.view.size.height)];
        self.title = @"视频通话";
        self.swichBtn.bounds = CGRectMake(0, 0, 30, 30);
        UIBarButtonItem *switchButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_swichBtn];
        self.navigationItem.rightBarButtonItem = switchButtonItem;
        [tool hiddenToolBar];
        _presentView.connectText = @"你有一个视频电话";
        _presentView.delegate = self;

    } else if (!self.isVideo && self.isRequest) {
         _presentView = [[HHShowVideoView alloc] initShowVideoWithIsVideo:NO idCall:YES frame:CGRectMake(0, 0, self.view.size.width, self.view.size.height-KTootsBarHeight)];
        self.title = @"语音通话";
        _presentView.connectText = @"正在呼叫...";

    } else {
         _presentView = [[HHShowVideoView alloc] initShowVideoWithIsVideo:NO idCall:YES frame:CGRectMake(0, 0, self.view.size.width, self.view.size.height-KTootsBarHeight)];
        self.title = @"语音通话";
        _presentView.connectText = @"正在呼叫...";

    }
    [self.view addSubview:_presentView];
    

    if (self.chatModel) {
//        int64_t target = self.chatModel.ID;
//        LDContactModel *contentModel = [[LDClient sharedInstance] localContact:target];
//        self.sendUserModel = contentModel;
//        _presentView.contentModel =  contentModel;
        self.presentView.portraitImageString = _chatModel.avatarUrl;
        self.presentView.nickNameStr = _chatModel.sender;
       
    }
    _presentView.netTipText = @"对方的网络状况不是很好";
    
//    [_presentView showWithView:self.view];
  
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [self.presentView dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/**摄像头切换**/
- (void)switchClick
{
    [self.toolBarView hiddenToolBar];
}

#pragma mark -- showVideoDelegate
-(void)showVieo:(HHShowVideoView *)showVideoView didButtonClickWithAnswer:(UIButton *)answerButton{
    [showVideoView removewAllSubView];
    [showVideoView initUIForVideoCommom];
    [self.toolBarView showToolBarInView:self.view];
}
-(void)showVieo:(HHShowVideoView *)showVideoView didButtonClickWithHangup:(UIButton *)hangupButton{
      NSLog(@"你 挂断了");
}







@end
