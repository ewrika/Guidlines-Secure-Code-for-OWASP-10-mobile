# Курсовой проект по iOS безопасности

## Описание проекта
Демонстрационное iOS-приложение на SwiftUI, исследующее аспекты безопасности мобильных приложений. Проект показывает как правильные, так и неправильные практики безопасности.

<img src="Kursach/images/main_screen.jpeg" width="300" alt="Главный экран приложения">

## Структура проекта

### 1. InsecureDataStorage
- **UserDefaults** - Небезопасное хранение данных
- **KeyChain** - Безопасное хранение данных

<div style="display: flex; gap: 10px;">
  <img src="Kursach/images/userdefaults_demo.jpeg" width="200" alt="UserDefaults demo">
  <img src="Kursach/images/keychain_demo.jpeg" width="200" alt="KeyChain demo">
</div>

### 2. InsecureAuth
- **FaceID** - Биометрическая аутентификация
- **Pincode** - Аутентификация по PIN-коду

<div style="display: flex; gap: 10px;">
  <img src="Kursach/images/faceid_demo.PNG" width="200" alt="FaceID demo">
  <img src="Kursach/images/pincode_demo.PNG" width="200" alt="Pincode demo">
</div>

### 3. PoorCode
- **Race Conditions** - Проблемы гонки условий
- **NSLock/GCD** - Решения для многопоточности

<img src="Kursach/images/race_conditions_demo.PNG" width="300" alt="Race Conditions demo">

### 4. ReverseEngineering
- **Detecting Jailbreak** - Определение джейлбрейка

<img src="Kursach/images/jailbreak_demo.PNG" width="300" alt="Jailbreak detection">

### 5. InsecureCommunication
- **HTTP** - Небезопасная коммуникация
- **Certificate Pinning** - SSL-пиннинг

<div style="display: flex; gap: 10px;">
  <img src="Kursach/images/http_demo.PNG" width="200" alt="HTTP demo">
  <img src="Kursach/images/ssl_pinning_demo.PNG" width="200" alt="SSL Pinning demo">
</div>

## Технические детали
- Разработано с использованием SwiftUI
- Минимальная версия iOS: определяется в Info.plist
- Использует современные практики iOS-разработки
- Включает примеры как безопасных, так и небезопасных реализаций

## Особенности
- Интерактивный пользовательский интерфейс
- Демонстрация различных сценариев безопасности
- Образовательные примеры для каждого аспекта безопасности
- Подробные комментарии в коде

## Установка
1. Клонируйте репозиторий
2. Откройте `Kursach.xcodeproj` в Xcode
3. Выберите целевое устройство или симулятор
4. Нажмите Run (⌘R)
