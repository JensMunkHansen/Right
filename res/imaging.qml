import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 1.4 // TabView is here
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11


Window {
    id: root
    visible: true
    width: 1280
    height: 1024
    ColumnLayout {
        id: colMain
        anchors.fill: parent
        spacing: 2
        Rectangle {
            Layout.fillWidth: true
            height: toolBar.height
            Layout.alignment: Qt.AlignTop
            // If rowlayout, height is idRowLayout.Layout.maximumHeight
            Row {
                id: toolBar
                width: parent.width
                height: Math.max(btnStageAcq.height,
                                btnStageImage.height)
                spacing: 1
                ButtonGroup {
                    id: btnStageGroup
                    exclusive: true
                    onClicked: button.checked = true
                }
                ToolButton {
                    id: btnStageImage
                    text: "Image"
                    ButtonGroup.group: btnStageGroup
                    checked: true
                }
                ToolButton {
                    id: btnStageReg
                    text: "Reg"
                    ButtonGroup.group: btnStageGroup
                }
                ToolButton {
                    id: btnStagePlan
                    text: "Plan"
                    ButtonGroup.group: btnStageGroup
                }
                ToolButton {
                    id: btnStageNav
                    text: "Nav"
                    ButtonGroup.group: btnStageGroup
                }
                ToolButton {
                    id: btnStageAcq
                    text: "Acq"
                    ButtonGroup.group: btnStageGroup
                }
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            RowLayout {
                anchors.fill: parent
                spacing: 0
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignTop
                    TabView {
                        anchors.fill: parent
                        Tab {
                            id: tab1
                            title: "2D Properties"
                            Rectangle {
                                border.color: "black"
                                border.width: 1
                                height: parent.height
                                Text {
                                    text: "Control Panel"
                                    anchors.centerIn: parent
                                }
                            }
                        }
                        Tab {
                            id: tab2
                            title: "3D Properties"
                            Rectangle {
                                border.color: "black"
                                border.width: 1
                                Text {
                                    text: "3D Color and overlay parameters visualized + preset"
                                    anchors.centerIn: parent
                                }
                            }
                        }
                        Tab {
                            title: "Import Meshes"
                            Rectangle {
                                border.color: "black"
                                border.width: 1
                                Text {
                                    text: "Import meshes"
                                    anchors.centerIn: parent
                                }
                            }
                        }
                        Tab {
                            title: "Mesh Properties"
                            Rectangle {
                                border.color: "black"
                                border.width: 1

                                Text {
                                    anchors.centerIn: parent
                                    text: "Mesh properties"

                                }
                            }
                        }

                        //style: tabViewStyle
                    }
                }
                Rectangle {
                    id: rect4D
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                    Layout.fillHeight: true
                    border.color: "black"
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        text: "4D view"
                    }
                    Text {
                        id: txtMR4D
                        anchors.bottom: parent.bottom
                        text: "MR - 3 weeks ago"
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignTop | Qt.AlignRight

                    border.color: "black"
                    border.width: 1                
                    ColumnLayout {
                        spacing: 0
                        anchors.fill: parent
                        Layout.alignment: Qt.AlignTop
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Rectangle {
                            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                            Layout.preferredHeight: 70
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Text {
                                anchors.centerIn: parent
                                text: "2D: Sagittal"
                            }
                            border.color: "black"
                            border.width: 1
                            Text {
                                id: txtMR2DSagittal
                                anchors.bottom: parent.bottom
                                text: "MR - 3 weeks ago"
                            }
                            Text {
                                anchors.bottom: txtMR2DSagittal.top
                                text: "CT - 4 weeks ago"
                            }
                        }
                        Rectangle {
                            Layout.alignment: Qt.AlignMiddle | Qt.AlignHCenter
                            Layout.preferredHeight: 70
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Text {
                                anchors.centerIn: parent
                                text: "2D: Coronal"
                            }
                            border.color: "black"
                            border.width: 1
                            Text {
                                id: txtMR2DCoronal
                                anchors.bottom: parent.bottom
                                text: "MR - 3 weeks ago"
                            }
                            Text {
                                anchors.bottom: txtMR2DCoronal.top
                                text: "CT - 4 weeks ago"
                            }
                        }
                        Rectangle {
                            id: rect2DAxial
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
                            Layout.preferredHeight: 70
                            Layout.preferredWidth: 70
                            Text {
                                anchors.centerIn: parent
                                text: "2D: Axial"
                            }
                            border.color: "black"
                            border.width: 1
                            Text {
                                id: txtMR2DAxial
                                anchors.bottom: parent.bottom
                                text: "MR - 3 weeks ago"
                            }
                            Text {
                                anchors.bottom: txtMR2DAxial.top
                                text: "CT - 4 weeks ago"
                            }
                        }

                    }
                }
            }
        }
    }




    Component {
        id: tabViewStyle
        TabViewStyle {
            frameOverlap: 1
            tab: Rectangle {
                color: styleData.selected ? "steelblue" :"lightsteelblue"
                border.color:  "steelblue"
                implicitWidth: Math.max(text.width + 4, 80)
                implicitHeight: 20
                radius: 2
                Text {
                    id: text
                    anchors.centerIn: parent
                    //anchors.left: parent.left
                    text: styleData.title
                    color: styleData.selected ? "white" : "black"
                }
            }
            frame: Rectangle {
            }
            tabsAlignment: Qt.AlignHCenter
        }
    }
}
