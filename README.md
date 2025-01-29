# 100 Days of SwiftUI

Welcome to my **100 Days of SwiftUI** repository! This repository contains a collection of mini-projects and exercises created while following the "100 Days of SwiftUI" series created by Paul Hudson on his website, Hacking with Swift.

## Overview
This repository is designed to showcase my learning journey as I build various SwiftUI projects. Each day focuses on different SwiftUI concepts, features, and techniques, culminating in hands-on mini-projects.

## Projects
The repository is organized into folders, with each folder corresponding to a day or project in the series. Here's the current structure:

```
xj-100-days-of-swiftui/
├── Project01/
├── Project02/
├── Project03/
├── ... etc
...
```

## Summaries
This section contains brief summaries of each project to track the concepts and techniques covered:

- **Project01 - WeSplit:** Working with **forms** and **sections**, **navigation stacks**, managing program state with **@State** and **@FocusState**, creating controls like **TextField** and **Picker**, and dynamically generating views with **ForEach**.

- **Project02 - GuessTheFlag:** Exploring **stacks (HStack, VStack, ZStack)** to arrange views, customizing the interface with colors, gradients, backgrounds, and frames. Adding interactivity with **Button** and **Label** views, and displaying user feedback with **Alerts**.
  
  Add-ons: Dynamic effects, such as visual feedback (e.g., green/red **overlay**), a timeout mechanic with **timer** paired with **GCD** that progressively fades the screen from blue to black, ending the game when time runs out.

- **Project04- BetterRest:** **Stepper** for incrementing values, **DatePicker** for selecting dates and times, and integrating machine learning models using **Create ML** and **Core ML**
  
  Add-ons: Real-time instant feedback to predicted sleep value by leveraging the **onChange** modifier.

- **Project05 - WordScramble:** Worked with **Dynamic and styled lists**, external resources from the **app bundle**, and validating user input using **UITextChecker**. Handled critical errors using **fatalError()** for missing resources.

  Add-ons: Added a Give Up mechanic to reveal all possible answers, enforced a minimum word length of 3 for valid guesses, and implemented a Reset feature to restart the game seamlessly. Dynamically generated all valid English words from the root word and provided real-time validation of guesses.

- **Project06 - Animations:** Exploring implicit animations with modifiers like **.animation()** and explicit animations using the **withAnimation** block. Learned **.transition()** and custom effects for inserting and removing views.

- **Project07 - iExpense:** Persistent data storage with **UserDefaults** / **@AppStorageManaging** with **Codable** and **JSONDecoder**. **@State** with classes and the **@Observable** macro to manage data dynamically. **List**, **ForEach**, and **onDelete()** to display and manage list items interactively. Used **.sheet** and **@Environment** to present pop-up and dismiss overlays seamlessly.

  Add-ons: Split expenses into separate sections (Personal & Business) with **.filtering** with proper index handling when using **.onDelete()**. Added **contentUnavailableView** to handle empty states.

<div style="display: flex; justify-content: center; align-items: center; gap: 20px;">
<img src="https://github.com/XJ-UoG/xj-100-days-of-swiftui/blob/main/demo/WeSplitDemo.png" alt="WeSplit Demo" width="300">
<img src="https://github.com/XJ-UoG/xj-100-days-of-swiftui/blob/main/demo/GuessTheFlagDemo.gif" alt="GuessTheFlag Demo" width="300">
<img src="https://github.com/XJ-UoG/xj-100-days-of-swiftui/blob/main/demo/BetterRestDemo.gif" alt="BetterRest Demo" width="300">
<img src="https://github.com/XJ-UoG/xj-100-days-of-swiftui/blob/main/demo/WorddScrambleDemo.gif" alt="WorddScramble Demo" width="300">
<img src="https://github.com/XJ-UoG/xj-100-days-of-swiftui/blob/main/demo/AnimationsDemo.gif" alt="Animations Demo" width="300">
  <img src="https://github.com/XJ-UoG/xj-100-days-of-swiftui/blob/main/demo/iExpenseDemo.gif" alt="iExpense Demo" width="300">
</div>

- **Project08 - Coming Soon:**
