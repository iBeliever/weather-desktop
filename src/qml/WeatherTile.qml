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
	
// 	color: selected || state == "mouse-over" ?
// 			(alert ? Qt.rgba(0.75,0.25,0.25,1) : "#ef7645") :
// 			(alert ? Qt.rgba(0.75,0.25,0.25,1) : Qt.rgba(33/256,126/256,205/256,1))
			
	color: selected || state == "mouse-over" ? "#ef7645" : //"white"
			Qt.rgba(33/256,126/256,205/256,1)
	
	property color textColor: appStyle.textColor;
	//property color textColor: "black";
			
	smooth: true
	width: 200
	height: 100
	//border.color: "gray"
	radius: 3
	
	signal clicked
	
	property alias icon: icon.source;
	property alias title: title.text;
	property alias temp: temp.text;
	property alias weather: weather.text;
	
	property bool alert: false;
	property bool selected: false;
	
	Text {
		id: title
		
		anchors {
			top: root.top;
			left: root.left;
			leftMargin: 5;
			topMargin: 2;
		}
		
		font.pixelSize: appStyle.titleFontSize;
		color: textColor;
	}
	
	PlasmaCore.IconItem {
		id: alertIcon
		source: root.alert ? "emblem-important" : ""
		width: 16; height: 16;
		
		anchors {
			top: parent.top;
			right: parent.right;
			topMargin: 5;
			rightMargin: 5;
		}
	}
	
	Item {
		id: conditions
		opacity: 1
		
		anchors {
			top: title.bottom;
			bottom: root.bottom;
			left: root.left;
			right: root.right;
		}
	
		PlasmaCore.IconItem {
			id: icon
			width: 64; height: 64;
			
			anchors {
				left: parent.left;
				leftMargin: 10;
				verticalCenter: parent.verticalCenter;
			}
		}
		
		Text {
			id: temp
			
			anchors {
				left: icon.right;
				leftMargin: 10;
				bottom: parent.verticalCenter;
			}
			
			font.pixelSize: appStyle.titleFontSize;
			color: textColor;
		}
		
		Text {
			id: weather
			
			anchors {
				left: icon.right;
				leftMargin: 10;
				top: parent.verticalCenter;
			}
			
			font.pixelSize: appStyle.headerFontSize - 2;
			color: textColor;
		}
	}
	
	Item {
		id: forecast
		opacity: 0
		
		anchors {
			top: title.bottom;
			bottom: root.bottom;
			left: root.left;
			right: root.right;
		}
		
		Text {
			anchors.centerIn: parent;
			text: "Weather Forecast!"
			font.pixelSize: appStyle.headerFontSize;
			color: textColor;
		}
	}
	
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
	
	transitions: [
		Transition {
			to:	"*"
			NumberAnimation { property: "opacity"; duration: 300 }
		}
	]
}
