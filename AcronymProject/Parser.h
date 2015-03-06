




#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol  ParserDelgate <NSObject>

@required
- (void)DidBegin;
- (void)DidFail:(NSString *)errorstr;
- (void)DidFinish:(id)data;
-(void)didServerFail;

@end

@interface Parser : NSObject
{
}
@property (nonatomic, weak) id <ParserDelgate> delegate;
-(void)parseAcronymData:(NSString *)acronym;
@end
