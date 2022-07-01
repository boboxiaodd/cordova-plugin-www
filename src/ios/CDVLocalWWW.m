#import <Cordova/CDV.h>
#import "CDVLocalWWW.h"
#import "SSZipArchive.h"

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

@end
