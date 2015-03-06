//
//  ViewController.h
//  AcronymProject
//
//  Created by Neha Tiwari on 05/03/15.
//  Copyright (c) 2015 Neha Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"
#import "MBProgressHUD.h"
@interface ViewController : UIViewController<ParserDelgate>{
    MBProgressHUD *HUD;

}

@property (weak, nonatomic) IBOutlet UITextField *txtfield_acronym;

@property (weak, nonatomic) IBOutlet UILabel *lbl_acronymdetails;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
- (IBAction)btn_result:(id)sender;
@end

