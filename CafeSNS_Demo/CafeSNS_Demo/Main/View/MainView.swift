//
//  MainView.swift
//  CafeSNS_Demo
//
//  Created by 김지훈 on 2024/01/13.
//

import SwiftUI

enum Tab{
    case home
    case messages
    case addpost
    case bookmark
    case profile
}

struct MainView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .badge(2)
                .tabItem {
                    Label("house", systemImage: "house")
                }
            MessagesView()
                .tabItem {
                    Label("message", systemImage: "message")
                }
            AddpostView()
                .tabItem {
                    Label("plus", systemImage: "plus.circle")
                }
            BookmarkView()
                .badge("!")
                .tabItem {
                    Label("bookmark", systemImage: "bookmark")
                }

            ProfileView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
        }    }
}

#Preview {
    MainView()
}
