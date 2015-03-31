//
//  ReportsViewController.m
//  ECHackDemoApp
//
//  Created by Joe on 3/30/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import "ReportsViewController.h"
#import "CalendarData.h"
#import "DateUtility.h"

@interface ReportsViewController()

@property (nonatomic, strong) IBOutlet CPTGraphHostingView *resultsScatterPlot;
@property (nonatomic, strong) CPTXYGraph *graph;
@property (nonatomic, strong) NSArray *dataForPlot;
@property (nonatomic, strong) CalendarData *calendarData;

@end

@implementation ReportsViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // Initialize the calendar data
    self.calendarData = [[CalendarData alloc] init];
    
    NSDateFormatter* dateConverter = [[NSDateFormatter alloc] init];
    dateConverter.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZZ";
    NSDate *refDate = [dateConverter dateFromString:@"2015-03-01 23:18:23 +0100"];
    
    // If you make sure your dates are calculated at noon, you shouldn't have to
    // worry about daylight savings. If you use midnight, you will have to adjust
    // for daylight savings time.
    NSTimeInterval oneDay = 24 * 60 * 60;
    
    // Convert the calendar data to a format understood by the line plotter.
    NSMutableArray *dateAndEarningsArray = [NSMutableArray array];
    
    NSDictionary *fakeRecordedWagesDict = @{ @"2015-03-02 23:18:23 +0100" : @[[NSNumber numberWithDouble:2.0], [NSNumber numberWithDouble:1000.0]],
                                             @"2015-03-05 23:18:23 +0100" : @[[NSNumber numberWithDouble:4.0], [NSNumber numberWithDouble:1000.0]],
                                             @"2015-03-05 23:18:42 +0100" : @[[NSNumber numberWithDouble:2.0], [NSNumber numberWithDouble:1000.0]],
                                             @"2015-03-08 23:18:23 +0100" : @[[NSNumber numberWithDouble:3.0], [NSNumber numberWithDouble:1000.0]],
                                             @"2015-03-15 23:18:23 +0100" : @[[NSNumber numberWithDouble:8.0], [NSNumber numberWithDouble:1000.0]],
                                             @"2015-03-18 23:18:23 +0100" : @[[NSNumber numberWithDouble:5.0], [NSNumber numberWithDouble:1000.0]],
                                             @"2015-03-24 23:18:23 +0100" : @[[NSNumber numberWithDouble:7.0], [NSNumber numberWithDouble:1000.0]],
                                             @"2015-03-29 23:18:23 +0100" : @[[NSNumber numberWithDouble:9.0], [NSNumber numberWithDouble:1000.0]]};
    
    NSMutableDictionary *combinedTestAndRealWagesDict = [fakeRecordedWagesDict mutableCopy];
    [combinedTestAndRealWagesDict addEntriesFromDictionary:self.calendarData.calendarDictionary];
    
    NSArray *sortedDateKeys = [[combinedTestAndRealWagesDict allKeys] sortedArrayUsingSelector: @selector(compare:)];
    
    for(id date in sortedDateKeys)
    {
        NSArray *hoursAndWage = (NSArray *) combinedTestAndRealWagesDict[date];
        NSDate *convertedDate = [dateConverter dateFromString:date];
        int dayIndex = [DateUtility daysBetweenDate:refDate andDate:convertedDate];
        
        if(dateAndEarningsArray.count > 0)
        {
            NSDictionary *dateAndEarningsEntry = dateAndEarningsArray[dateAndEarningsArray.count - 1];
            double prevWageValue = [((NSNumber *)dateAndEarningsEntry[@(CPTScatterPlotFieldY).description]) doubleValue];
            
            // If the entry already exists
            if([((NSNumber *)dateAndEarningsEntry[@(CPTScatterPlotFieldX).description]) intValue] == dayIndex * oneDay)
            {
                [dateAndEarningsArray removeLastObject];
                [dateAndEarningsArray addObject:
                 @{ @(CPTScatterPlotFieldX).description: [NSNumber numberWithInt: dayIndex * oneDay],
                    @(CPTScatterPlotFieldY).description: [NSNumber numberWithInt:prevWageValue + [(NSNumber *)hoursAndWage[0] doubleValue]/100.0 * [(NSNumber *)hoursAndWage[1] doubleValue]] }
                 ];
            }
            else
            {
                [dateAndEarningsArray addObject:
                 @{ @(CPTScatterPlotFieldX).description: [NSNumber numberWithInt:dayIndex * oneDay],
                    @(CPTScatterPlotFieldY).description: [NSNumber numberWithInt:[(NSNumber *)hoursAndWage[0] doubleValue]/100.0 * [(NSNumber *)hoursAndWage[1] doubleValue]] }
                 ];
            }
        }
        else
        {
            [dateAndEarningsArray addObject:
             @{ @(CPTScatterPlotFieldX).description: [NSNumber numberWithInt:dayIndex * oneDay],
                @(CPTScatterPlotFieldY).description: [NSNumber numberWithInt:[(NSNumber *)hoursAndWage[0] doubleValue]/100.0 * [(NSNumber *)hoursAndWage[1] doubleValue]] }
             ];
        }
    }
    
    NSSortDescriptor *yDescriptor = [[NSSortDescriptor alloc] initWithKey:@(CPTScatterPlotFieldY).description ascending: YES selector:@selector(compare:)];
    NSArray *yDescriptors = [NSArray arrayWithObjects:yDescriptor, nil];
    NSArray *dateAndEarningsArraySortedByWage = [dateAndEarningsArray sortedArrayUsingDescriptors:yDescriptors];
    
    // Sort the wage records by date
    NSSortDescriptor *xDescriptor = [[NSSortDescriptor alloc] initWithKey:@(CPTScatterPlotFieldX).description ascending: YES selector:@selector(compare:)];
    NSArray *xDescriptors = [NSArray arrayWithObjects:xDescriptor, nil];
    
    NSArray *sortedDateAndEarningsArray = [dateAndEarningsArray sortedArrayUsingDescriptors:xDescriptors];
    self.dataForPlot = sortedDateAndEarningsArray;
    
    // Create graph from theme
    CPTXYGraph *newGraph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    CPTTheme *theme      = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [newGraph applyTheme:theme];
    self.graph = newGraph;
    
    newGraph.paddingLeft   = 10.0;
    newGraph.paddingTop    = 10.0;
    newGraph.paddingRight  = 10.0;
    newGraph.paddingBottom = 10.0;
    
    self.resultsScatterPlot.hostedGraph = newGraph;
    
    // Setup scatter plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)newGraph.defaultPlotSpace;
    NSTimeInterval xLow       = -oneDay * 1.5;
    NSTimeInterval yLow       = -2.5;

    NSNumber *maxDateVal = sortedDateAndEarningsArray[sortedDateAndEarningsArray.count - 1][@(CPTScatterPlotFieldX).description];
    NSNumber *minDateVal = sortedDateAndEarningsArray[0][@(CPTScatterPlotFieldX).description];
    NSNumber *maxWageVal = dateAndEarningsArraySortedByWage[dateAndEarningsArray.count - 1][@(CPTScatterPlotFieldY).description];
    
    double maxXVal = oneDay * 31.0;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(xLow) length:CPTDecimalFromDouble((oneDay * 31.0) - xLow)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(yLow) length:CPTDecimalFromDouble([maxWageVal doubleValue] + 5.0 - yLow)];
    
    // Axes
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)newGraph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    x.majorIntervalLength         = CPTDecimalFromDouble(maxXVal / 10);
    x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(2.0);
    x.minorTicksPerInterval       = 0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = kCFDateFormatterShortStyle;
    CPTTimeFormatter *timeFormatter = [[CPTTimeFormatter alloc] initWithDateFormatter:dateFormatter];
    
    // Set the starting date for the graph
    timeFormatter.referenceDate = refDate;
    x.labelFormatter            = timeFormatter;
    
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength         = CPTDecimalFromDouble([maxWageVal doubleValue]/20.0);
    y.minorTicksPerInterval       = 2;
    y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(oneDay);
    NSNumberFormatter *earningsFormatter = [[NSNumberFormatter alloc] init];
    [earningsFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [earningsFormatter setCurrencyCode:@"USD"];
    y.labelFormatter = earningsFormatter;
    
    // Create a plot that uses the data source method
    CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.identifier = @"Date Plot";
    
    CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth              = 2.0;
    lineStyle.lineColor              = [CPTColor greenColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    
    // Add a green gradient to the line plot
    CPTColor *areaColor       = [CPTColor greenColor];
    CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
    areaGradient.angle = -90.0;
    CPTFill *areaGradientFill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:CPTFloat(0.0) green:CPTFloat(1.0) blue:CPTFloat(0.0) alpha:CPTFloat(0.5)]];
    dataSourceLinePlot.areaFill      = areaGradientFill;
    dataSourceLinePlot.areaBaseValue = CPTDecimalFromDouble(1.75);
    
    dataSourceLinePlot.dataSource = self;
    [newGraph addPlot:dataSourceLinePlot];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return self.dataForPlot.count;
}

