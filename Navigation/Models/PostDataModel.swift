//
//  PostDataModel.swift
//  Navigation
//
//  Created by Sergey on 16.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import CoreData
import StorageService
import UIKit

class PostDataModel {
    var arrayOfPosts = [SavedPost]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func createNewPost(path: Int) {
        let newPost = SavedPost(context: self.context)
        newPost.author = Storage.Content.content[path].author
        newPost.postDescription = Storage.Content.content[path].description
        if let image = Storage.Content.content[path].image {
            let dataImage = image.jpegData(compressionQuality: 1)
            newPost.image = dataImage
        }
        newPost.likes = Int32(Storage.Content.content[path].likes)
        newPost.views = Int32(Storage.Content.content[path].views)
        savePost()
    }
    
    func savePost() {
        do {
            try context.save()
            print("успех")
        } catch {
            print("Ошибка с сохранением поста \(error.localizedDescription)")
        }
    }
}