//
//  cell.h
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

#import <Foundation/Foundation.h>


#import <UIKit/UIKit.h>

@interface cell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *viewContent;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDescripcion;
@property (weak, nonatomic) IBOutlet UILabel *lblUrl;


@end

