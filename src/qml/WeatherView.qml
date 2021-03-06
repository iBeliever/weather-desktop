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
	id: root
	color: "#00000000" // transparent
	
    property string view: "conditions"
	property bool is_valid: weatherLocation.valid
	property bool is_refreshing: !is_valid && weatherLocation.refreshing;
	property bool is_error: !is_valid && weatherLocation.error;
	
	property variant weatherLocation;

    property string title: view === "today"
                           ? today.title
                           : view === "conditions"
                             ? conditions.title
                             : view === "hourly"
                               ? hourlyForecast.title
                               : view === "daily"
                                 ? dailyForecast.title
                                 : i18n.tr("Unknown")
	
	onStateChanged: {
		console.log("Width, height: " + width + ", " + height);
	}
	
	PlasmaWidgets.BusyWidget {
		id: refreshingWidget
		anchors.centerIn: parent
		
		width: height
 		height: 80
		opacity: 0
		running: false
		
		Behavior on opacity {
			NumberAnimation { duration: 500 }
		}
	}
	
	WeatherConditions {
		id: conditions
		anchors.centerIn: root
		opacity: 0

        weatherLocation: root.weatherLocation
		
        Behavior on opacity {
			NumberAnimation { duration: 500 }
		}
	}
	
	ErrorDialog {
		id: error
		opacity: 0
		anchors.centerIn: root
		title: i18n("Unable to access weather")
		text: weatherLocation.errorString;
		
		Behavior on opacity {
			NumberAnimation { duration: 500 }
		}
	}
	
	DailyForecast {
		id: dailyForecast
		anchors.centerIn: root
		opacity: 0
				
		Behavior on opacity {
			NumberAnimation { duration: 500 }
		}
		
		weatherLocation: root.weatherLocation
	}
	
	WeatherHourly {
		id: hourlyForecast
		anchors.centerIn: root
		opacity: 0
		
		Behavior on opacity {
			NumberAnimation { duration: 500 }
		}
		
		weatherLocation: root.weatherLocation
	}
	
	WeatherToday {
		id: today
		anchors.centerIn: root
		opacity: 0
		
		Behavior on opacity {
			NumberAnimation { duration: 500 }
		}
		
		weatherLocation: root.weatherLocation
    }
	
	states: [
		State {
			name: "conditions"
			when: is_valid && view == "conditions"
			PropertyChanges { target: conditions; opacity: 1; restoreEntryValues: true; }
			PropertyChanges { target: root; implicitWidth: conditions.implicitWidth; }
			PropertyChanges { target: root; implicitHeight: conditions.implicitHeight; }
		},
		State {
			name: "daily"
			when: is_valid && view == "daily"
			PropertyChanges { target: dailyForecast; opacity: 1; restoreEntryValues: true; }
			PropertyChanges { target: root; implicitWidth: dailyForecast.implicitWidth; }
			PropertyChanges { target: root; implicitHeight: dailyForecast.implicitHeight; }
		},
		State {
			name: "hourly"
			when: is_valid && view == "hourly"
			PropertyChanges { target: hourlyForecast; opacity: 1; restoreEntryValues: true; }
			PropertyChanges { target: root; implicitWidth: hourlyForecast.implicitWidth; }
			PropertyChanges { target: root; implicitHeight: hourlyForecast.implicitHeight; }
		},
		State {
			name: "today"
			when: is_valid && view == "today"
			PropertyChanges { target: today; opacity: 1; restoreEntryValues: true; }
			PropertyChanges { target: root; implicitWidth: today.implicitWidth; }
			PropertyChanges { target: root; implicitHeight: today.implicitHeight; }
		},
		State {
			name: "refreshing"
			when: is_refreshing
			PropertyChanges { target: refreshingWidget; opacity: 1; running: true; restoreEntryValues: true; }
			PropertyChanges { target: root; implicitWidth: error.implicitWidth; }
			PropertyChanges { target: root; implicitHeight: error.implicitHeight; }
		},		
		State {
			name: "error"
			when: is_error
			PropertyChanges { target: error; opacity: 1; restoreEntryValues: true; }
			PropertyChanges { target: root; implicitWidth: error.implicitWidth; }
			PropertyChanges { target: root; implicitHeight: error.implicitHeight; }
		}
	]
	
	transitions: [
		Transition {
			to:	"*"
			NumberAnimation { property: "opacity"; duration: 750 }
		}
	]
}
