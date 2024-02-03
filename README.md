
## google_home created with [Flutter](https://flutter.dev/ "Flutter")

This app is created with [Flutter](https://flutter.dev/ "Flutter") and is designed to demonstrate that [Flutter](https://flutter.dev/ "Flutter") runs seamlessly on Linux and Raspberry Pi platforms. It showcases the capability of Flutter's cross-platform development, particularly on embedded systems.  Additionally, we've integrated **[Rive](https://rive.app/ "Rive")** for our animations to showcase its seamless functionality within Linux applications.



https://github.com/Snapp-Embedded/google_home/assets/47558577/e3a43734-2cd2-4224-92a0-0f27a6e8f3d3



## Powered by [snapp_cli](https://github.com/Snapp-Embedded/snapp_cli)

Our "google_home" app was made possible with **[snapp_cli](https://github.com/Snapp-Embedded/snapp_cli)**, a time-saving tool for Flutter developers. Which does everything
from (remote) setting up your embedded device, to enabling remote development and debugging from your normal machine!


## D-Bus Integration
**D-Bus** is a widely-used message bus system for inter-process communication on Linux and other Unix-like operating systems. It provides a standardized and language-agnostic way for different software components, running on the same machine or even on separate devices, to communicate and exchange data. D-Bus enables applications to interact with system services, other applications, and hardware devices seamlessly.

In our "google_home" app, we've utilized D-Bus to seamlessly retrieve sensor information from a Python application. By establishing communication between our Dart-based app and the Python service using D-Bus, we've enabled a reliable and secure sensor data retrieval, enhancing the functionality and user experience of our application.

You can find the Python exmaple in the following file:

[**Python Dbus Server**](https://github.com/Snapp-Embedded/google_home/blob/main/python_server/sensor_server.py "Python Dbus Server") 

And the Dart Dbus Client implementation in the following repo:

[**Dart Dbus Client**](https://github.com/Snapp-Embedded/dart_dbus)

A tutorial on how to implement those Libraries cna be found here: 

[**Medium Article**](https://medium.com/snapp-embedded/interfacing-raspberry-pi-sensors-with-dart-and-flutter-using-d-bus-5203ceee1d9a)
