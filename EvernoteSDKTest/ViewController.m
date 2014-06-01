//
//  ViewController.m
//  EvernoteSDKTest
//
//  Created by sonson on 2014/06/01.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)showSimpleAlertWithMessage:(NSString *)message {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:nil
                                           otherButtonTitles:@"OK", nil];
    [alert show];
}

- (NSString*)text {
	NSMutableString *string = [NSMutableString string];
	
	[string appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"];
	[string appendString:@"<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"];
	[string appendString:@"<en-note style=\"font-family:MS PGothic, MS Pｺﾞｼｯｸ, MS Pゴシック, Mona, IPA モナー Pゴシック, IPA MONAPGOTHIC, sans-serif;\">"];
	[string appendString:@"hogeeeeeee"];
	
	[string appendString:@"</en-note>"];
	
	return [NSString stringWithString:string];
}

- (IBAction)save:(id)sender {
	if ([[ENSession sharedSession] isAuthenticated]) {
		ENSaveToEvernoteActivity * sendActivity = [[ENSaveToEvernoteActivity alloc] init];
		sendActivity.delegate = self;
		NSArray * items = [NSArray arrayWithObject:[self text]];
		UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:items
																						  applicationActivities:@[sendActivity]];
		[self presentViewController:activityController animated:YES completion:nil];
	}
}

- (IBAction)authenticate:(id)sender {
	if ([[ENSession sharedSession] isAuthenticated]) {
	} else {
		[[ENSession sharedSession] authenticateWithViewController:self completion:^(NSError *authenticateError) {
			if (!authenticateError) {
			} else if (authenticateError.code != ENErrorCodeCancelled) {
				[self showSimpleAlertWithMessage:@"Could not authenticate."];
			}
		}];
	}
}

- (IBAction)unauthenticate:(id)sender {
	if ([[ENSession sharedSession] isAuthenticated]) {
		[[ENSession sharedSession] unauthenticate];
	}
}

- (void)activity:(ENSaveToEvernoteActivity *)activity didFinishWithSuccess:(BOOL)success error:(NSError *)error {
    if (success) {
        [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Saved to Evernote!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Fail" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	
//	if ([[ENSession sharedSession] isAuthenticated]) {
//	} else {
//		[[ENSession sharedSession] authenticateWithViewController:self completion:^(NSError *authenticateError) {
//			if (!authenticateError) {
//			} else if (authenticateError.code != ENErrorCodeCancelled) {
//				[self showSimpleAlertWithMessage:@"Could not authenticate."];
//			}
//		}];
//	}
}

@end
