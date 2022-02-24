//
//  MopubConstants.swift
//  mopub_flutter
//
//  Created by Rohit Kulkarni on 1/6/20.
//

import Foundation

class MopubConstants {
    static let MAIN_CHANNEL = "mopub";
    static let BANNER_AD_CHANNEL = MAIN_CHANNEL + "/bannerAd";
    
    static let INIT_METHOD = "initialize";
    static let DISPOSE_METHOD = "dispose";
    
    static let EXPANDED_METHOD = "expanded";
    static let DISMISSED_METHOD = "dismissed";
    static let DISPLAYED_METHOD = "displayed";
    static let ERROR_METHOD = "error";
    static let LOADED_METHOD = "loaded";
    static let CLICKED_METHOD = "clicked";
}
