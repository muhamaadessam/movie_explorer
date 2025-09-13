# Screenshots Directory

This directory contains screenshots of the Movie Explorer app for the README file.

## Required Screenshots

Please add the following screenshots to showcase your app:

### Main Screenshots
- `movies_screen.png` - Main movies list screen
- `movie_details.png` - Movie details screen
- `search_screen.png` - Search functionality
- `favorites_screen.png` - Favorites list

### Theme Screenshots
- `dark_mode_movies.png` - Movies screen in dark mode
- `dark_mode_details.png` - Movie details in dark mode

## How to Take Screenshots

1. **Android Emulator/Device:**
   ```bash
   # Take screenshot using ADB
   adb exec-out screencap -p > screenshots/movies_screen.png
   ```

2. **iOS Simulator:**
   - Use Cmd+S to save screenshot
   - Or use the Device menu > Screenshot

3. **Flutter Web:**
   - Use browser developer tools
   - Or browser screenshot extensions

## Screenshot Guidelines

- Use consistent device/screen size
- Show the app in both light and dark themes
- Capture key features and interactions
- Keep file sizes reasonable (under 1MB each)
- Use PNG format for best quality

## File Naming Convention

- Use descriptive names: `feature_screen.png`
- Include theme if relevant: `dark_mode_feature.png`
- Use lowercase with underscores
