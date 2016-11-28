//
//  BaseSegmentControl.swift
//  CloudStudy
//
//  Created by pro on 2016/11/24.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

//MARK: - Enum -
enum SegmentedControlSelectionStyle {
    case TextWidthStripe  // Indicator width will only be as big as the text width
    case FullWidthStripe  // Indicator width will fill the whole segment
    case Box              // A rectangle that covers the whole segment
    case Arrow            // An arrow in the middle of the segment pointing up or down depending on `HMSegmentedControlSelectionIndicatorLocation`
}

enum SegmentedControlSelectionIndicatorLocation {
    case Up
    case Down
    case None
}

enum SegmentedControlSegmentWidthStyle {
    case Fixed     // Segment width is fixed
    case Dynamic   // Segment width will only be as big as the text width (including inset)
}

typealias indexChangeClosure = (Int) -> ()

//MARK: - BaseSegmentControl -

class BaseSegmentControl: UIView {

    //MARK: - Public Property
    
    public var sectionTitles              : Array<String>  = []
    public var sectionImages              : Array<UIImage> = []
    public var sectionSelectedImages      : Array<UIImage> = []
    
    /**
     Provide a block to be executed when selected index is changed.
     
     Alternativly, you could use `addTarget:action:forControlEvents:`
     */
    public var indexChangeClosure         : indexChangeClosure?
    
    
    public var selectedIndicatorColor      : UIColor? // default is black
    public var selectionIndicatorHeight    : CGFloat? // default is 2.0
    
    // Style
    /**
     Specifies the style of the selection indicator.
     
     Default is `TextWidthStripe`
     */
    public var selectionStyle             : SegmentedControlSelectionStyle?
    /**
     Specifies the style of the segment's width.
     
     Default is `Fixed`
     */
    public var segmentWidthStyle          : SegmentedControlSegmentWidthStyle?
    /**
     Specifies the location of the selection indicator.
     
     Default is `Up`
     */
    public var selectionIndicatorLocation : SegmentedControlSelectionIndicatorLocation?
    
    /**
     Index of the currently selected segment.
     */
    public var selectedSegmentIndex        : Int?

    
    //MARK: - Private Property
    private var scrollView : UIScrollView?
    private var segmentWidth : CGFloat?
    
    
    //MARK: - Convenience init -
    convenience init(_ sectionTitles:Array<String>) {
        self.init(frame: CGRect.zero)
        self.sectionTitles = sectionTitles
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        // default style
        backgroundColor = UIColor.white
        selectedSegmentIndex = 0
        selectionIndicatorHeight = 2
        selectedIndicatorColor   = UIColor.black
        
        
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        self.scrollView = scrollView
        
        isOpaque = false
    }
    
}



























