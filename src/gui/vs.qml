import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    property string backgroundColour: virtualstudio.darkMode ? "#272525" : "#FAFBFB"
    property string textColour: virtualstudio.darkMode ? "#FAFBFB" : "#0F0D0D"
    
    width: 696
    height: 577
    color: backgroundColour
    state: virtualstudio.showFirstRun ? "start" : "login"
    anchors.fill: parent

    id: window
    states: [
        State {
            name: "start"
            PropertyChanges { target: startScreen; x: 0 }
            PropertyChanges { target: loginScreen; x: window.width; failTextVisible: loginScreen.failTextVisible }
            PropertyChanges { target: setupScreen; x: window.width }
            PropertyChanges { target: browseScreen; x: window.width }
            PropertyChanges { target: settingsScreen; x: window.width }
            PropertyChanges { target: connectedScreen; x: window.width }
        },

        State {
            name: "login"
            PropertyChanges { target: startScreen; x: -startScreen.width }
            PropertyChanges { target: loginScreen; x: 0; failTextVisible: false }
            PropertyChanges { target: setupScreen; x: window.width }
            PropertyChanges { target: browseScreen; x: window.width }
            PropertyChanges { target: settingsScreen; x: window.width }
            PropertyChanges { target: connectedScreen; x: window.width }
        },

        State {
            name: "setup"
            PropertyChanges { target: loginScreen; x: -loginScreen.width }
            PropertyChanges { target: startScreen; x: -startScreen.width }
            PropertyChanges { target: setupScreen; x: 0 }
            PropertyChanges { target: browseScreen; x: window.width }
            PropertyChanges { target: settingsScreen; x: window.width }
            PropertyChanges { target: connectedScreen; x: window.width }
        },

        State {
            name: "browse"
            PropertyChanges { target: loginScreen; x: -loginScreen.width }
            PropertyChanges { target: startScreen; x: -startScreen.width }
            PropertyChanges { target: setupScreen; x: -setupScreen.width }
            PropertyChanges { target: browseScreen; x: 0 }
            PropertyChanges { target: settingsScreen; x: window.width }
            PropertyChanges { target: connectedScreen; x: window.width }
        },

        State {
            name: "settings"
            PropertyChanges { target: loginScreen; x: -loginScreen.width }
            PropertyChanges { target: startScreen; x: -startScreen.width }
            PropertyChanges { target: setupScreen; x: -setupScreen.width }
            PropertyChanges { target: browseScreen; x: -browseScreen.width }
            PropertyChanges { target: settingsScreen; x: 0 }
            PropertyChanges { target: connectedScreen; x: window.width }
        },

        State {
            name: "connected"
            PropertyChanges { target: loginScreen; x: -loginScreen.width }
            PropertyChanges { target: startScreen; x: -startScreen.width }
            PropertyChanges { target: setupScreen; x: -setupScreen.width }
            PropertyChanges { target: browseScreen; x: -browseScreen.width }
            PropertyChanges { target: settingsScreen; x: window.width }
            PropertyChanges { target: connectedScreen; x: 0 }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; duration: 800; easing.type: Easing.InOutQuad }
    }

    FirstLaunch {
        id: startScreen
    }
    
    Setup {
        id: setupScreen
    }

    Browse {
        id: browseScreen
    }
    
    Login {
        id: loginScreen
    }

    Settings {
        id: settingsScreen
    }

    Connected {
        id: connectedScreen
    }

    Connections {
        target: virtualstudio
        onAuthSucceeded: { 
            if (virtualstudio.showDeviceSetup) {
                window.state = "setup";
            } else {
                window.state = "browse";
            }
        }
        onAuthFailed: {
            loginScreen.failTextVisible = true;
        }
        // onConnected: { }
        onDisconnected: {
            window.state = "browse";
        }
    }
}