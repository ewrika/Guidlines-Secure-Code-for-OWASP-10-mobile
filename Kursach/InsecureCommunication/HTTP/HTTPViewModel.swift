import SwiftUI
import UIKit

class HTTPViewModel: ObservableObject {
    @Published var responseText: String = "Делаем запрос...."
    @Published var image: UIImage? = nil
    
    func loadImage() {
        guard let url = URL(string: "http://httpbin.org/image/jpeg") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.responseText = "Ошибка изображения: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    self?.responseText = "Ошибка декодирования"
                    return
                }
                
                self?.image = image
                self?.responseText = "Изображение получено"
            }
        }
        task.resume()
    }
}
