
#import "Parser.h"
#import "AppDelegate.h"
@implementation Parser
@synthesize delegate;


- (void)DidBegin
{
    
}

- (void)DidFail:(NSString *)errorstr
{
//    if ([errorstr isEqualToString:@"The Internet connection appears to be offline."])
//    {
//        
//        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorstr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        
//    }
    
    if (delegate && [delegate respondsToSelector:@selector(DidFail:)])
    {
        [delegate DidFail:errorstr];
    }
    
}

- (void)DidFinish:(id)data

{
    [delegate DidFinish:data];
    
}
-(void)DidMarketStatus:(NSString *)status
{
    
    
}
-(void)didServerFail
{
    [delegate didServerFail];

}


-(void)parseAcronymData:(NSString *)acronym
{
    NSString *urlString = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",acronym];
    
       NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:100.0];
    [request setTimeoutInterval:30.0];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
   // [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [AFJSONRequestOperation addAcceptableContentTypes:
     [NSSet setWithObject:@"text/plain"]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                         
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             
                                             //NSLog(@"%@",JSON);
                                             [self performSelectorOnMainThread:@selector(DidFinish:)
                                                                    withObject:JSON
                                                                 waitUntilDone:YES];
                                             
                                         }
                                         
                                                                                        failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON)
                                         {
                                             //NSLog(@"Failed: %@",[error localizedDescription]);
                                             [self performSelectorOnMainThread:@selector(DidFail:)
                                                                    withObject:error.localizedDescription
                                                                 waitUntilDone:YES];
                                             
                                             
                                         }];
    [operation start];
    
}

@end
