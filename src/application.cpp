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


#include "application.h"
#include "api_key.h"

#include "weather/location.h"
#include "weather/service.h"
#include "weather/conditions.h"

// Qt headers
#include <QtDeclarative>

// KDE headers
#include <KDE/KMessageBox>
#include <kdeclarative.h>

KMainWindow *Application::m_window = nullptr;

Application::Application(): KApplication(true)
{
	registerQMLTypes();
	Weather::Service::setWeatherProvider(Weather::WorldWeatherOnline);
	Weather::Service::setAPIKey(WWO_API_KEY);
}

Application::~Application()
{

}

void Application::registerQMLTypes()
{
	qmlRegisterType<WeatherDesktop>();
	qmlRegisterType<Weather::Location>();
	qmlRegisterType<Weather::Service>();
	qmlRegisterType<Weather::Conditions>();
}

void Application::setupDeclarativeBindings(QDeclarativeEngine* declarativeEngine)
{
    KDeclarative kDeclarative;
    kDeclarative.setDeclarativeEngine(declarativeEngine);
    kDeclarative.initialize();
    kDeclarative.setupBindings();

    QScriptEngine* engine = kDeclarative.scriptEngine();
    QScriptValue globalObject = engine->globalObject();
}

void Application::error(const QString& msg, const QString& error) {
	Application::error("<b>" + msg + "</b><p><p>" + error);
}

void Application::error(const QString& msg) {
	KMessageBox::error(window(), msg);
	//qFatal(msg.toUtf8());
	::exit(-1);
}

#include "application.moc"