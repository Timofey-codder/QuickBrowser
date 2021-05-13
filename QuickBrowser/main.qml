import QtQml 2.2
import QtQuick 2.3
import QtQuick.Window 2.1
import QtQuick.Controls 2.15 as N
import QtQuick.Controls 1.4 as O
import QtQuick.Controls.Material 2.12
import QtWebView 1.14
import QtWebEngine 1.10
import Qt.labs.qmlmodels 1.0
import QtWebSockets 1.1
import QtWebEngine.Controls1Delegates 1.0
import QtQuick.Controls.Styles 1.0

N.ApplicationWindow {
    id: applicationWindow
    width: 750
    height: 500
    visible: true

    property Item currentWebView: tabs.currentIndex < tabs.count ? tabs.getTab(tabs.currentIndex).item : null

    N.Switch {
        id: switch1
        width: 98
        height: 40
        visible: false
        text: "Filter"
        anchors.left: button_new.right
        anchors.top: parent.top
        clip: false
        font.underline: false
        font.italic: false
        font.bold: true
        display: AbstractButton.TextBesideIcon
        anchors.leftMargin: 10
        anchors.topMargin: 0
        layer.textureMirroring: ShaderEffectSource.MirrorVertically
        layer.mipmap: false
        transformOrigin: Item.Center
        focusPolicy: Qt.StrongFocus

        Material.theme: Material.Light
        Material.accent: Material.DeepPurple
    }


    N.TextField {
        id: textField
        visible: false
        anchors.left: switch1.right
        height: 40
        anchors.right: button_find.left
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 0
        placeholderText: qsTr(currentWebView.url.toLocaleString())

        Material.theme: Material.Light
        Material.accent: Material.DeepPurple
    }


    N.Button {
        id: button_user
        visible: false
        x: 682
        width: 68
        height: 40
        text: qsTr("I'am")
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.rightMargin: 10

        Material.theme: Material.Light
        Material.accent: Material.DeepPurple

        onClicked: {
            tabs.visible = false
            item_back.visible = true
            button_user.visible = false
            button_find.visible = false
            textField.visible = false
            switch1.visible = false
            progressBar.visible = false
            button_prev.visible = false
            button_new.visible = false
        }
    }


    N.Button {
        id: button_find
        visible: false
        x: 608
        width: 68
        height: 40
        text: qsTr("Find")
        anchors.right: button_user.left
        anchors.top: parent.top
        anchors.rightMargin: 10
        anchors.topMargin: 0

        Material.theme: Material.Light
        Material.accent: Material.DeepPurple

        onClicked: {
            currentWebView.url = textField.text

            currentWebView.check = false
        }
    }


    Item {
        id: item_aut
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 100
        anchors.leftMargin: 100
        anchors.bottomMargin: 50
        anchors.topMargin: 50

        Material.theme: Material.Dark
        Material.accent: Material.Grey

        Text {
            id: text1
            height: 56
            color: "#ffffff"
            text: qsTr("Authentication")
            elide: Text.ElideNone
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            font.pixelSize: 28
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.NoWrap
            anchors.rightMargin: 30
            anchors.leftMargin: 30
            anchors.topMargin: 20
            font.styleName: "Полужирный"
            font.weight: Font.ExtraBold
            font.capitalization: Font.AllUppercase
            font.underline: true
            font.bold: true
            minimumPointSize: 28
            minimumPixelSize: 28
            fontSizeMode: Text.Fit
        }

        Text {
            id: text2
            width: 132
            height: 50
            color: "#ffffff"
            text: qsTr("Your Name:")
            anchors.left: parent.left
            anchors.top: text1.bottom
            font.pixelSize: 20
            anchors.topMargin: 30
            anchors.leftMargin: 30
        }

        Text {
            id: text3
            width: 132
            height: 50
            color: "#ffffff"
            text: qsTr("Your Password:")
            anchors.left: parent.left
            anchors.top: text2.bottom
            font.pixelSize: 20
            anchors.topMargin: 30
            anchors.leftMargin: 30
        }

        N.TextField {
            id: textField1
            height: 50
            anchors.left: text2.right
            anchors.right: parent.right
            anchors.top: text1.bottom
            horizontalAlignment: Text.AlignHCenter
            font.italic: false
            font.pointSize: 18
            placeholderText: "Krasnov Timofey"
            renderType: Text.QtRendering
            anchors.topMargin: 30
            anchors.rightMargin: 30
            anchors.leftMargin: 36
        }

        N.TextField {
            id: textField2
            height: 50
            anchors.left: text3.right
            anchors.right: parent.right
            anchors.top: textField1.bottom
            horizontalAlignment: Text.AlignHCenter
            placeholderText: "228322"
            font.italic: true
            font.pointSize: 18
            anchors.leftMargin: 36
            anchors.rightMargin: 30
            anchors.topMargin: 30
        }

        N.Button {
            id: button
            x: 219
            y: 350
            width: 120
            height: 48
            text: qsTr("Enter")
            font.weight: Font.Bold
            anchors.horizontalCenter: parent.horizontalCenter
            flat: false

            onClicked: {
                if (button_reg.visible == true)
                {
                    if (database.databasecheck(textField1.text, textField2.text) === true)
                    {
                        if (tabs.count == 0)
                            tabs.addTab("Яндекс",tabComponent)
                        else
                            currentWebView.url = "https://yandex.ru"

                        item_aut.visible = false
                        tabs.visible = true
                        button_user.visible = true
                        button_find.visible = true
                        textField.visible = true
                        switch1.visible = true
                        progressBar.visible = true
                        button_prev.visible = true
                        button_new.visible = true

                        text_warning.text = ""
                        textField1.text = ""
                        textField2.text = ""
                        textField3.text = ""


                        text4.text = qsTr("Your name:   " + database.setname())
                        text5.text = qsTr("Your age:    " + database.setage())
                    }
                    else
                    {
                        text_warning.text = "Invalid authentication!"
                    }
                }
                else
                {
                    if (database.registration(textField1.text, textField2.text, textField3.text) === true)
                    {
                        if (tabs.count == 0)
                            tabs.addTab("Яндекс",tabComponent)
                        else
                            currentWebView.url = "https://yandex.ru"

                        item_aut.visible = false
                        tabs.visible = true
                        button_user.visible = true
                        button_find.visible = true
                        textField.visible = true
                        switch1.visible = true
                        progressBar.visible = true
                        button_prev.visible = true
                        button_new.visible = true

                        text1.text = "authentication"
                        text_warning.text = ""
                        textField1.text = ""
                        textField2.text = ""
                        textField3.text = ""


                        text4.text = qsTr("Your name:   " + database.setname())
                        text5.text = qsTr("Your age:    " + database.setage())
                    }
                    else
                    {
                        text_warning.text = "Invalid registration!"
                    }

                }
            }
        }

        Text {
            id: text_warning
            x: 164
            width: 223
            height: 25
            color: "#f60000"
            text: qsTr("")
            anchors.top: button.bottom
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20
            font.italic: true
            font.bold: true
        }

        N.Button {
            id: button_reg
            x: 0
            y: 350
            width: 120
            height: 48
            text: qsTr("registration")
            anchors.horizontalCenterOffset: -180
            anchors.horizontalCenter: parent.horizontalCenter
            transformOrigin: Item.Center

            onClicked: {
                text1.text = "registration"
                button_reg.visible = false
                text_warning.text = ""
                textField1.text = ""
                textField2.text = ""
                text6.visible = true
                textField3.visible = true
            }
        }

        Text {
            id: text6
            visible: false
            width: 132
            height: 50
            color: "#fdfdfd"
            text: qsTr("Your age:")
            anchors.left: parent.left
            anchors.top: text3.bottom
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            anchors.topMargin: 30
            anchors.leftMargin: 30
        }

        N.TextField {
            id: textField3
            visible: false
            height: 50
            anchors.left: text6.right
            anchors.right: parent.right
            anchors.top: textField2.bottom
            horizontalAlignment: Text.AlignHCenter
            font.italic: true
            font.pointSize: 18
            anchors.rightMargin: 30
            anchors.leftMargin: 36
            anchors.topMargin: 30
            placeholderText: qsTr("19")
        }


    }



    Item {
        visible: false
        id: item_back
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 100
        anchors.leftMargin: 100
        anchors.bottomMargin: 50
        anchors.topMargin: 50

        Text {
            id: text4
            x: 72
            width: 406
            height: 40
            color: "#fbfbfb"
            text: qsTr("")
            anchors.top: parent.top
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.underline: false
            font.italic: true
            font.bold: true
            anchors.topMargin: 50
        }

        Text {
            id: text5
            x: 202
            width: 148
            height: 40
            color: "#fdfdfd"
            text: qsTr("")
            anchors.top: text4.bottom
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.italic: true
            font.bold: true
            anchors.topMargin: 20
        }

        N.Button {
            id: button1
            x: 72
            y: 281
            width: 125
            height: 48
            text: qsTr("Change user")
            anchors.horizontalCenterOffset: -150
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true

            onClicked: {
                item_back.visible = false
                item_aut.visible = true
                text6.visible = false
                textField3.visible = false

                text4.text = qsTr("")
                text5.text = qsTr("")

                button_reg.visible = true

                while (tabs.count > 1)
                {
                    tabs.removeView(tabs.currentIndex);
                }
            }
        }

        N.Button {
            id: button2
            x: 353
            y: 281
            width: 125
            height: 48
            text: qsTr("Back to page")
            anchors.horizontalCenterOffset: 150
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true

            onClicked: {
                item_back.visible = false
                button_user.visible = true
                tabs.visible = true
                button_find.visible = true
                textField.visible = true
                switch1.visible = true
                progressBar.visible = true
                button_prev.visible = true
                button_new.visible = true
            }
        }
    }


    N.ProgressBar {
        id: progressBar
        visible: false
        height: 11
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: textField.bottom
        font.pointSize: 20
        anchors.rightMargin: 166
        anchors.leftMargin: 175
        anchors.topMargin: 0
        value: (currentWebView && currentWebView.loadProgress < 100) ? currentWebView.loadProgress : 0

        Material.theme: Material.Light
        Material.accent: Material.DeepPurple
    }


    N.Button {
        id: button_prev
        width: 50
        height: 40
        visible: false
        text: "back"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.topMargin: 0
        clip: false
        display: AbstractButton.TextBesideIcon

        Material.theme: Material.Light
        Material.accent: Material.DeepPurple

        onClicked: {
            currentWebView.triggerWebAction(WebEngineView.Back)

        }
    }


    O.TabView {
        id: tabs
        visible: false

        function createEmptyTab(profile) {
            var tab = addTab("", tabComponent);
            tab.active = true;
            tab.title = Qt.binding(function() { return tab.item.title ? tab.item.title : 'New Tab' });
            tab.item.profile = profile;
            return tab;
        }

        function removeView(index) {
            if (tabs.count > 1)
                tabs.removeTab(index)
        }

        function indexOfView(view) {
            for (let i = 0; i < tabs.count; ++i)
                if (tabs.getTab(i).item === view)
                    return i
            return -1
        }

        height: 440
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 60
        anchors.bottomMargin: 0

        style: TabViewStyle {
            property color frameColor: "#999"
            property color fillColor: "#eee"
            property color nonSelectedColor: "#ddd"
            frameOverlap: 1
            frame: Rectangle {
                color: "#eee"
                border.color: frameColor
            }
            tab: Rectangle {
                id: tabRectangle
                color: styleData.selected ? fillColor : nonSelectedColor
                border.width: 1
                border.color: frameColor
                implicitWidth: Math.max(text10.width + 30, 80)
                implicitHeight: Math.max(text10.height + 10, 20)
                Rectangle { height: 1 ; width: parent.width ; color: frameColor}
                Rectangle { height: parent.height ; width: 1; color: frameColor}
                Rectangle { x: parent.width - 2; height: parent.height ; width: 1; color: frameColor}
                Text {
                    id: text10
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 6
                    text: styleData.title
                    elide: Text.ElideRight
                    color: styleData.selected ? "black" : frameColor
                }
                O.Button {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 4
                    height: 12
                    style: ButtonStyle {
                        background: Rectangle {
                            implicitWidth: 12
                            implicitHeight: 12
                            color: control.hovered ? "#ccc" : tabRectangle.color
                            Text {text: "x" ; anchors.centerIn: parent ; color: "gray"}
                        }}
                    onClicked: {
                        onClicked: tabs.removeView(styleData.index)
                    }
                }
            }
        }

        Component {
            id: tabComponent
            WebEngineView {
                id: view
                settings.printElementBackgrounds: true
                settings.pluginsEnabled: true
                settings.pdfViewerEnabled: true
                settings.localStorageEnabled: true
                settings.localContentCanAccessFileUrls: true
                settings.localContentCanAccessRemoteUrls: true
                settings.linksIncludedInFocusChain: true
                settings.javascriptEnabled: true
                settings.javascriptCanPaste: true
                settings.javascriptCanOpenWindows: true
                settings.javascriptCanAccessClipboard: true
                settings.hyperlinkAuditingEnabled: true
                settings.fullScreenSupportEnabled: true
                settings.focusOnNavigationEnabled: true
                settings.errorPageEnabled: true
                settings.dnsPrefetchEnabled: true
                settings.autoLoadImages: true
                settings.autoLoadIconsForPage: true
                settings.allowWindowActivationFromJavaScript: true
                settings.allowRunningInsecureContent: true
                settings.allowGeolocationOnInsecureOrigins: true
                settings.accelerated2dCanvasEnabled: true
                activeFocusOnPress: true
                settings.screenCaptureEnabled: true
                settings.showScrollBars: true
                settings.spatialNavigationEnabled: true
                settings.touchIconsEnabled: true
                settings.webGLEnabled: true
                settings.webRTCPublicInterfacesOnly: false
                url: "http://yandex.ru"

                property var check: false

                onNewViewRequested: function(request) {
                    if (request.destination === WebEngineView.NewViewInTab) {
                        var tab = tabs.createEmptyTab(currentWebView.profile);
                        tabs.currentIndex = tabs.count - 1;
                        request.openIn(tab.item);
                        request.openIn(currentWebView);

                        currentWebView.check = false
                    }
                    else {
                        //var window = applicationRoot.createWindow(currentWebView.profile);
                        request.openIn(currentWebView);

                        currentWebView.check = false
                    }
                }

                onLinkHovered: function(hoveredUrl) {
                    if (hoveredUrl !== "")
                    {
                        textField.text = hoveredUrl;
                    }
                }

                onLoadProgressChanged: {
                    let words = database.words()
                    if (Object.keys(words).length > 0)
                    {
                    words.forEach(function(word) {
                        var S = "var this_el = document.body; var this_block = \"\"; var inner = 1; while (inner > 0) { while (this_el.firstElementChild) { this_el = this_el.firstElementChild; inner = inner + 1; } if (this_el.innerHTML.toLowerCase().includes('" + word + "')) { this_el.innerHTML = \"<img src='https://i.pinimg.com/736x/63/ca/c1/63cac12c2cef47a0b6983d8ebf73ea50.jpg'>\"; } if (this_el.nextElementSibling) { this_el = this_el.nextElementSibling; } else { while (!this_el.nextElementSibling) { this_el = this_el.parentElement; inner = inner - 1; this_block = \"\"; this_el.childNodes.forEach(function(childNode) { if ( childNode.nodeName == '#text') { this_block += childNode.data; } }); if (this_block.toLowerCase().includes('" + word + "')) { this_el.innerHTML = \"<img src='https://i.pinimg.com/736x/63/ca/c1/63cac12c2cef47a0b6983d8ebf73ea50.jpg'>\"; } } this_el = this_el.nextElementSibling; } }";
                        if (currentWebView.loadProgress > 0 && currentWebView.check === false)
                        {
                            currentWebView.runJavaScript(S, WebEngineScript.DocumentCreation)

                        }
                    })
                    }
                }
            }


        }

    }

    N.Button {
        id: button_new
        visible: false
        width: 50
        height: 40
        text: qsTr("new")
        anchors.left: button_prev.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.leftMargin: 10

        Material.theme: Material.Light
        Material.accent: Material.DeepPurple

        onClicked: {
            tabs.createEmptyTab(tabs.count != 0 ? currentWebView.profile : defaultProfile);
            tabs.currentIndex = tabs.count - 1;
        }
    }
}


/*##^##
Designer {
    D{i:1;invisible:true}D{i:2;invisible:true}D{i:3;invisible:true}D{i:4;invisible:true}
D{i:17;invisible:true}D{i:18;invisible:true}D{i:19;invisible:true}D{i:20;invisible:true}
D{i:16;invisible:true}D{i:21;invisible:true}D{i:22;invisible:true}D{i:23;invisible:true}
D{i:37;invisible:true}
}
##^##*/
