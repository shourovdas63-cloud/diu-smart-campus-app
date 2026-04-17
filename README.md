# DIU Smart Campus App

A modern **Flutter + Flask** campus companion app for **Daffodil International University (DIU)**.  
This project was extended from an earlier routine-based project and redesigned into a **multi-screen Smart Campus App** with routine management, student profile, notices, bus schedule, exam information, and accessibility settings.

---

## Features

### Student Modules
- **Student Profile**
  - Save name, student ID, department, and section
  - Data persistence using **Hive**

- **Routine**
  - Search class routine by batch/section
  - Upload routine file from frontend
  - Export routine as **PDF**
  - Data fetched from backend API

- **Notices & Events**
  - View academic and campus notices
  - Bookmark notices

- **Bus Schedule**
  - View DIU bus routes and timing
  - See route status
  - Bookmark bus schedule entries

- **Exam Info**
  - View course exam schedule
  - Check date, time, room, and exam type
  - Bookmark exam items

- **Settings & Accessibility**
  - Dark mode
  - High contrast mode
  - Adjustable text size
  - Saved locally using **Hive**

---

## Screens

This app includes multiple interactive screens:

- Splash Screen
- Home Dashboard
- Student Profile
- Routine Screen
- Notices Screen
- Bus Schedule Screen
- Exam Info Screen
- Settings & Accessibility Screen

---

## Tech Stack

### Frontend
- **Flutter**
- **Provider** for state management
- **Hive / Hive Flutter** for local data persistence
- **HTTP** for API integration
- **PDF / Printing** for exporting routine
- **File Picker** for uploading routine files

### Backend
- **Python Flask**
- **Pandas**
- **OpenPyXL**
- **Flask-CORS**

---

## Project Structure

```bash
backend/
  app.py
  requirements.txt
  Procfile

frontend/
  lib/
    main.dart
    providers/
      theme_provider.dart
      profile_provider.dart
    screens/
      splash_screen.dart
      home_screen.dart
      login_screen.dart
      routine_screen.dart
      notices_screen.dart
      bus_screen.dart
      exam_screen.dart
      settings_screen.dart
