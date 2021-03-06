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


#include "worldweather/worldweatheronline.h"
#include "worldweather/conditions.h"

WorldWeatherOnline::WorldWeatherOnline::WorldWeatherOnline(Weather::Location* location): Weather::Service(location)
{
}

QString WorldWeatherOnline::WorldWeatherOnline::prefix()
{
    return "http://api.worldweatheronline.com/free/v1/";
}

Weather::Conditions* WorldWeatherOnline::WorldWeatherOnline::create_conditions()
{
	return new WorldWeatherConditions(location());
}

void WorldWeatherOnline::WorldWeatherOnline::json_query(const QString& query, const QString& params, QObject* receiver, const char* slot)
{
	json_call(query + ".ashx?q=" + internalLocation() + "&format=json&" + params + "&key=" + Weather::Service::apiKey(), receiver, slot);
}

QString WorldWeatherOnline::WorldWeatherOnline::internalLocation()
{
	return location()->location().replace(' ', '+').replace("St.", "Saint");
}

void WorldWeatherOnline::WorldWeatherOnline::refresh()
{
	json_query("weather", "", this, SLOT(onConditionsDownloaded(QString,QVariantMap)));
}

void WorldWeatherOnline::WorldWeatherOnline::onConditionsDownloaded(QString error, const QVariantMap& data)
{
	if (error.isEmpty() && data["data"].toMap().contains("error")) {
		error = data["data"].toMap()["error"].toList()[0].toMap()["msg"].toString();
	}
	
	if (!error.isEmpty()) {
		location()->setError(true);
		location()->setErrorMessage(error);
	} else {
		//qDebug() << "Saving data: " << data;
		this->data()["weather"] = data;
	}
	
	location()->finishedRefresh();
	emit refreshed();
}



#include "worldweather/worldweatheronline.moc"
