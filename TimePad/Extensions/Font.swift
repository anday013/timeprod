//
//  Font.swift
//  TimePad
//
//  Created by Anday on 27.07.21.
//

import Foundation
import SwiftUI

extension Font {

    /// Create a font with the large title text style.
    public static var largeTitleRubik: Font {
        return Font.custom("Rubik-Regular", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }

    /// Create a font with the title text style.
    public static var titleRubik: Font {
        return Font.custom("Rubik-Regular", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
    
    /// Create a font with the title text style.
    public static var title2Rubik: Font {
        return Font.custom("Rubik-Regular", size: UIFont.preferredFont(forTextStyle: .title2).pointSize)
    }
    
    /// Create a font with the title text style.
    public static var title3Rubik: Font {
        return Font.custom("Rubik-Regular", size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
    }


    /// Create a font with the headline text style.
    public static var headlineRubik: Font {
        return Font.custom("Rubik-Regular", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }

    /// Create a font with the subheadline text style.
    public static var subheadlineRubik: Font {
        return Font.custom("Rubik-Light", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }

    /// Create a font with the body text style.
    public static var bodyRubik: Font {
        return Font.custom("Rubik-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }

    /// Create a font with the callout text style.
    public static var calloutRubik: Font {
        return Font.custom("Rubik-Regular", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }

    /// Create a font with the footnote text style.
    public static var footnoteRubik: Font {
        return Font.custom("Rubik-Regular", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }

    /// Create a font with the caption text style.
    public static var captionRubik: Font {
        return Font.custom("Rubik-Regular", size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
    }

    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        var font = "Rubik-Regular"
        switch weight {
        case .bold: font = "Rubik-Bold"
        case .heavy: font = "Rubik-ExtraBold"
        case .light: font = "Rubik-Light"
        case .medium: font = "Rubik-Regular"
        case .semibold: font = "Rubik-SemiBold"
        case .thin: font = "Rubik-Light"
        case .ultraLight: font = "Rubik-Light"
        default: break
        }
        return Font.custom(font, size: size)
    }
}
