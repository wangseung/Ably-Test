//
//  WishListEmptyView.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/09.
//

import SwiftUI

struct WishListEmptyView: View {
  
  var tap: () async -> Void
  
  var body: some View {
    VStack {
      Image(systemName: "heart")
        .resizable()
        .frame(width: 70, height: 60, alignment: .top)
        .foregroundColor(Color(UIColor.lightGray))
        .padding(.bottom, 10)
      
      Text("좋아요한 상품이 없어요")
        .font(.system(size: 15, weight: .medium))
        .padding(.bottom, 2)
      
      Text("에이블리의 인기 상품을 보러갈까요?")
        .font(.system(size: 14, weight: .light))
        .foregroundColor(Color(UIColor.textSecondary))
        .padding(.bottom, 15)
      
      Button() {
        Task {
          await tap()
        }
      } label: {
        Text("상품 보러가기")
          .padding(EdgeInsets(top: 12, leading: 40, bottom: 12, trailing: 40))
          .font(.system(size: 17, weight: .bold))
      }
      .foregroundColor(.white)
      .background(Color(UIColor.pointRed2))
      .cornerRadius(8)
    }
  }
}

struct WishListEmptyView_Previews: PreviewProvider {
  static var previews: some View {
    WishListEmptyView {
      print("tap!!")
    }
  }
}
