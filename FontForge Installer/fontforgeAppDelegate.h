//
//  fontforgeAppDelegate.h
//  FontForge Installer
//
//  Created by Jeff Escalante on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface fontforgeAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSButton *installButton;
@property (assign) IBOutlet NSTextField *installStatus;
@property (assign) IBOutlet NSProgressIndicator *spinner;

- (IBAction)installFontforge:(id)sender;

@end
