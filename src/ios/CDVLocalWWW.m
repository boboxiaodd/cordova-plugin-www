#import <Cordova/CDV.h>
#import "CDVLocalWWW.h"
#import "SSZipArchive.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface CDVLocalWWW()
@property (nonatomic,strong) MBProgressHUD* hud;
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
}
//进度条
- (void)showProgress:(CDVInvokedUrlCommand *)command
{
    if(_hud) return;
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    _hud = [MBProgressHUD showHUDAddedTo:self.viewController.view animated:YES];
    _hud.removeFromSuperViewOnHide = YES;
    _hud.completionBlock = ^{
        self->_hud = nil;
    };
    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    _hud.label.text = [options objectForKey:@"title"] ?: @"加载中...";
}
- (void)setProgress:(CDVInvokedUrlCommand *)command
{
    if(!_hud) return;
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    _hud.progress = [[options objectForKey:@"progress"] floatValue] ?: 0.0;
}
- (void)hideProgress:(CDVInvokedUrlCommand *)command
{
    if(!_hud) return;
    [_hud hideAnimated:YES];
}

@end
