import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Window {
    id: app
    width: 1020
    height: 720
    visible: true
    title: qsTr("Responsive App in QML")

    property bool isMobileView: width <= 450
    property bool isTabletView: !isMobileView && width <= 750
    property bool isDesktopView: !isMobileView && !isTabletView

    // Desktop Layout
    RowLayout {
        anchors.fill: parent
        spacing: 1
        visible: isDesktopView

        LayoutItemProxy {
            target: expandedSidebar
            width: 250
            Layout.fillHeight: true
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            LayoutItemProxy {
                target: topNavbar
                height: 60
                Layout.fillWidth: true
            }

            LayoutItemProxy {
                target: mainContent
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    // Tablet Layout
    RowLayout {
        anchors.fill: parent
        spacing: 1
        visible: isTabletView

        LayoutItemProxy {
            target: expandedSidebar
            width: 70 // Minimize the side bar
            Layout.fillHeight: true
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            LayoutItemProxy {
                target: topNavbar
                height: 60
                Layout.fillWidth: true
            }

            LayoutItemProxy {
                target: mainContent
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    // Mobile Layout
    ColumnLayout {
        anchors.fill: parent
        visible: isMobileView

        LayoutItemProxy {
            target: topNavbar
            height: 60
            Layout.fillWidth: true
        }

        LayoutItemProxy {
            target: mainContent
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }


    // ------ RE USABLE COMPONENTS ----- //
    // --------------------------------- //

    Drawer {
        id: drawer
        edge: Qt.LeftEdge
        width: 300
        height: app.height
        interactive: isMobileView

        background: Rectangle {
            color: "#eee"
        }

        contentItem: LayoutItemProxy {
            target: expandedSidebar
            width: 300
            height: drawer.height
        }
    }

    // Application top bar
    Rectangle {
        id: expandedSidebar
        color: "#ddd"
        clip: true

        Column {
            anchors.fill: parent

            //
            Item {
                height: 60
                width: parent.width
            }

            Repeater {
                width: parent.width
                model: 5

                delegate: Row {
                    spacing: 0

                    Item {
                        width: 70
                        height: 50

                        Rectangle {
                            width: 40
                            height: 40
                            radius: 8
                            anchors.centerIn: parent
                        }
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Menu ") + (index+1).toString()
                        font.pixelSize: 14
                        color: "#444"
                    }
                }
            }
        }
    }

    // Application top bar
    Rectangle {
        id: topNavbar
        color: "#ddd"

        Text {
            text: qsTr("Application Name")
            leftPadding: 20
            font.pixelSize: 18
            color: "#444"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // MainContent Area of the application
    Rectangle {
        id: mainContent
        color: "#fff"

        readonly property real minCellWidth: 200

        GridView {
            cellWidth: width / Math.floor(width / parent.minCellWidth)
            cellHeight: cellWidth * 1.4 // 200/100 * cellWidth
            id: gridView
            anchors.fill: parent
            anchors.margins: 8
            model: 30
            clip: true
            delegate: Item {
                width: gridView.cellWidth
                height: gridView.cellHeight

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 4
                    color: "#eee"
                    radius: 8
                }
            }
        }
    }
}
