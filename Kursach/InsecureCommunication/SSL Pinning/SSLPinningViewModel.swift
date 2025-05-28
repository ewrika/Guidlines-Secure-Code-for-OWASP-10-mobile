//
//  SSLPinningViewModel.swift
//  Kursach
//
//  Created by Георгий Борисов on 28.05.2025.
//

import Foundation
import UIKit

class SSLPinningViewModel:ObservableObject {
    @Published var responseText: String = "Ожидаем ответа."
    @Published var image: UIImage? = nil
    
    private lazy var pinnedSession: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        return URLSession(
            configuration: sessionConfig,
            delegate: SSLPinningDelegate(),
            delegateQueue: nil
        )
    }()
    
    func loadImage() {
        guard let url = URL(string: "https://httpbin.org/image/jpeg") else {
            responseText = "Invalid image URL"
            return
        }
        
        let task = pinnedSession.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.responseText = "Image error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    self?.responseText = "Ошибка декодирования"
                    return
                }
                
                self?.image = image
                self?.responseText = "Изображение получено "
            }
        }
        task.resume()
    }
}


class SSLPinningDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        print("=== SSL Verification Started ===")
        
        guard let serverTrust = challenge.protectionSpace.serverTrust,
              let serverCert = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
            print("❌ No server trust/certificate")
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Логирование серверного сертификата
        var serverName: CFString?
        SecCertificateCopyCommonName(serverCert, &serverName)
        print("Server Cert Name: \(serverName ?? "Unknown" as CFString)")
        
        guard let localCertPath = Bundle.main.path(forResource: "httpbin_cert", ofType: "der"),
              let localCertData = try? Data(contentsOf: URL(fileURLWithPath: localCertPath)) else {
            print("❌ Local certificate not found")
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        guard let localCert = SecCertificateCreateWithData(nil, localCertData as CFData) else {
            print("❌ Failed to create local cert object")
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Сравнение данных
        let serverData = SecCertificateCopyData(serverCert) as Data
        let localData = SecCertificateCopyData(localCert) as Data

        if serverData == localData {
            print("✅ Certificates match! Proceeding...")
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } else {
            print("❌ Certificate mismatch! Blocking...")
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}


