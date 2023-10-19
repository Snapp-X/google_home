#!/usr/bin/env python3

from __future__ import print_function

usage = """
Sensor Server Started Successfully

Wait for the client to connect:
"""

from gi.repository import GLib

import dbus
import dbus.service
import dbus.mainloop.glib

class DemoException(dbus.DBusException):
    _dbus_error_name = 'com.example.DemoException'

class SomeObject(dbus.service.Object):

    @dbus.service.method("com.example.SampleInterface",
                         in_signature='', out_signature='as')
    def GetSensorValue(self):
        print("GetSensorValue request:", session_bus.get_unique_name())
        # TODO: Get sensor value from sensor and return it
        # return value for now is just a dummy value
        return ["Temperature: 25C", "Humidity: 50%", "Pressure: 1000hPa",
                session_bus.get_unique_name()]

    @dbus.service.method("com.example.SampleInterface",
                         in_signature='', out_signature='')
    def Exit(self):
        mainloop.quit()


if __name__ == '__main__':
    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)

    session_bus = dbus.SessionBus()
    name = dbus.service.BusName("com.example.SampleService", session_bus)
    object = SomeObject(session_bus, '/SomeObject')

    mainloop = GLib.MainLoop()
    print(usage)
    mainloop.run()