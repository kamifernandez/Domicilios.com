//
//  ViewController.h
//  Domicilios.com
//
//  Created by Christian camilo fernandez on 29/11/16.
//
//

#import <UIKit/UIKit.h>
#import "FTWCache.h"
#import "NSString+MD5.h"
#import "MyCLController.h"

@interface ViewController : UIViewController{
    CLLocationManager *locationManager;
    //Location
    MyCLController *_MyCLController;
}

// NSMutable array

@property(nonatomic,strong)NSMutableArray * data;

@property(nonatomic,weak)IBOutlet UIView *vistaWait;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *indicador;

// Table

@property(nonatomic,weak)IBOutlet UITableView * tableStores;

// Table Cell

@property(nonatomic,weak)IBOutlet UITableViewCell * cellStoresView;

@property(nonatomic,weak)IBOutlet UIImageView * imgIcon;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView * indicatorCell;
@property(nonatomic,weak)IBOutlet UILabel * lblTittle;

@property(nonatomic,weak)IBOutlet UIImageView * imgStarOne;
@property(nonatomic,weak)IBOutlet UIImageView * imgStarTwo;
@property(nonatomic,weak)IBOutlet UIImageView * imgStarThree;
@property(nonatomic,weak)IBOutlet UIImageView * imgStarFour;
@property(nonatomic,weak)IBOutlet UIImageView * imgStarFive;

@property(nonatomic,weak)IBOutlet UILabel * lblCategory;
@property(nonatomic,weak)IBOutlet UILabel * housePrice;
@property(nonatomic,weak)IBOutlet UILabel * timeRequest;
@property(nonatomic,weak)IBOutlet UILabel * distance;

// UIview Filter

@property(nonatomic,weak)IBOutlet UIView * viewFilter;
@property(nonatomic,weak)IBOutlet UIView * viewContentFilter;
@property(nonatomic,weak)IBOutlet UIView * viewContenAlltFilter;

@end

