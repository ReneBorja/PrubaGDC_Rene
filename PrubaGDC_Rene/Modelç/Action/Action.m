//
//  Action.m
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

#import "Action.h"
@implementation Action{
    int sesion;
    __block NSMutableArray *arrayData;

}




//CONSEGUIR URL BASE


//PARA CONEXIONES GET
-(NSMutableArray*)getRequest{
  arrayData =[NSMutableArray new];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://api.github.com/users"]];
    [request setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *err = nil;

        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:[requestReply dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
        if ([array count] !=0) {
            self->arrayData = array;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadTV" object:nil userInfo:nil];

        }
            
           

//            dispatch_async(dispatch_get_main_queue(),^{
//                
//            });
        

        
       // NSMutableDictionary*dataResponse = [array objectAtIndex:0];
        NSLog(@"Request reply: %@", array);
    }] resume];
    
    return arrayData;

    
}
-(NSMutableArray*)getUsers{
    return arrayData;
}
//PARA CONEXIONES POST


@end

