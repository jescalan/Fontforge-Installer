//
//  fontforgeAppDelegate.m
//  FontForge Installer
//
//  Created by Jeff Escalante on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <ServiceManagement/ServiceManagement.h>
#import <Security/Authorization.h>
#import "fontforgeAppDelegate.h"

@implementation fontforgeAppDelegate

@synthesize window = _window;
@synthesize installButton = _installButton;
@synthesize installStatus = _installStatus;
@synthesize spinner = _spinner;

- (IBAction)installFontforge:(id)sender {
    
    // interface changes on init
    NSLog(@"install initiated");
    [_installButton setEnabled: NO];
    [_installButton setFrame: NSMakeRect(125.0, 72.5, 130.0, 32.0)];
    [_installStatus setStringValue: @"configuring..."];
    [_spinner setHidden: NO];
    [_spinner startAnimation: sender];
    
    // get the path to my setup scripts
    NSString* tmp1 = [[NSBundle mainBundle] bundlePath];
    NSString* tmp2 = [tmp1 stringByReplacingOccurrencesOfString:@"file://localhost"
                                                       withString:@""];
    NSString* scriptsPath = [NSString stringWithFormat:@"%@/Contents/Resources/", tmp2];
    
    // setup
    NSString* setupPath = [NSString stringWithFormat:@"%@%@", scriptsPath, @"setup.sh"];
    // finish
    NSString* finishPath = [NSString stringWithFormat:@"%@%@", scriptsPath, @"finish.sh"];
    // cancel
    NSString* cancelPath = [NSString stringWithFormat:@"%@%@", scriptsPath, @"cancel.sh"];
        
    NSTask *task;
    task = [NSTask launchedTaskWithLaunchPath: @"/bin/bash"
                                    arguments:[NSArray arrayWithObjects: setupPath, nil]
            ];
    
    [task waitUntilExit];
    
    [_installStatus setStringValue: @"almost done"];
    
    NSDictionary *error = [NSDictionary new]; 
    NSString *script =  @"do shell script \"cd /tmp/fontforge-20110222/pyhook; sudo python setup.py install\" with administrator privileges";  
    NSAppleScript *appleScript = [[NSAppleScript new] initWithSource:script]; 
    if ([appleScript executeAndReturnError:&error]) {
        NSLog(@"success!");
        NSTask *task;
        task = [NSTask launchedTaskWithLaunchPath: @"/bin/bash"
                                        arguments:[NSArray arrayWithObjects: finishPath, nil]
                ];
        
        [task waitUntilExit];
        [_spinner setHidden: YES];
        [_installStatus setStringValue: @"great success!"];
    } else {
        NSLog(@"%@", error);
        NSTask *task;
        task = [NSTask launchedTaskWithLaunchPath: @"/bin/bash"
                                        arguments:[NSArray arrayWithObjects: cancelPath, nil]
                ];
        
        [task waitUntilExit];
        [_installStatus setStringValue: @"huge failure!"];
    }

}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // run 'which fontforge'
    // if the user has it, disable the button and display already installed msg
}

@end