-(id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    return self.dataForPlot[index][@(fieldEnum).description];
}

//- (void)buildScatterPlot {
//    
//    // Create graph from theme
//    CPTXYGraph *newGraph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
//    CPTTheme *theme      = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
//    
//    [newGraph applyTheme:theme];
//    self.resultsScatterPlot.hostedGraph = newGraph;
//    self.graph                          = newGraph;
//    
//    newGraph.paddingLeft   = 10.0;
//    newGraph.paddingTop    = 10.0;
//    newGraph.paddingRight  = 10.0;
//    newGraph.paddingBottom = 10.0;
//    
//    // Setup plot space
//    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)newGraph.defaultPlotSpace;
//    plotSpace.allowsUserInteraction = YES;
//    plotSpace.xRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0) length:CPTDecimalFromDouble(5.0)];
//    plotSpace.yRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0) length:CPTDecimalFromDouble(2.0)];
//    
//    // Axes
//    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)newGraph.axisSet;
//    CPTXYAxis *x          = axisSet.xAxis;
//    x.majorIntervalLength         = CPTDecimalFromDouble(0.5);
//    x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(2.0);
//    x.minorTicksPerInterval       = 1;
//    NSArray *exclusionRanges = @[[CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(1.99) length:CPTDecimalFromDouble(0.02)],
//                                 [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.99) length:CPTDecimalFromDouble(0.02)],
//                                 [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(2.99) length:CPTDecimalFromDouble(0.02)]];
//    x.labelExclusionRanges = exclusionRanges;
//    
//    CPTXYAxis *y = axisSet.yAxis;
//    y.majorIntervalLength         = CPTDecimalFromDouble(0.5);
//    y.minorTicksPerInterval       = 1;
//    y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(2.0);
//    exclusionRanges               = @[[CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(1.99) length:CPTDecimalFromDouble(0.02)],
//                                      [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.99) length:CPTDecimalFromDouble(0.02)],
//                                      [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(3.99) length:CPTDecimalFromDouble(0.02)]];
//    y.labelExclusionRanges = exclusionRanges;
//    
//    // Create a green plot area
//    CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
//    dataSourceLinePlot.identifier = @"Green Plot";
//    
//    CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy];
//    lineStyle.lineWidth              = 3.0;
//    lineStyle.lineColor              = [CPTColor greenColor];
//    lineStyle.dashPattern            = @[@5.0f, @5.0f];
//    dataSourceLinePlot.dataLineStyle = lineStyle;
//    
//    dataSourceLinePlot.dataSource = self;
//    
//    // Put an area gradient under the plot above
//    CPTColor *areaColor       = [CPTColor colorWithComponentRed:CPTFloat(1.0) green:CPTFloat(0.3) blue:CPTFloat(0.3) alpha:CPTFloat(0.8)];
//    CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
//    areaGradient.angle = -90.0;
//    CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient];
//    dataSourceLinePlot.areaFill      = areaGradientFill;
//    dataSourceLinePlot.areaBaseValue = CPTDecimalFromDouble(1.75);
//    
//    // Animate in the new plot, as an example
//    dataSourceLinePlot.opacity        = 0.0;
//    dataSourceLinePlot.cachePrecision = CPTPlotCachePrecisionDecimal;
//    [newGraph addPlot:dataSourceLinePlot];
//    
//    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    fadeInAnimation.duration            = 1.0;
//    fadeInAnimation.removedOnCompletion = NO;
//    fadeInAnimation.fillMode            = kCAFillModeForwards;
//    fadeInAnimation.toValue             = @1.0;
//    [dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
//    
//    // Create a blue plot area
//    CPTScatterPlot *boundLinePlot = [[CPTScatterPlot alloc] init];
//    boundLinePlot.identifier = @"Blue Plot";
//    
//    lineStyle            = [boundLinePlot.dataLineStyle mutableCopy];
//    lineStyle.miterLimit = 1.0;
//    lineStyle.lineWidth  = 3.0;
//    lineStyle.lineColor  = [CPTColor blueColor];
//    
//    boundLinePlot.dataSource     = self;
//    boundLinePlot.cachePrecision = CPTPlotCachePrecisionDouble;
//    boundLinePlot.interpolation  = CPTScatterPlotInterpolationHistogram;
//    [newGraph addPlot:boundLinePlot];
//    
//    // Do a red gradient
//    CPTColor *areaColor1       = [CPTColor colorWithComponentRed:CPTFloat(0.3) green:CPTFloat(0.3) blue:CPTFloat(1.0) alpha:CPTFloat(0.8)];
//    CPTGradient *areaGradient1 = [CPTGradient gradientWithBeginningColor:areaColor1 endingColor:[CPTColor clearColor]];
//    areaGradient1.angle         = -90.0;
//    areaGradientFill            = [CPTFill fillWithGradient:areaGradient1];
//    boundLinePlot.areaFill      = areaGradientFill;
//    boundLinePlot.areaBaseValue = [[NSDecimalNumber zero] decimalValue];
//    
//    // Add plot symbols
//    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
//    symbolLineStyle.lineColor = [CPTColor blackColor];
//    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
//    plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor blueColor]];
//    plotSymbol.lineStyle     = symbolLineStyle;
//    plotSymbol.size          = CGSizeMake(10.0, 10.0);
//    boundLinePlot.plotSymbol = plotSymbol;
//    
//    // Add some initial data
//    NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:100];
//    for ( NSUInteger i = 0; i < 60; i++ ) {
//        NSNumber *xVal = @(1 + i * 0.05);
//        NSNumber *yVal = @(1.2 * arc4random() / (double)UINT32_MAX + 1.2);
//        [contentArray addObject:@{ @"x": xVal, @"y": yVal }];
//    }
//    self.dataForPlot = contentArray;
//}
//
//-(id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
//{
//    NSNumber *num = nil;
//
//    if (index % 8) {
//        NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
//        num = self.dataForPlot[index][key];
////         Green plot gets shifted above the blue
//        if ([(NSString *)plot.identifier isEqualToString : @"Green Plot"]) {
//            if ( fieldEnum == CPTScatterPlotFieldY ) {
//                num = @([num doubleValue] + 1.0);
//            }
//        }
//    }
//    else {
//        num = @(NAN);
//    }
//    
//    return num;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onExportButtonPressed:(UIButton *)sender {
    [[self.calendarData getDocumentInteractionController]
     presentOptionsMenuFromRect:self.exportButton.frame
                        inView:self.view
                      animated:YES];

//Launch excel by url scheme. Not working because target doc not available.
//    NSMutableString* filepath = [NSMutableString stringWithString:@"ms-excel:"];
//    [filepath appendString:[self.calendarData getFileForExport]];
//    NSURL *documentURL = [NSURL URLWithString:filepath];
//    if ([[UIApplication sharedApplication] canOpenURL:documentURL]) {
//        [[UIApplication sharedApplication] openURL:documentURL];
//    }
   
}
@end
