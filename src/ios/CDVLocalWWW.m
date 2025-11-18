#import <Cordova/CDV.h>
#import "CDVLocalWWW.h"
#import "SSZipArchive.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface CDVLocalWWW()
@property (nonatomic) BOOL is_progress_show;
@end

@implementation CDVLocalWWW
- (void)pluginInitialize
{
    NSLog(@"--------------- init CDVLocalWWWW --------");

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *srcPath = [[[NSBundle mainBundle] URLForResource:@"www" withExtension:@"zip"] absoluteString];
    NSString *zipPath = [[NSURL URLWithString:srcPath] path];
    NSArray *directoryPaths = [fileManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
    NSURL *distPath = [[directoryPaths firstObject] URLByAppendingPathComponent:@"NoCloud/www"];
    NSString *destinationPath = [distPath path];
    NSError *error;
    if([SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath overwrite:YES password:nil error:&error delegate:nil]) {
        NSLog(@"unzip success!");
    } else {
        NSLog(@"%@ - %@", @"Error occurred during unzipping", [error localizedDescription]);
    }
    _is_progress_show = NO;
    [SVProgressHUD setDefaultMaskType: SVProgressHUDMaskTypeBlack];
    __typeof(self) weakSelf = self;
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification
                                                      object:nil
                                                       queue:mainQueue
                                                  usingBlock:^(NSNotification *note) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [weakSelf.commandDelegate evalJs:@"try{NotificationScreenshot();}catch(e){}"];
                                                        });
                                                  }];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIScreenCapturedDidChangeNotification
                                                      object:nil
                                                       queue:mainQueue
                                                  usingBlock:^(NSNotification *note) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [weakSelf.commandDelegate evalJs:@"try{NotificationCapture();}catch(e){}"];
                                                        });
                                                  }];
}

//进度条
- (void)showProgress:(CDVInvokedUrlCommand *)command
{
    if(_is_progress_show) return;
    _is_progress_show = YES;
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    BOOL is_progress = [[options valueForKey:@"is_progress"] boolValue];
    NSString * title = [options objectForKey:@"title"] ?: [NSString stringWithFormat:@"0 %@...", NSLocalizedString(@"处理完成",@"")];
    if(is_progress){
        [SVProgressHUD showProgress:0.0f status:title];
    }else{
        [SVProgressHUD showWithStatus:title];
    }
}
- (void)setProgress:(CDVInvokedUrlCommand *)command
{
    if(!_is_progress_show) return;
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    float progress = [[options objectForKey:@"progress"] floatValue] ?: 0.0;
    NSString * title = [options objectForKey:@"title"] ?: [NSString stringWithFormat:@"%.0f%% %@...", round(progress*100), NSLocalizedString(@"处理完成",@"")];
    [SVProgressHUD showProgress:progress status:title];
}
- (void)hideProgress:(CDVInvokedUrlCommand *)command
{
    if(!_is_progress_show) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        self->_is_progress_show = NO;
    });
}

-(void) goSetting:(CDVInvokedUrlCommand *)command
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
}
-(void) goURL:(CDVInvokedUrlCommand *)command
{
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    NSString *urlstr = [options valueForKey:@"url"];
    NSURL *url = [NSURL URLWithString:urlstr];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL res){
        [self send_event:command withMessage:@{@"success":@"success"} Alive:NO State:YES];
    }];
}

-(void) playBeep:(CDVInvokedUrlCommand *)command
{
    UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [feedBackGenertor impactOccurred];
}

- (void)getSystemInfo:(CDVInvokedUrlCommand*)command
{
    BOOL is_debug = false;
    BOOL is_iphonex = false;

    #ifdef DEBUG
        is_debug = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsBool:(true)];
    #endif
    CGFloat safeBottom = self.viewController.view.safeAreaInsets.bottom;
    if(safeBottom > 0.0){
        is_iphonex = true;
    }
    [self send_event:command withMessage:@{
        @"is_debug":@(is_debug),
        @"is_iphonex":@(is_iphonex),
        @"auth": [self settingForKey:@"authkey"],
        @"onepass":[self settingForKey:@"onepass.key"]
    } Alive:NO State:YES];
}


//是否允许截屏
- (void)enableScreenShot:(CDVInvokedUrlCommand *)command
{
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    CDVViewController * vc = (CDVViewController *)self.viewController;
    vc->rootView.secureTextEntry = ![[options valueForKey:@"enable"] boolValue];
}


- (id)settingForKey:(NSString*)key
{
    return [self.commandDelegate.settings objectForKey:[key lowercaseString]];
}

- (void)send_event:(CDVInvokedUrlCommand *)command withMessage:(NSDictionary *)message Alive:(BOOL)alive State:(BOOL)state{
    CDVPluginResult* res = [CDVPluginResult resultWithStatus: (state ? CDVCommandStatus_OK : CDVCommandStatus_ERROR) messageAsDictionary:message];
    if(alive) [res setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult: res callbackId: command.callbackId];
}

@end
