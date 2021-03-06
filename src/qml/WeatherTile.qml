/***************************************************************************
 *  Weather Desktop - An advanced, cross-platform weather application.     *
 *  Copyright (C) 2013  Michael Spencer <spencers1993@gmail.com>           *
 *                                                                         *
 *  This program is free software: you can redistribute it and/or modify   *
 *  it under the terms of the GNU General Public License as published by   *
 *  the Free Software Foundation, either version 3 of the License, or      *
 *  (at your option) any later version.                                    *
 *                                                                         *
 *  This program is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                           *
 *                                                                         *
 *  You should have received a copy of the GNU General Public License      *
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.  *
 ***************************************************************************/

import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as PlasmaComponents
import org.kde.plasma.graphicswidgets 0.1 as PlasmaWidgets

Rectangle {
	id: root;
	
    //color: "transparent"
    color: highlighted ? Qt.darker(appStyle.panelColor,5) : appStyle.panelColor
    border.color: appStyle.internalBorderColor;
    property color textColor: appStyle.textColor;
	
	smooth: true
    width: 200
    height: 72
    radius: 2
	
	signal clicked
	
    property string icon
	property alias title: title.text;
	property alias temp: temp.text;
	property alias weather: weather.text;
//	property alias iconForecast: iconForecast.source;
//	property alias maxTemp: maxTemp.text;
//	property alias minTemp: minTemp.text;
	//property alias weatherForecast: weatherForecast.text;
	
	property int alerts: 0;
	property bool selected: false;
	property bool highlighted: selected || state == "mouse-over"
	

//    PlasmaComponents.Highlight {
//        anchors.fill: parent
//    }

    Column {
        spacing: 2

        anchors {
            left: parent.left
            right: icon.left;
            margins: 10;
            verticalCenter: parent.verticalCenter;
        }

        Text {
            id: title

            width: parent.width

            font.pixelSize: appStyle.titleFontSize * 1;
            color: textColor;
            style: Text.Raised
            styleColor: appStyle.shadowColor
        }

        Text {
            id: temp

            anchors {
                left: parent.left
                leftMargin: 5
                right: parent.right
            }

            font.pixelSize: appStyle.headerFontSize - 2;
            color: textColor;
            style: Text.Raised
            styleColor: appStyle.shadowColor
        }

        Text {
            id: weather

            anchors {
                left: parent.left
                leftMargin: 5
                right: parent.right
            }

            font.pixelSize: appStyle.headerFontSize - 2;
            elide: Text.ElideRight;
            color: textColor;
            style: Text.Raised
            styleColor: appStyle.shadowColor
        }
    }

    Image {
        id: icon
        width: 64; height: 64;
        source: getIcon(root.icon, 64)

        anchors {
            right: parent.right;
            rightMargin: 10;
            verticalCenter: parent.verticalCenter;
        }
    }
	
	Rectangle {
		id: alertsObject
		width: height
		height: alertsText.height + 2
		visible: root.alerts > 0
		
		radius: height/2
		color: appStyle.errorColor
		
		anchors {
			top: parent.top;
			right: parent.right;
			topMargin: 5;
			rightMargin: 5;
		}
		
		Text {
			id: alertsText
			anchors.centerIn: parent
			color: "white"
			//style: Text.Raised
			//styleColor: appStyle.shadowColor
			
			text: root.alerts
		}
	}
	
//	Item {
//		id: conditions
//		opacity: 0
		
//		anchors {
//			top: title.bottom;
//			bottom: root.bottom;
//			left: root.left;
//			right: root.right;
//		}
	

		

//	}
	
//	Item {
//		id: forecast
//		opacity: 0
		
//		anchors {
//			top: title.bottom;
//			bottom: root.bottom;
//			left: root.left;
//			right: root.right;
//		}
		
//		PlasmaCore.IconItem {
//			id: iconForecast
//			width: 64; height: 64;
			
//			anchors {
//				left: parent.left;
//				leftMargin: 10;
//				verticalCenter: parent.verticalCenter;
//			}
//		}
		
//		/*Text {
//			id: tempForecast
			
//			anchors {
//				left: iconForecast.right;
//				leftMargin: 10;
//				bottom: parent.verticalCenter;
//			}
			
//			font.pixelSize: appStyle.titleFontSize;
//			color: textColor;
//		}*/
		
//		Text {
//			id: minTemp
//			anchors {
//				verticalCenter: parent.verticalCenter
//				left: iconForecast.right
//				leftMargin: 15
//			}
			
//			font.pixelSize: appStyle.titleFontSize + 2;
//			color: "#217ecd"
			
//			style: Text.Raised
//			styleColor: appStyle.shadowColor
//		}
		
//		Text {
//			id: maxTemp
			
//			anchors {
//				verticalCenter: parent.verticalCenter
//				left: minTemp.right
//				leftMargin: 12
//			}
			
//			font.pixelSize: appStyle.titleFontSize + 7;
//			color: "#c31f1f"
			
//			style: Text.Raised
//			styleColor: appStyle.shadowColor
//		}
		
//// 		Text {
//// 			id: weatherForecast
////
//// 			anchors {
//// 				left: iconForecast.right;
//// 				leftMargin: 10;
//// 				right: parent.right;
//// 				rightMargin: 10;
//// 				//top: iconForecast.top;//parent.verticalCenter;
//// 				//bottom: iconForecast.bottom;
//// 				verticalCenter: iconForecast.verticalCenter;
//// 			}
////
//// 			font.pixelSize: appStyle.headerFontSize - 2;
//// 			color: textColor;
//// 			style: Text.Raised
//// 			styleColor: appStyle.shadowColor
//// 			elide: Text.ElideRight;
//// 			wrapMode: Text.Wrap;
//// 			textFormat: Text.PlainText
//// 			maximumLineCount: 3
//// 		}
//	}
	
	Behavior on color {
		ColorAnimation { duration: 300 }
	}
	
	MouseArea {
		id: mouseArea
		hoverEnabled: true
		anchors.fill: parent
		onClicked: root.clicked()
	}
	
    states: [
        State {
            name: "default"
            when: !mouseArea.containsMouse
            //PropertyChanges { target: conditions; opacity: 1; restoreEntryValues: true; }
        },
        State {
            name: "mouse-over"
            when: mouseArea.containsMouse
            //PropertyChanges { target: forecast; opacity: 1; restoreEntryValues: true; }
        }
    ]
	
//	transitions: [
//		Transition {
//			to:	"*"
//			NumberAnimation { property: "opacity"; duration: 300 }
//		}
//	]
}
