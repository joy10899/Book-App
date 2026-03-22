# EM385(2) iOS Book App

A Swift iOS app for browsing and searching EM 385-1-1 safety manual content by chapter and section.

## Overview

This repository contains an Xcode UIKit application that:
- shows chapter-based navigation for EM385 content,
- displays section text stored in Realm,
- supports keyword search across section content,
- highlights topic/section patterns in text,
- allows sharing selected section content as an HTML export,
- includes light/dark theme switching.

## Tech Stack

- Swift 5
- UIKit
- Realm Swift (via Swift Package Manager)
- Xcode project: `EM385(2).xcodeproj`

## Project Structure

- `EM385(2)/Controller/`: View controllers (chapters, sections, search, settings, onboarding)
- `EM385(2)/Model/`: Data models (`Chapter`, Realm `Section`) and reusable model logic
- `EM385(2)/View/`: Storyboards and view resources
- `EM385(2)/Controller/2014 Books/`: Chapter CSV source files
- `EM385(2)Tests/`: Unit tests
- `EM385(2)UITests/`: UI tests

## Requirements

- macOS with Xcode installed
- iOS deployment target in project settings is currently 17.5/18.0 depending on build config
- Internet access on first dependency resolution (for Realm Swift package)

## Getting Started

1. Open `EM385(2).xcodeproj` in Xcode.
2. Select an iOS Simulator (or a connected device).
3. Build and run the app (`Cmd+R`).
4. If prompted, allow Swift Package dependencies to resolve.

## Data Notes

- The app reads section content from Realm objects (`Section`).
- CSV files are present under `EM385(2)/Controller/2014 Books/` as source content.
- Ensure Realm has the expected `Section` data for full chapter/section browsing and search behavior.

## Main Screens

- Welcome / onboarding flow
- Chapter list with expandable rows
- Section detail view with highlight logic and share action
- Search view with highlighted query terms
- Settings view with persistent theme toggle


