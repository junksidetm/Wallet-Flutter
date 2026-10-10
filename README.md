# Wallet

<p align="center">
<img src="assets\images\logo.svg" height="160" alt="Logo">
</p>

[![GitHub Main](https://img.shields.io/badge/GitHub-Main-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/junksidetm/Wallet-Flutter)
[![Codeberg Mirror](https://img.shields.io/badge/Codeberg-Mirror-2185d0?style=flat-square&logo=codeberg&logoColor=white)](https://codeberg.org/mrdarksidetm/Wallet-Flutter)
[![GitLab Mirror](https://img.shields.io/badge/GitLab-Mirror-fc6d26?style=flat-square&logo=gitlab&logoColor=white)](https://gitlab.com/mrdarksidetm/Wallet-Flutter)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.5.0-blue.svg?logo=flutter)](https://flutter.dev)
[![Material 3](https://img.shields.io/badge/Design-Material_3-green.svg)](https://m3.material.io)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-brightgreen.svg)](https://github.com/junksidetm/Wallet-Flutter/graphs/commit-activity)

**Project Wallet** is a premium, offline-first personal finance dashboard built with **Flutter 2026 Standards**. It empowers users to monitor their financial health, track transactions, manage multiple wallets, and visualize spending with high-performance, native aesthetics. ✨

<div align="center">
  <a href="https://github.com/junksidetm/Wallet-Flutter/releases/latest/download/wallet-arm64-v8a.apk" target="_blank" rel="noopener noreferrer">
    <img src="https://raw.githubusercontent.com/junksidetm/assests/d8774837b8c8658389ea37193a77a9a100414bc5/Images/badges/SVG%20-%20Version/Android%20Direct%20Link%20Frame.svg" alt="Direct Link" width="290">
  </a>
</div>

---

## 🚀 Key Features

* **💳 Multi-Account Management**: Track Cash, Bank, Credit Cards, and Savings in one place.
* **📊 Expressive Analytics**: Native Canvas-driven charts for income vs. expense breakdown.
* **📈 Real-time Statistics**: Live-updating trends for budgets, assets, and loans.
* **🔄 Automated Workflows**: Recurring transactions, subscriptions, and bill splitting.
* **🎯 Financial Goals**: Set and track savings targets with beautiful progress indicators.
* **🔒 Privacy First**: 100% offline, local storage with optional Biometric Auth.
* **🎨 Dynamic Personalization**: Full Material 3 support with Dynamic Color (Monet) and custom typography.

---

## 📲 Download Links

* Click the button below, to download the `Universal APk`. This apk can run on any device. You don't need to care about anything.
<br><br>
<p align="center">
<a href="https://github.com/junksidetm/Wallet-Flutter/releases/latest/download/wallet-universal.apk" target="_blank"><img src="assets/images/Direct%20Link%20Frame%20Badge.svg" height="100" alt="Direct Downloader Badge"></a></p>

<BR><BR>

* If you use 3rd Party Providers, like [Obtanium](https://obtainium.imranr.dev/) or some other service to download or track from Github Releases. Use the links below.
<p align="center">
<a href="http://apps.obtainium.imranr.dev/redirect.html?r=obtainium://app/%7B%22id%22%3A%22com.mrdarksidetm.wallet%22%2C%22url%22%3A%22https%3A%2F%2Fgithub.com%2Fjunksidetm%2FWallet-Flutter%22%2C%22author%22%3A%22mrdarksidetm%22%2C%22name%22%3A%22Wallet%20Flutter%22%2C%22preferredApkIndex%22%3A0%2C%22additionalSettings%22%3A%22%7B%5C%22includePrereleases%5C%22%3Afalse%2C%5C%22fallbackToOlderReleases%5C%22%3Afalse%2C%5C%22filterReleaseTitlesByRegEx%5C%22%3A%5C%22%5C%22%2C%5C%22filterReleaseNotesByRegEx%5C%22%3A%5C%22%5C%22%2C%5C%22verifyLatestTag%5C%22%3Afalse%2C%5C%22dontSortReleasesList%5C%22%3Afalse%2C%5C%22trackOnly%5C%22%3Afalse%2C%5C%22versionDetection%5C%22%3A%5C%22standardVersionDetection%5C%22%2C%5C%22apkFilterRegEx%5C%22%3A%5C%22%5C%22%2C%5C%22autoApkFilterByArch%5C%22%3Atrue%2C%5C%22appName%5C%22%3A%5C%22%5C%22%2C%5C%22exemptFromBackgroundUpdates%5C%22%3Afalse%2C%5C%22skipUpdateNotifications%5C%22%3Afalse%2C%5C%22about%5C%22%3A%5C%22%5C%22%7D%22%7D" target="_blank"><img src="assets/images/obtanium-badge.png" height="100" alt="Obtanium Badge"></a>
<a href="https://github.com/junksidetm/Wallet-Flutter/releases/latest" target="_blank"><img src="assets/images/github-badge.png" height="100" alt="Github Badge"></a>
</p>

---

## 🛠️ Technical Stack

* **Framework**: [Flutter](https://flutter.dev) (Dart)
* **State Management**: [Riverpod 2.0](https://riverpod.dev) (with code generation)
* **Database**: [Isar](https://isar.dev) (High-performance NoSQL)
* **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
* **UI Components**: [Material 3](https://m3.material.io) (Expressive Geometry)
* **Icons**: [Material Symbols](https://fonts.google.com/icons) (Variable)

---

## 📥 Getting Started

### Prerequisites

* Flutter SDK `>=3.5.0`
* Android Studio / VS Code
* A physical device or emulator (Android 14+ recommended)

### Installation 💻

1. **Clone the repository**:

    ```bash
    git clone --recursive https://github.com/junksidetm/Wallet-Flutter.git
    cd Wallet-Flutter
    ```

2. **Install dependencies**:

    ```bash
    flutter pub get
    ```

3. **Generate data models**:

    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4. **Run the application**:

    ```bash
    flutter run
    ```

---

## 🗺️ Roadmap & Progress

| Phase | Description | Status |
| :--- | :--- | :--- |
| **Phase 1** | The Engine (Isar DB & Models) | ✅ Complete |
| **Phase 2** | The Skeleton (Navigation & AppShell) | ✅ Complete |
| **Phase 3** | The Dashboard (Home & Stats) | ✅ Complete |
| **Phase 4** | The Ledger (Account History) | ✅ Complete |
| **Phase 5** | The Input Pipeline (Transactions) | ✅ Complete |
| **Phase 6** | Visualizations (Canvas Charts) | ✅ Complete |
| **Phase 7** | Refinement (UX & Reordering) | ✅ Complete |
| **Phase 8** | Micro Details (Adding Flare) | 🚀 In Progress |

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**. 💖

Please see our [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information. ⚖️

## 🌐 Source Mirrors

- **Main (GitHub)**: [github.com/junksidetm/Wallet-Flutter](https://github.com/junksidetm/Wallet-Flutter)
- **Mirror (Codeberg)**: [codeberg.org/mrdarksidetm/Wallet-Flutter](https://codeberg.org/mrdarksidetm/Wallet-Flutter)
- **Mirror (GitLab)**: [gitlab.com/mrdarksidetm/Wallet-Flutter](https://gitlab.com/mrdarksidetm/Wallet-Flutter)

---

## 📧 Contact

**Abhijeet Yadav** - [@junksidetm](https://github.com/junksidetm) 👨‍💻

Project Link: [https://github.com/junksidetm/Wallet-Flutter](https://github.com/junksidetm/Wallet-Flutter) 🔗

---
*Built with ❤️ for the Flutter Community.*

---

<div align="center">
<a href="https://github.com/junksidetm/junksidetm.github.io">
  <img src="https://raw.githubusercontent.com/junksidetm/assests/981a029b9f59b8ed581bbee9be318c86da52dcca/Images/Codium/Codium%20Banner/SVG/Codium%20-%20Banner%20Black.svg" width="360"></a>
<br><br>
<sub>
<p>This repository is a part of `"Codeium"`. A part of Darkside Studio.
</p>
</sub>
<p><b><sub>© 2026 Abhijeet Yadav.  All rights reserved. All logos are Copyright Law </sub></b></p>
