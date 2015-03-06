//
//  ViewController.m
//  AcronymProject
//
//  Created by Neha Tiwari on 05/03/15.
//  Copyright (c) 2015 Neha Tiwari. All rights reserved.
//

#import "ViewController.h"
#import "Parser.h"
#import "MBProgressHUD.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize txtfield_acronym,lbl_acronymdetails;
- (void)viewDidLoad {
    [super viewDidLoad];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Textfield Delegate methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField ){
        [textField resignFirstResponder];
        
    }
    return NO;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark Button Action
- (IBAction)btn_result:(id)sender {
    [self getresults];
    
    
    
    
}

-(void)getresults{
    
    Parser *parser1=[[Parser alloc]init];
    parser1.delegate=self;
    [parser1 parseAcronymData:txtfield_acronym.text];
    
}

#pragma mark Parser Methods

- (void)DidBegin
{
    
}
- (void)DidFail:(NSString *)errorstr
{
    NSLog(@"Error%@",errorstr);
    
    if ([errorstr isEqualToString:@"The Internet connection appears to be offline."])
    {
        
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorstr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
}
/*<__NSCFArray 0x165cc6a0>(
{
    lfs =     (
               {
                   freq = 9;
                   lf = "pentaerythritol triacrylate";
                   since = 1980;
                   vars =             (
                                       {
                                           freq = 9;
                                           lf = "pentaerythritol triacrylate";
                                           since = 1980;
                                       }
                                       );
               }
               );
    sf = PETA;
}
                         )
*/
- (void)DidFinish:(id)data
{
    
    if(data){
        NSMutableArray *lfArray;
        lfArray=[[NSMutableArray alloc]init];
        
        for (int i=0 ; i<[data count] ; i++) {
            
            NSMutableDictionary * location = [[data objectAtIndex:i]objectForKey:@"lfs"];
            NSString * lat = [location valueForKey:@"lf"];
          
            [lfArray addObject:lat];
            NSString *string=[NSString stringWithFormat:@"%@", [lfArray objectAtIndex:0]];
            self.txtView.text=string;
            [self showCorrectAlert];
            
        }    }
    else if (data == [NSNull null])
    {
        self.txtView.text=@"No data found";
        [self showNoInfoAlert];

    }
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.txtView.text=nil;
    return YES;
}
- (void)showCorrectAlert {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
    HUD.delegate = self;
   
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"Correct Result";
    [HUD showWhileExecuting:@selector(waitForTwoSeconds)
                   onTarget:self withObject:nil animated:YES];
}

- (void)showNoInfoAlert {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
    HUD.delegate = self;
      HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"No result found";
    [HUD showWhileExecuting:@selector(waitForTwoSeconds)
                   onTarget:self withObject:nil animated:YES];
}

- (void)waitForTwoSeconds {
    sleep(2);
}

@end
