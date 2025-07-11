Hey Devs! Here is a modern and responsive Flutter Scientific Calculator App with both basic and advanced operations, memory functions, history tracking, and keyboard input support — all built following the Single Responsibility Principle.

Features
Basic Arithmetic — +, -, ×, ÷
Advanced Functions — √, sin, cos, tan, log, ln, ^, π, e
Memory Functions — MC, MR, M+, M-
Keyboard Input Support — For physical keyboards
History Tracking — Displays last calculation above the result
Dark & Light Theme Toggle
Responsive UI — Adapts across screen sizes
Error Handling — Graceful handling of invalid operations
Clean Codebase — SRP-compliant architecture for scalability

Architecture
The app is built with a clean separation of concerns:

main.dart — Entry point
calculator_home.dart — UI logic & state handling
calculator_service.dart — All business logic and calculations
calculator_state.dart — Centralized state model
calculator_keyboard.dart & calculator_display.dart — Modular UI components