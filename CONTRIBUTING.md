
# Contributing to SettingsKitUI

Thank you for considering contributing to this project! 🚀  
Contributions are what make the open-source community such an amazing place to learn, inspire, and create.  

Whether you are fixing a bug, proposing a new feature, or improving documentation — we appreciate your effort.  

## How to Fork and Set Up the Project

1. **Fork the Repository** 
 
   Click the **Fork** button on the top right of the project page.  
   - This creates your own copy of the repository under your GitHub account.  

2. **Clone the Repository** 

 ```bash
   git clone git@github.com:HaarisIqubal/SettingsKitUI.git
   cd SettingsKitUI
   ```

3. **Add Upstream Remote (for keeping your fork updated)** 
```bash
git remote add upstream https://github.com/HaarisIqubal/SettingsKitUI.git
```

4. **Create a Branch for Development**
```bash
git checkout -b feature-your-feature-name
```

   

## Development Guidelines

- Ensure you are using a compatible version of Xcode (see `README.md` for minimum requirements).   
- Follow the [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/) to keep the codebase clean and native-feeling.
- Ensure all public components are fully documented using Xcode's DocC comment style (`///`).
- Write meaningful commit messages:
```plaintext
feat: add SKPickerRow component for enum selections
fix: resolve macOS transparent background issue in SKList
docs: update DocC comments for SKSection
```
- Add SwiftUI Previews for any new UI components you introduce.
- Run the Xcode test suite (if applicable) and check your Previews across multiple platforms (iOS, macOS) before submitting your changes.

## How to Describe Issues

If you find a bug or want to suggest a feature:
1. Go to the Issues tab and click New Issue.
2. Use one of the provided templates (Bug Report, Feature Request, etc.) if available.
3. Provide clear and concise information:
   - Title: Summarize in one line.
   - Description: Explain the problem or suggestion in detail.
   - Steps to Reproduce: (for bugs).
   - Expected Behavior vs. Actual Behavior.
   - Screenshots / Video: (Highly recommended!).
   - Environment: (e.g., iOS 17 / macOS 14, Xcode version, Swift version).
   
## Additional Best Practices
- Stay Updated: Rebase or merge from upstream/main frequently.
- Be Respectful: Keep discussions positive and constructive.
- Update Docs: If you change a component's initializer, update its /// DocC comments.
- Test Cross-Platform: Remember that SettingsKitUI supports iOS, macOS, watchOS, and visionOS. Try to verify your UI changes don't break other platforms!

## Code of Conduct
Please note that this project follows a Code of Conduct. By participating, you are expected to uphold this code.

✨ Thank you for helping make SettingsKitUI better! ✨
