
## google_home created with [Flutter](https://flutter.dev/ "Flutter")

This app is created with [Flutter](https://flutter.dev/ "Flutter") and is designed to demonstrate that [Flutter](https://flutter.dev/ "Flutter") runs seamlessly on Linux and Raspberry Pi platforms. It showcases the capability of Flutter's cross-platform development, particularly on embedded systems.  Additionally, we've integrated **[Rive](https://rive.app/ "Rive")** for our animations to showcase its seamless functionality within Linux applications.



https://github.com/Snapp-Embedded/google_home/assets/47558577/e3a43734-2cd2-4224-92a0-0f27a6e8f3d3



## Powered by [snapp_installer](https://github.com/Snapp-Embedded/snapp_installer "snapp_installer")

Our "google_home" app was made possible with **[snapp_installer](https://github.com/Snapp-Embedded/snapp_installer "snapp_installer")**, a time-saving tool for Flutter developers on Raspberry Pi. This Bash script automates Flutter environment setup, installs necessary dependencies, and supports kiosk mode. By leveraging  **[snapp_installer](https://github.com/Snapp-Embedded/snapp_installer "snapp_installer")**, we simplified the development and deployment of our app, ensuring a smooth experience for users setting up Flutter applications on their Raspberry Pi devices.


## D-Bus Integration
**D-Bus** is a widely-used message bus system for inter-process communication on Linux and other Unix-like operating systems. It provides a standardized and language-agnostic way for different software components, running on the same machine or even on separate devices, to communicate and exchange data. D-Bus enables applications to interact with system services, other applications, and hardware devices seamlessly.

In our "google_home" app, we've utilized D-Bus to seamlessly retrieve sensor information from a Python application. By establishing communication between our Dart-based app and the Python service using D-Bus, we've enabled real-time sensor data retrieval, enhancing the functionality and user experience of our application.

You can find the Python exmaple in the following file:

[**Python Dbus Server**](https://github.com/Snapp-Embedded/google_home/blob/main/python_server/sensor_server.py "Python Dbus Server") 

And the Dart Dbus Client implementation in the following file:

[**Dart Dbus Client**](https://github.com/Snapp-Embedded/google_home/blob/main/lib/src/home_feature/home_controller.dart "**Dart Dbus Client**")
