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

#ifndef WEATHER-DESKTOP_H
#define WEATHER-DESKTOP_H

#include "weather/location.h"

#include <QDeclarativeView>
#include <KDE/KXmlGuiWindow>
#include <KDE/KMenu>
#include <KDE/KAction>
#include <KDE/KIcon>

/**
 * This class serves as the main window for WeatherDesktop.  It handles the
 * menus, toolbars and status bars.
 *
 * @short Main window class
 * @author Michael Spencer <spencers1993@gmail.com>
 * @version 1.0.0
 */
class WeatherDesktop : public KXmlGuiWindow
{
	Q_OBJECT
	
	Q_PROPERTY(Weather::Location *currentLocation READ currentLocation WRITE setCurrentLocation NOTIFY currentLocationChanged)
	Q_PROPERTY(Weather::Location *searchLocation READ searchLocation WRITE setSearchLocation NOTIFY searchLocationChanged)
	Q_PROPERTY(Weather::Location *autoLocation READ autoLocation)
	Q_PROPERTY(QList<QObject*> locations READ locations NOTIFY locationsChanged)
	
	Q_PROPERTY(bool showWelcomeScreen READ showWelcomeScreen WRITE setShowWelcomeScreen NOTIFY showWelcomeScreenChanged)
	
public:
	/**
	 * Default Constructor
	 */
	WeatherDesktop();

	/**
	 * Default Destructor
	 */
	virtual ~WeatherDesktop();
	
	Q_INVOKABLE Weather::Location* location(QString name);
	Q_INVOKABLE Weather::Location* location(int index);
	
	Q_INVOKABLE void initialSetup();
	
public slots:
	Weather::Location *addLocation(const QString& name, const QString &location);
	void addCurrentLocation();
	void removeCurrentLocation();
	void setLocation(const QString& location);
	void showMenu(int x, int y);
	void showError(const QString& error);
	void showWeatherInfo();
	
private:
	void setupActions();
	void setupMenu();
	void init();
	
	Weather::Location *loadLocation(const QString& name, const QString &location);
	KAction *createAction(QString name, QString text, KIcon icon, QObject *obj, const char *slot);
	
	QDeclarativeView *m_view = nullptr;
	KMenu *m_menu = nullptr;
	
private slots:
	void changeAPIKey();
	void changeUnits(int index);
	void onImplicitWidthChanged();
	void onImplicitHeightChanged();
	void loadSettings();
	void saveSettings();
	void showSettingsDialog();
	void updateConfiguration();
	void setFullScreen(bool fullScreen);
	void delayedInit();
	
#include "weather-desktop.gen"
};

#endif // _WEATHER-DESKTOP_H_
