//
//  vcDetalleUser.m
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

#import "vcDetalleUser.h"
#import "cell.h"
#import "SharedManager.h"
#import "Action.h"
@interface vcDetalleUser (){
    MyManager* sharedManager;
    Action* act;
    NSMutableArray *reposArray;
}

@end

@implementation vcDetalleUser

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initConfig];
    [self configUI];
  //  [self getRequest];
//  NSMutableArray *Data =  [act getRequest];
//    NSLog(@"DATA IN T VIEW %@",Data);
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
   
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

-(void)initConfig{
    sharedManager = [MyManager sharedManager];
    act =[Action new];
    reposArray = [NSMutableArray new];
}
-(void)configUI{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [reposArray count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
             cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *MyIdentifier = @"cell";

        cell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        NSMutableDictionary *data = [reposArray objectAtIndex:indexPath.row];
        NSMutableDictionary *owner = data[@"owner"];
        cell.lblName.text =[NSString stringWithFormat:@"[%@]",data[@"name"]];
        cell.lblDescripcion.text = [NSString stringWithFormat:@"[%@]",data[@"description"]];;
        cell.lblUrl.text = owner[@"html_url"];

       
      //  [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
            //           placeholderImage:[UIImage imageNamed:@"placeholder"]];
        return cell;
    }
#pragma mark - WebService
-(void)getRequest:(NSString*)url{
   // NSMutableArray *arrayData =[NSMutableArray new];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
    
    [request setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *err = nil;

        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:[requestReply dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
        self->reposArray = array;
        NSLog(@"REPOS::: %@",self->reposArray);
        

        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            //do your work in the background here
            dispatch_async(dispatch_get_main_queue(), ^{
                //tell the main UI thread here
                [self->_tvRepositorios reloadData];
            });
        });
       // NSMutableDictionary*dataResponse = [array objectAtIndex:0];
        //NSLog(@"Request reply: %@", array);
    }] resume];
    

    
}
@end
