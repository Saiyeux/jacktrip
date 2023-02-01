import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Item {
    width: parent.width; height: parent.height
    clip: true

    property int fontBig: 20
    property int fontMedium: 13
    property int fontSmall: 11
    property int fontExtraSmall: 8

    property int buttonWidth: 103
    property int buttonHeight: 25

    property int leftMargin: 48
    property int rightMargin: 16

    property string backgroundColour: virtualstudio.darkMode ? "#272525" : "#FAFBFB"
    property real imageLightnessValue: virtualstudio.darkMode ? 1.0 : 0.0
    property string textColour: virtualstudio.darkMode ? "#FAFBFB" : "#0F0D0D"
    property string buttonColour: virtualstudio.darkMode ? "#494646" : "#EAECEC"
    property string buttonHoverColour: virtualstudio.darkMode ? "#5B5858" : "#D3D4D4"
    property string buttonPressedColour: virtualstudio.darkMode ? "#524F4F" : "#DEE0E0"
    property string buttonStroke: virtualstudio.darkMode ? "#80827D7D" : "#34979797"
    property string buttonHoverStroke: virtualstudio.darkMode ? "#7B7777" : "#BABCBC"
    property string buttonPressedStroke: virtualstudio.darkMode ? "#827D7D" : "#BABCBC"
    property string sliderColour: virtualstudio.darkMode ? "#BABCBC" :  "#EAECEC"
    property string sliderPressedColour: virtualstudio.darkMode ? "#ACAFAF" : "#DEE0E0"
    property string saveButtonShadow: "#80A1A1A1"
    property string saveButtonBackgroundColour: "#F2F3F3"
    property string saveButtonPressedColour: "#E7E8E8"
    property string saveButtonStroke: "#EAEBEB"
    property string saveButtonPressedStroke: "#B0B5B5"
    property string warningText: "#DB0A0A"
    property string saveButtonText: "#DB0A0A"
    property string checkboxStroke: "#0062cc"
    property string checkboxPressedStroke: "#007AFF"
    property string disabledButtonText: "#D3D4D4"
    property string linkText: virtualstudio.darkMode ? "#8B8D8D" : "#272525"

    property bool currShowWarnings: virtualstudio.showWarnings
    property string warningScreen: virtualstudio.showWarnings ? "ethernet" : ( permissions.micPermission == "unknown" ? "microphone" : "acknowledged")
 
    Item {
        id: ethernetWarningItem
        width: parent.width; height: parent.height
        visible: warningScreen == "ethernet"

        Image {
            id: ethernetWarningLogo
            source: "ethernet.png"
            width: 179
            height: 128
            y: 60
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Colorize {
            anchors.fill: ethernetWarningLogo
            source: ethernetWarningLogo
            hue: 0
            saturation: 0
            lightness: imageLightnessValue
        }

        Text {
            id: ethernetWarningHeader
            text: "Connect via Wired Ethernet"
            font { family: "Poppins"; weight: Font.Bold; pixelSize: fontMedium * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ethernetWarningLogo.bottom
            anchors.topMargin: 32 * virtualstudio.uiScale
        }

        Text {
            id: ethernetWarningSubheader1
            text: "JackTrip works best when you connect directly to your router via wired ethernet."
            font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            width: 400
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ethernetWarningHeader.bottom
            anchors.topMargin: 32 * virtualstudio.uiScale
        }

        Text {
            id: ethernetWarningSubheader2
            text: "WiFi works OK for some people, but you will experience higher latency and audio glitches."
            font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            width: 400
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ethernetWarningSubheader1.bottom
            anchors.topMargin: 24 * virtualstudio.uiScale
        }

        Button {
            id: okButtonEthernet
            background: Rectangle {
                radius: 6 * virtualstudio.uiScale
                color: okButtonEthernet.down ? saveButtonPressedColour : saveButtonBackgroundColour
                border.width: 1
                border.color: okButtonEthernet.down ? saveButtonPressedStroke : saveButtonStroke
                layer.enabled: okButtonEthernet.hovered && !okButtonEthernet.down
                layer.effect: DropShadow {
                    horizontalOffset: 1 * virtualstudio.uiScale
                    verticalOffset: 1 * virtualstudio.uiScale
                    radius: 8.0 * virtualstudio.uiScale
                    samples: 17
                    color: saveButtonShadow
                }
            }
            onClicked: { warningScreen = "headphones" }
            anchors.right: parent.right
            anchors.rightMargin: 16 * virtualstudio.uiScale
            anchors.bottomMargin: 16 * virtualstudio.uiScale
            anchors.bottom: parent.bottom
            width: 150 * virtualstudio.uiScale; height: 30 * virtualstudio.uiScale
            Text {
                text: "OK"
                font.family: "Poppins"
                font.pixelSize: 11 * virtualstudio.fontScale * virtualstudio.uiScale
                font.weight: Font.Bold
                color: saveButtonText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        CheckBox {
            id: showEthernetWarningCheckbox
            checked: currShowWarnings
            text: qsTr("Show warnings again next time")
            anchors.right: okButtonEthernet.left
            anchors.rightMargin: 16 * virtualstudio.uiScale
            anchors.verticalCenter: okButtonEthernet.verticalCenter
            onClicked: { currShowWarnings = showEthernetWarningCheckbox.checkState == Qt.Checked }
            indicator: Rectangle {
                implicitWidth: 16 * virtualstudio.uiScale
                implicitHeight: 16 * virtualstudio.uiScale
                x: showEthernetWarningCheckbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3 * virtualstudio.uiScale
                border.color: showEthernetWarningCheckbox.down ? checkboxPressedStroke : checkboxStroke

                Rectangle {
                    width: 10 * virtualstudio.uiScale
                    height: 10 * virtualstudio.uiScale
                    x: 3 * virtualstudio.uiScale
                    y: 3 * virtualstudio.uiScale
                    radius: 2 * virtualstudio.uiScale
                    color: showEthernetWarningCheckbox.down ? checkboxPressedStroke : checkboxStroke
                    visible: showEthernetWarningCheckbox.checked
                }
            }
            contentItem: Text {
                text: showEthernetWarningCheckbox.text
                font.family: "Poppins"
                font.pixelSize: 10 * virtualstudio.fontScale * virtualstudio.uiScale
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: showEthernetWarningCheckbox.indicator.width + showEthernetWarningCheckbox.spacing
                color: textColour
            }
        }
    }

    Item {
        id: headphoneWarningItem
        width: parent.width; height: parent.height
        visible: warningScreen == "headphones"

        Image {
            id: headphoneWarningLogo
            source: "headphones.svg"
            sourceSize: Qt.size( img.sourceSize.width*5, img.sourceSize.height*5 )
            Image {
                id: img
                source: parent.source
                width: 0
                height: 0
            }
            width: 118
            height: 128
            y: 60
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Colorize {
            anchors.fill: headphoneWarningLogo
            source: headphoneWarningLogo
            hue: 0
            saturation: 0
            lightness: imageLightnessValue
        }

        Text {
            id: headphoneWarningHeader
            text: "Use Wired Headphones"
            font { family: "Poppins"; weight: Font.Bold; pixelSize: fontMedium * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: headphoneWarningLogo.bottom
            anchors.topMargin: 32 * virtualstudio.uiScale
        }

        Text {
            id: headphoneWarningSubheader1
            text: "JackTrip requires the use of wired headphones."
            font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            width: 400
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: headphoneWarningHeader.bottom
            anchors.topMargin: 32 * virtualstudio.uiScale
        }

        Text {
            id: headphoneWarningSubheader2
            text: "Using speakers can cause loud feedback loops."
            font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            width: 400
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: headphoneWarningSubheader1.bottom
            anchors.topMargin: 24 * virtualstudio.uiScale
        }

        Text {
            id: headphoneWarningSubheader3
            text: "Wireless headphones add way too much latency."
            font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            width: 400
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: headphoneWarningSubheader2.bottom
            anchors.topMargin: 24 * virtualstudio.uiScale
        }

        Button {
            id: okButtonHeadphones
            background: Rectangle {
                radius: 6 * virtualstudio.uiScale
                color: okButtonHeadphones.down ? saveButtonPressedColour : saveButtonBackgroundColour
                border.width: 1
                border.color: okButtonHeadphones.down ? saveButtonPressedStroke : saveButtonStroke
                layer.enabled: okButtonHeadphones.hovered && !okButtonHeadphones.down
                layer.effect: DropShadow {
                    horizontalOffset: 1 * virtualstudio.uiScale
                    verticalOffset: 1 * virtualstudio.uiScale
                    radius: 8.0 * virtualstudio.uiScale
                    samples: 17
                    color: saveButtonShadow
                }
            }
            onClicked: {
                if (permissions.micPermission == "unknown") {
                    virtualstudio.showWarnings = currShowWarnings; warningScreen = "microphone"
                } else {
                    virtualstudio.showWarnings = currShowWarnings; warningScreen = "acknowledged"
                }
            }
            anchors.right: parent.right
            anchors.rightMargin: 16 * virtualstudio.uiScale
            anchors.bottomMargin: 16 * virtualstudio.uiScale
            anchors.bottom: parent.bottom
            width: 150 * virtualstudio.uiScale; height: 30 * virtualstudio.uiScale
            Text {
                text: "OK"
                font.family: "Poppins"
                font.pixelSize: 11 * virtualstudio.fontScale * virtualstudio.uiScale
                font.weight: Font.Bold
                color: saveButtonText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        CheckBox {
            id: showHeadphonesWarningCheckbox
            checked: currShowWarnings
            text: qsTr("Show warnings again next time")
            anchors.right: okButtonHeadphones.left
            anchors.rightMargin: 16 * virtualstudio.uiScale
            anchors.verticalCenter: okButtonHeadphones.verticalCenter
            onClicked: { currShowWarnings = showHeadphonesWarningCheckbox.checkState == Qt.Checked }
            indicator: Rectangle {
                implicitWidth: 16 * virtualstudio.uiScale
                implicitHeight: 16 * virtualstudio.uiScale
                x: showHeadphonesWarningCheckbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3 * virtualstudio.uiScale
                border.color: showHeadphonesWarningCheckbox.down ? checkboxPressedStroke : checkboxStroke

                Rectangle {
                    width: 10 * virtualstudio.uiScale
                    height: 10 * virtualstudio.uiScale
                    x: 3 * virtualstudio.uiScale
                    y: 3 * virtualstudio.uiScale
                    radius: 2 * virtualstudio.uiScale
                    color: showHeadphonesWarningCheckbox.down ? checkboxPressedStroke : checkboxStroke
                    visible: showHeadphonesWarningCheckbox.checked
                }
            }
            contentItem: Text {
                text: showHeadphonesWarningCheckbox.text
                font.family: "Poppins"
                font.pixelSize: 10 * virtualstudio.fontScale * virtualstudio.uiScale
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: showHeadphonesWarningCheckbox.indicator.width + showHeadphonesWarningCheckbox.spacing
                color: textColour
            }
        }
    }

    Item {
        id: requestMicPermissionsItem
        width: parent.width; height: parent.height
        visible: warningScreen == "microphone" && permissions.micPermission == "unknown"

        Image {
            id: microphonePrompt
            source: "Prompt.svg"
            width: 260
            height: 250
            y: 60
            anchors.horizontalCenter: parent.horizontalCenter
            sourceSize: Qt.size(microphonePrompt.width,microphonePrompt.height)
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Image {
            id: micLogo
            source: "logo.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: microphonePrompt.top
            anchors.topMargin: 18 * virtualstudio.uiScale
            width: 32 * virtualstudio.uiScale; height: 59 * virtualstudio.uiScale
            sourceSize: Qt.size(micLogo.width,micLogo.height)
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Colorize {
            anchors.fill: microphonePrompt
            source: microphonePrompt
            hue: 0
            saturation: 0
            lightness: imageLightnessValue
        }

        Button {
            id: showPromptButton
            width: 112 * virtualstudio.uiScale
            height: 30 * virtualstudio.uiScale
            background: Rectangle {
                radius: 6 * virtualstudio.uiScale
                color: showPromptButton.down ? saveButtonPressedColour : saveButtonBackgroundColour
                border.width: 2
                border.color: showPromptButton.down ? saveButtonPressedStroke : saveButtonStroke
                layer.enabled: showPromptButton.hovered && !showPromptButton.down
                layer.effect: DropShadow {
                    horizontalOffset: 1 * virtualstudio.uiScale
                    verticalOffset: 1 * virtualstudio.uiScale
                    radius: 8.0 * virtualstudio.uiScale
                    samples: 17
                    color: saveButtonShadow
                }
            }
            onClicked: { 
                permissions.getMicPermission();
            }
            anchors.right: microphonePrompt.right
            anchors.rightMargin: 13.5 * virtualstudio.uiScale
            anchors.bottomMargin: 17 * virtualstudio.uiScale
            anchors.bottom: microphonePrompt.bottom
            Text {
                text: "OK"
                font.pixelSize: 11 * virtualstudio.fontScale * virtualstudio.uiScale
                font.weight: Font.Bold
                color: saveButtonText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Text {
            id: micPermissionsHeader
            text: "JackTrip needs your sounds!"
            font { family: "Poppins"; weight: Font.Bold; pixelSize: fontMedium * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: microphonePrompt.bottom
            anchors.topMargin: 48 * virtualstudio.uiScale
        }

        Text {
            id: micPermissionsSubheader1
            text: "JackTrip requires permission to use your microphone."
            font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            width: 400
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: micPermissionsHeader.bottom
            anchors.topMargin: 32 * virtualstudio.uiScale
        }

        Text {
            id: micPermissionsSubheader2
            text: "Click ‘OK’ to give JackTrip access to your microphone, instrument, or other audio device."
            font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            width: 400
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: micPermissionsSubheader1.bottom
            anchors.topMargin: 24 * virtualstudio.uiScale
        }
    }

    Item {
        id: noMicItem
        width: parent.width; height: parent.height
        visible: (warningScreen == "acknowledged" || warningScreen == "microphone") && permissions.micPermission == "denied"

        Image {
            id: noMic
            source: "micoff.svg"
            width: 109.27
            height: 170
            y: 60
            anchors.horizontalCenter: parent.horizontalCenter
            sourceSize: Qt.size(noMic.width,noMic.height)
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Colorize {
            anchors.fill: noMic
            source: noMic
            hue: 0
            saturation: 0
            lightness: imageLightnessValue
        }

        Button {
            id: openSettingsButton
            background: Rectangle {
                radius: 6 * virtualstudio.uiScale
                color: openSettingsButton.down ? saveButtonPressedColour : saveButtonBackgroundColour
                border.width: 1
                border.color: openSettingsButton.down ? saveButtonPressedStroke : saveButtonStroke
                layer.enabled: openSettingsButton.hovered && !openSettingsButton.down
                layer.effect: DropShadow {
                    horizontalOffset: 1 * virtualstudio.uiScale
                    verticalOffset: 1 * virtualstudio.uiScale
                    radius: 8.0 * virtualstudio.uiScale
                    samples: 17
                    color: saveButtonShadow
                }
            }
            onClicked: { 
                permissions.openSystemPrivacy();
            }
            anchors.right: parent.right
            anchors.rightMargin: 16 * virtualstudio.uiScale
            anchors.bottomMargin: 16 * virtualstudio.uiScale
            anchors.bottom: parent.bottom
            width: 200 * virtualstudio.uiScale; height: 30 * virtualstudio.uiScale
            Text {
                text: "Open Privacy Settings"
                font.family: "Poppins"
                font.pixelSize: 11 * virtualstudio.fontScale * virtualstudio.uiScale
                font.weight: Font.Bold
                color: saveButtonText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Text {
            id: noMicHeader
            text: "JackTrip can't hear you!"
            font { family: "Poppins"; weight: Font.Bold; pixelSize: fontMedium * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: noMic.bottom
            anchors.topMargin: 48 * virtualstudio.uiScale
        }

        Text {
            id: noMicSubheader1
            text: "JackTrip requires permission to use your microphone."
            font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            width: 400
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: noMicHeader.bottom
            anchors.topMargin: 32 * virtualstudio.uiScale
        }

        Text {
            id: noMicSubheader2
            text: "Click 'Open Privacy Settings' to give JackTrip permission to access your microphone, instrument, or other audio device."
            font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
            width: 400
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: noMicSubheader1.bottom
            anchors.topMargin: 24 * virtualstudio.uiScale
        }
    }

    Item {
        id: setupItem
        width: parent.width; height: parent.height
        visible: (warningScreen == "acknowledged" || warningScreen == "microphone") && permissions.micPermission == "granted"

        property bool isUsingJack: virtualstudio.audioBackend == "JACK"
        property bool isUsingRtAudio: virtualstudio.audioBackend == "RtAudio"
        property bool hasNoBackend: !isUsingJack && !isUsingRtAudio && !virtualstudio.backendAvailable;

        Text {
            id: pageTitle
            x: 16 * virtualstudio.uiScale; y: 32 * virtualstudio.uiScale
            text: "Choose your audio devices"
            font { family: "Poppins"; weight: Font.Bold; pixelSize: fontBig * virtualstudio.fontScale * virtualstudio.uiScale }
            color: textColour
        }

        Button {
            id: refreshButton
            text: "Refresh Devices"
            palette.buttonText: textColour
            background: Rectangle {
                radius: 6 * virtualstudio.uiScale
                color: refreshButton.down ? buttonPressedColour : (refreshButton.hovered ? buttonHoverColour : buttonColour)
                border.width: 1
                border.color: refreshButton.down ? buttonPressedStroke : (refreshButton.hovered ? buttonHoverStroke : buttonStroke)
            }
            icon {
                source: "refresh.svg";
                color: textColour;
            }
            display: AbstractButton.TextBesideIcon
            onClicked: { virtualstudio.refreshDevices() }
            anchors.right: parent.right
            anchors.rightMargin: rightMargin * virtualstudio.uiScale
            anchors.verticalCenter: pageTitle.verticalCenter
            width: 144 * virtualstudio.uiScale; height: 30 * virtualstudio.uiScale
            font {
                family: "Poppins"
                pixelSize: fontExtraSmall * virtualstudio.fontScale * virtualstudio.uiScale
            }
            visible: parent.isUsingRtAudio
        }

        Item {
            id: noBackend
            x: leftMargin * virtualstudio.uiScale
            width: parent.width - leftMargin * virtualstudio.uiScale
            anchors.top: pageTitle.bottom
            anchors.topMargin: 32 * virtualstudio.uiScale
            visible: parent.hasNoBackend

            Text {
                id: noBackendLabel
                x: 0; y: 0
                width: parent.width - (16 * virtualstudio.uiScale)
                text: "JackTrip has been compiled without an audio backend. Please rebuild with the rtaudio flag or without the nojack flag."
                font { family: "Poppins"; pixelSize: fontMedium * virtualstudio.fontScale * virtualstudio.uiScale }
                wrapMode: Text.WordWrap
                color: textColour
            }
        }

        Item {
            id: usingJack
            x: leftMargin * virtualstudio.uiScale
            width: parent.width - leftMargin * virtualstudio.uiScale
            anchors.top: pageTitle.bottom
            anchors.topMargin: 32 * virtualstudio.uiScale
            visible: parent.isUsingJack

            Text {
                id: jackLabel
                x: 0; y: 0
                width: parent.width - rightMargin * virtualstudio.uiScale
                text: "Using JACK for audio input and output. Use QjackCtl to adjust your sample rate, buffer, and device settings."
                font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
                wrapMode: Text.WordWrap
                color: textColour
            }

            Text {
                id: jackOutputLabel
                anchors.left: jackLabel.left
                anchors.top: jackLabel.bottom
                anchors.topMargin: 48 * virtualstudio.uiScale
                width: 144 * virtualstudio.uiScale
                text: "Output Volume"
                font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
                wrapMode: Text.WordWrap
                color: textColour
            }

            Image {
                id: jackHeadphonesIcon
                anchors.left: jackOutputLabel.left
                anchors.verticalCenter: jackOutputVolumeSlider.verticalCenter
                source: "headphones.svg"
                sourceSize: Qt.size(20 * virtualstudio.uiScale, 20 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            Meter {
                id: jackOutputMeters
                anchors.left: jackOutputLabel.right
                anchors.right: parent.right
                anchors.rightMargin: rightMargin * virtualstudio.uiScale
                anchors.verticalCenter: jackOutputLabel.verticalCenter
                height: 24 * virtualstudio.uiScale
                model: outputMeterModel
                clipped: outputClipped
                enabled: !Boolean(virtualstudio.devicesError)
            }

            Button {
                id: jackTestOutputAudioButton
                background: Rectangle {
                    radius: 6 * virtualstudio.uiScale
                    color: testOutputAudioButton.down ? buttonPressedColour : (testOutputAudioButton.hovered ? buttonHoverColour : buttonColour)
                    border.width: 1
                    border.color: testOutputAudioButton.down ? buttonPressedStroke : (testOutputAudioButton.hovered ? buttonHoverStroke : buttonStroke)
                }
                onClicked: { virtualstudio.playOutputAudio() }
                anchors.right: parent.right
                anchors.rightMargin: rightMargin * virtualstudio.uiScale
                anchors.verticalCenter: jackOutputVolumeSlider.verticalCenter
                width: 144 * virtualstudio.uiScale; height: 30 * virtualstudio.uiScale
                Text {
                    text: "Play Test Tone"
                    font { family: "Poppins"; pixelSize: fontExtraSmall * virtualstudio.fontScale * virtualstudio.uiScale }
                    anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
                    color: textColour
                }
            }

            Slider {
                id: jackOutputVolumeSlider
                from: 0.0
                value: audioInterface ? audioInterface.outputVolume : 0.5
                onMoved: { audioInterface.outputVolume = value }
                to: 1.0
                padding: 0
                anchors.left: jackOutputQuieterButton.right
                anchors.leftMargin: 8 * virtualstudio.uiScale
                anchors.right: jackOutputLouderIcon.left
                anchors.rightMargin: 8 * virtualstudio.uiScale
                anchors.top: jackOutputMeters.bottom
                anchors.topMargin: 16 * virtualstudio.uiScale
                handle: Rectangle {
                    x: jackOutputVolumeSlider.leftPadding + jackOutputVolumeSlider.visualPosition * (jackOutputVolumeSlider.availableWidth - width)
                    y: jackOutputVolumeSlider.topPadding + jackOutputVolumeSlider.availableHeight / 2 - height / 2
                    implicitWidth: 26 * virtualstudio.uiScale
                    implicitHeight: 26 * virtualstudio.uiScale
                    radius: 13 * virtualstudio.uiScale
                    color: jackOutputVolumeSlider.pressed ? sliderPressedColour : sliderColour
                    border.color: buttonStroke
                }
            }

            Image {
                id: jackOutputQuieterButton
                anchors.left: jackOutputMeters.left
                anchors.verticalCenter: jackOutputVolumeSlider.verticalCenter
                source: "quiet.svg"
                sourceSize: Qt.size(16 * virtualstudio.uiScale, 16 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            Image {
                id: jackOutputLouderIcon
                anchors.right: jackTestOutputAudioButton.left
                anchors.rightMargin: rightMargin * virtualstudio.uiScale
                anchors.verticalCenter: jackOutputVolumeSlider.verticalCenter
                source: "loud.svg"
                sourceSize: Qt.size(16 * virtualstudio.uiScale, 16 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            Text {
                id: jackInputLabel
                anchors.left: jackLabel.left
                anchors.top: jackOutputVolumeSlider.bottom
                anchors.topMargin: 48 * virtualstudio.uiScale
                width: 144 * virtualstudio.uiScale
                text: "Input Volume"
                font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
                wrapMode: Text.WordWrap
                color: textColour
            }

            Image {
                id: jackMicrophoneIcon
                anchors.left: jackInputLabel.left
                anchors.verticalCenter: jackInputVolumeSlider.verticalCenter
                source: "mic.svg"
                sourceSize: Qt.size(20 * virtualstudio.uiScale, 20 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            Meter {
                id: jackInputMeters
                anchors.left: jackInputLabel.right
                anchors.right: parent.right
                anchors.rightMargin: rightMargin * virtualstudio.uiScale
                anchors.verticalCenter: jackInputLabel.verticalCenter
                height: 24 * virtualstudio.uiScale
                model: inputMeterModel
                clipped: inputClipped
                enabled: !Boolean(virtualstudio.devicesError)
            }

            Slider {
                id: jackInputVolumeSlider
                from: 0.0
                value: audioInterface ? audioInterface.inputVolume : 0.5
                onMoved: { audioInterface.inputVolume = value }
                to: 1.0
                padding: 0
                anchors.left: jackInputQuieterButton.right
                anchors.leftMargin: 8 * virtualstudio.uiScale
                anchors.right: jackInputLouderIcon.left
                anchors.rightMargin: 8 * virtualstudio.uiScale
                anchors.top: jackInputMeters.bottom
                anchors.topMargin: 16 * virtualstudio.uiScale
                handle: Rectangle {
                    x: jackInputVolumeSlider.leftPadding + jackInputVolumeSlider.visualPosition * (jackInputVolumeSlider.availableWidth - width)
                    y: jackInputVolumeSlider.topPadding + jackInputVolumeSlider.availableHeight / 2 - height / 2
                    implicitWidth: 26 * virtualstudio.uiScale
                    implicitHeight: 26 * virtualstudio.uiScale
                    radius: 13 * virtualstudio.uiScale
                    color: jackInputVolumeSlider.pressed ? sliderPressedColour : sliderColour
                    border.color: buttonStroke
                }
            }

            Image {
                id: jackInputQuieterButton
                anchors.left: jackInputMeters.left
                anchors.verticalCenter: jackInputVolumeSlider.verticalCenter
                source: "quiet.svg"
                sourceSize: Qt.size(16 * virtualstudio.uiScale, 16 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            Image {
                id: jackInputLouderIcon
                anchors.right: jackHiddenInputButton.left
                anchors.rightMargin: rightMargin * virtualstudio.uiScale
                anchors.verticalCenter: jackInputVolumeSlider.verticalCenter
                source: "loud.svg"
                sourceSize: Qt.size(16 * virtualstudio.uiScale, 16 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            Button {
                id: jackHiddenInputButton
                anchors.right: parent.right
                anchors.rightMargin: rightMargin * virtualstudio.uiScale
                anchors.verticalCenter: jackInputVolumeSlider.verticalCenter
                width: 144 * virtualstudio.uiScale; height: 30 * virtualstudio.uiScale
                visible: false
            }
        }

        Item {
            id: usingRtAudio
            x: leftMargin * virtualstudio.uiScale
            width: parent.width - leftMargin * virtualstudio.uiScale
            anchors.top: pageTitle.bottom
            anchors.topMargin: 32 * virtualstudio.uiScale
            visible: parent.isUsingRtAudio

            Text {
                id: outputLabel
                x: 0; y: 0
                width: 144 * virtualstudio.uiScale
                text: "Output Device"
                font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
                color: textColour
            }

            Image {
                id: headphonesIcon
                anchors.left: outputLabel.left
                anchors.verticalCenter: outputDeviceMeters.verticalCenter
                source: "headphones.svg"
                sourceSize: Qt.size(20 * virtualstudio.uiScale, 20 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            ComboBox {
                id: outputCombo
                anchors.left: outputLabel.right
                anchors.verticalCenter: outputLabel.verticalCenter
                anchors.rightMargin: rightMargin * virtualstudio.uiScale
                width: parent.width - outputLabel.width - rightMargin * virtualstudio.uiScale
                model: outputComboModel
                currentIndex: (() => {
                    let count = 0;
                    for (let i = 0; i < outputCombo.model.length; i++) {
                        if (outputCombo.model[i].type === "element") {
                            count++;
                        }

                        if (count > virtualstudio.outputDevice) {
                            return i;
                        }
                    }

                    return 0;
                })()
                delegate: ItemDelegate {
                    required property var modelData
                    required property int index

                    leftPadding: 0

                    width: parent.width
                    contentItem: Text {
                        leftPadding: modelData.type === "element" && outputCombo.model.filter(it => it.type === "header").length > 0 ? 24 : 12
                        text: modelData.text
                        font.bold: modelData.type === "header"
                    }
                    highlighted: outputCombo.highlightedIndex === index
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (modelData.type == "element") {
                                outputCombo.currentIndex = index
                                outputCombo.popup.close()
                                virtualstudio.outputDevice = index - outputCombo.model.filter((elem, idx) => idx < index && elem.type === "header").length
                            }
                        }
                    }
                }
                contentItem: Text {
                    leftPadding: 12
                    font: outputCombo.font
                    horizontalAlignment: Text.AlignHLeft
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    text: outputCombo.model[outputCombo.currentIndex].text ? outputCombo.model[outputCombo.currentIndex].text : ""
                }
            }

            Meter {
                id: outputDeviceMeters
                anchors.left: outputCombo.left
                anchors.right: outputCombo.right
                anchors.top: outputCombo.bottom
                anchors.topMargin: 16 * virtualstudio.uiScale
                height: 24 * virtualstudio.uiScale
                model: outputMeterModel
                clipped: outputClipped
                enabled: !Boolean(virtualstudio.devicesError)
            }

            Slider {
                id: outputSlider
                from: 0.0
                value: audioInterface ? audioInterface.outputVolume : 0.5
                onMoved: { audioInterface.outputVolume = value }
                to: 1.0
                padding: 0
                anchors.left: outputQuieterIcon.right
                anchors.leftMargin: 8 * virtualstudio.uiScale
                anchors.right: outputLouderIcon.left
                anchors.rightMargin: 8 * virtualstudio.uiScale
                anchors.top: outputDeviceMeters.bottom
                anchors.topMargin: 16 * virtualstudio.uiScale
                handle: Rectangle {
                    x: outputSlider.leftPadding + outputSlider.visualPosition * (outputSlider.availableWidth - width)
                    y: outputSlider.topPadding + outputSlider.availableHeight / 2 - height / 2
                    implicitWidth: 26 * virtualstudio.uiScale
                    implicitHeight: 26 * virtualstudio.uiScale
                    radius: 13 * virtualstudio.uiScale
                    color: outputSlider.pressed ? sliderPressedColour : sliderColour
                    border.color: buttonStroke
                }
            }

            Image {
                id: outputQuieterIcon
                anchors.left: outputCombo.left
                anchors.verticalCenter: outputSlider.verticalCenter
                source: "quiet.svg"
                sourceSize: Qt.size(16 * virtualstudio.uiScale, 16 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            Image {
                id: outputLouderIcon
                anchors.right: testOutputAudioButton.left
                anchors.rightMargin: 16 * virtualstudio.uiScale
                anchors.verticalCenter: outputSlider.verticalCenter
                source: "loud.svg"
                sourceSize: Qt.size(16 * virtualstudio.uiScale, 16 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            Button {
                id: testOutputAudioButton
                background: Rectangle {
                    radius: 6 * virtualstudio.uiScale
                    color: testOutputAudioButton.down ? buttonPressedColour : (testOutputAudioButton.hovered ? buttonHoverColour : buttonColour)
                    border.width: 1
                    border.color: testOutputAudioButton.down ? buttonPressedStroke : (testOutputAudioButton.hovered ? buttonHoverStroke : buttonStroke)
                }
                onClicked: { virtualstudio.playOutputAudio() }
                anchors.right: parent.right
                anchors.rightMargin: rightMargin * virtualstudio.uiScale
                anchors.verticalCenter: outputSlider.verticalCenter
                width: 144 * virtualstudio.uiScale; height: 30 * virtualstudio.uiScale
                Text {
                    text: "Play Test Tone"
                    font { family: "Poppins"; pixelSize: fontExtraSmall * virtualstudio.fontScale * virtualstudio.uiScale }
                    anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
                    color: textColour
                }
            }

            Rectangle {
                id: divider1
                anchors.top: testOutputAudioButton.bottom
                anchors.topMargin: 24 * virtualstudio.uiScale
                width: parent.width - x - (16 * virtualstudio.uiScale); height: 2 * virtualstudio.uiScale
                color: "#E0E0E0"
            }

            Text {
                id: inputLabel
                anchors.left: outputLabel.left
                anchors.right: outputLabel.right
                anchors.top: divider1.bottom
                anchors.topMargin: 32 * virtualstudio.uiScale
                text: "Input Device"
                font { family: "Poppins"; pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale }
                color: textColour
            }

            Image {
                id: microphoneIcon
                anchors.left: outputLabel.left
                anchors.verticalCenter: inputDeviceMeters.verticalCenter
                source: "mic.svg"
                sourceSize: Qt.size(20 * virtualstudio.uiScale, 20 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            ComboBox {
                id: inputCombo
                model: inputComboModel
                currentIndex: (() => {
                    let count = 0;
                    for (let i = 0; i < inputCombo.model.length; i++) {
                        if (inputCombo.model[i].type === "element") {
                            count++;
                        }

                        if (count > virtualstudio.inputDevice) {
                            return i;
                        }
                    }

                    return 0;
                })()
                anchors.left: outputCombo.left
                anchors.right: outputCombo.right
                anchors.verticalCenter: inputLabel.verticalCenter
                delegate: ItemDelegate {
                    required property var modelData
                    required property int index

                    leftPadding: 0

                    width: parent.width
                    contentItem: Text {
                        leftPadding: modelData.type === "element" && inputCombo.model.filter(it => it.type === "header").length > 0 ? 24 : 12
                        text: modelData.text
                        font.bold: modelData.type === "header"
                    }
                    highlighted: inputCombo.highlightedIndex === index
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (modelData.type == "element") {
                                inputCombo.currentIndex = index
                                inputCombo.popup.close()
                                virtualstudio.inputDevice = index - inputCombo.model.filter((elem, idx) => idx < index && elem.type === "header").length
                            }
                        }
                    }
                }
                contentItem: Text {
                    leftPadding: 12
                    font: inputCombo.font
                    horizontalAlignment: Text.AlignHLeft
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    text: inputCombo.model[inputCombo.currentIndex].text ? inputCombo.model[inputCombo.currentIndex].text : ""
                }
            }

            Meter {
                id: inputDeviceMeters
                anchors.left: inputCombo.left
                anchors.right: inputCombo.right
                anchors.top: inputCombo.bottom
                anchors.topMargin: 16 * virtualstudio.uiScale
                height: 24 * virtualstudio.uiScale
                model: inputMeterModel
                clipped: inputClipped
                enabled: !Boolean(virtualstudio.devicesError)
            }

            Slider {
                id: inputSlider
                from: 0.0
                value: audioInterface ? audioInterface.inputVolume : 0.5
                onMoved: { audioInterface.inputVolume = value }
                to: 1.0
                padding: 0
                anchors.left: inputQuieterIcon.right
                anchors.leftMargin: 8 * virtualstudio.uiScale
                anchors.right: inputLouderIcon.left
                anchors.rightMargin: 8 * virtualstudio.uiScale
                anchors.top: inputDeviceMeters.bottom
                anchors.topMargin: 16 * virtualstudio.uiScale
                handle: Rectangle {
                    x: inputSlider.leftPadding + inputSlider.visualPosition * (inputSlider.availableWidth - width)
                    y: inputSlider.topPadding + inputSlider.availableHeight / 2 - height / 2
                    implicitWidth: 26 * virtualstudio.uiScale
                    implicitHeight: 26 * virtualstudio.uiScale
                    radius: 13 * virtualstudio.uiScale
                    color: inputSlider.pressed ? sliderPressedColour : sliderColour
                    border.color: buttonStroke
                }
            }

            Image {
                id: inputQuieterIcon
                anchors.left: inputDeviceMeters.left
                anchors.verticalCenter: inputSlider.verticalCenter
                source: "quiet.svg"
                sourceSize: Qt.size(16 * virtualstudio.uiScale, 16 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            Image {
                id: inputLouderIcon
                anchors.right: hiddenInputButton.left
                anchors.rightMargin: rightMargin * virtualstudio.uiScale
                anchors.verticalCenter: inputSlider.verticalCenter
                source: "loud.svg"
                sourceSize: Qt.size(16 * virtualstudio.uiScale, 16 * virtualstudio.uiScale)
                fillMode: Image.PreserveAspectFit
                smooth: true

                Colorize {
                    anchors.fill: parent
                    source: parent
                    hue: 0
                    saturation: 0
                    lightness: virtualstudio.darkMode ? 1 : 0
                }
            }

            Button {
                id: hiddenInputButton
                anchors.right: parent.right
                anchors.rightMargin: rightMargin * virtualstudio.uiScale
                anchors.verticalCenter: inputSlider.verticalCenter
                width: 144 * virtualstudio.uiScale; height: 30 * virtualstudio.uiScale
                visible: false
            }

            Text {
                anchors.left: inputLabel.left
                anchors.right: parent.right
                anchors.rightMargin: 16 * virtualstudio.uiScale
                anchors.top: inputSlider.bottom
                anchors.bottomMargin: 24 * virtualstudio.uiScale
                textFormat: Text.RichText
                text: (virtualstudio.devicesError || virtualstudio.devicesWarning)
                    + ((virtualstudio.devicesErrorHelpUrl || virtualstudio.devicesWarningHelpUrl)
                        ? `&nbsp;<a style="color: ${linkText};" href=${virtualstudio.devicesErrorHelpUrl || virtualstudio.devicesWarningHelpUrl}>Learn More.</a>`
                        : ""
                    )
                onLinkActivated: link => {
                    virtualstudio.openLink(link)
                }
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                color: warningText
                font { family: "Poppins"; pixelSize: fontExtraSmall * virtualstudio.fontScale * virtualstudio.uiScale }
                visible: Boolean(virtualstudio.devicesError) || Boolean(virtualstudio.devicesWarning);
            }
        }

        Button {
            id: saveButton
            background: Rectangle {
                radius: 6 * virtualstudio.uiScale
                color: saveButton.down ? saveButtonPressedColour : saveButtonBackgroundColour
                border.width: 1
                border.color: saveButton.down ? saveButtonPressedStroke : saveButtonStroke
                layer.enabled: saveButton.hovered && !saveButton.down
                layer.effect: DropShadow {
                    horizontalOffset: 1 * virtualstudio.uiScale
                    verticalOffset: 1 * virtualstudio.uiScale
                    radius: 8.0 * virtualstudio.uiScale
                    samples: 17
                    color: saveButtonShadow
                }
            }
            enabled: !Boolean(virtualstudio.devicesError) && virtualstudio.backendAvailable
            onClicked: { virtualstudio.windowState = "browse"; virtualstudio.applySettings() }
            anchors.right: parent.right
            anchors.rightMargin: rightMargin * virtualstudio.uiScale
            anchors.bottomMargin: rightMargin * virtualstudio.uiScale
            anchors.bottom: parent.bottom
            width: 150 * virtualstudio.uiScale; height: 30 * virtualstudio.uiScale
            Text {
                text: "Save Settings"
                font.family: "Poppins"
                font.pixelSize: fontSmall * virtualstudio.fontScale * virtualstudio.uiScale
                font.weight: Font.Bold
                color: !Boolean(virtualstudio.devicesError) && virtualstudio.backendAvailable ? saveButtonText : disabledButtonText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        CheckBox {
            id: showAgainCheckbox
            checked: virtualstudio.showDeviceSetup
            visible: virtualstudio.backendAvailable
            text: qsTr("Ask again next time")
            anchors.right: saveButton.left
            anchors.rightMargin: 16 * virtualstudio.uiScale
            anchors.verticalCenter: saveButton.verticalCenter
            onClicked: { virtualstudio.showDeviceSetup = showAgainCheckbox.checkState == Qt.Checked }
            indicator: Rectangle {
                implicitWidth: 16 * virtualstudio.uiScale
                implicitHeight: 16 * virtualstudio.uiScale
                x: showAgainCheckbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3 * virtualstudio.uiScale
                border.color: showAgainCheckbox.down ? checkboxPressedStroke : checkboxStroke

                Rectangle {
                    width: 10 * virtualstudio.uiScale
                    height: 10 * virtualstudio.uiScale
                    x: 3 * virtualstudio.uiScale
                    y: 3 * virtualstudio.uiScale
                    radius: 2 * virtualstudio.uiScale
                    color: showAgainCheckbox.down ? checkboxPressedStroke : checkboxStroke
                    visible: showAgainCheckbox.checked
                }
            }

            contentItem: Text {
                text: showAgainCheckbox.text
                font.family: "Poppins"
                font.pixelSize: 10 * virtualstudio.fontScale * virtualstudio.uiScale
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: showAgainCheckbox.indicator.width + showAgainCheckbox.spacing
                color: textColour
            }
        }
    }
}
