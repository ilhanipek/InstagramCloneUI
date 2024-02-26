//
//  SheetViewModel.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 8.10.2023.
//

import Foundation
import SwiftUI

enum SheetSize {
  case medium
  case large
}

class SheetViewModel: ObservableObject {
  @Published var sheetSize: PresentationDetent = .large

  func setSheetSize(selectedSize: PresentationDetent){

    switch selectedSize {
    case .medium:
      sheetSize = .medium
    case .large:
      sheetSize = .large
    default:
      sheetSize = .large 
    }
  }
}
