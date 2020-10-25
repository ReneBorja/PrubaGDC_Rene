//
//  Action.m
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

#import "Action.h"
#import <Alamofire/Alamofire-Swift.h>
@implementation Action{
    int sesion;
}




//CONSEGUIR URL BASE


//PARA CONEXIONES GET
-(NSMutableArray*)getRequest{
   // NSMutableArray *arrayData =[NSMutableArray new];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    __block NSMutableArray *arrayData = nil;
    [request setURL:[NSURL URLWithString:@"https://api.github.com/users"]];
    [request setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *err = nil;

        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:[requestReply dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
        arrayData = array;
      

        
       // NSMutableDictionary*dataResponse = [array objectAtIndex:0];
        //NSLog(@"Request reply: %@", array);
    }] resume];
    
    return arrayData;

    
}
//PARA CONEXIONES POST


@end

