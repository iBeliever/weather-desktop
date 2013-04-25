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

#include "main.h"
#include "weather/service.h"
#include "weather/location.h"
#include "weather/conditions.h"

#include <QUrl>
#include <QNetworkAccessManager>

using namespace Weather;

Service::Service(Location* location): QObject(location)
{

}

Service::~Service()
{

}

QVariantMap Weather::Service::json_call(QString* error, const QString& call)
{
	QString text = download(QUrl(prefix() + '/' + call), error);
	
	if (!error->isEmpty())
		return QVariantMap();
	
	bool ok;
	QJson::Parser parser;
	QVariantMap result = parser.parse(text.toAscii(), &ok).toMap();
	if (!ok) {
		*error = "Unable to parse JSON response!";
		return QVariantMap();
	}
	
	if (result["response"].toMap().contains("error")) {
		*error = "[" + result["response"].toMap()["error"].toMap()["type"].toString() + "] " + 
				result["response"].toMap()["error"].toMap()["description"].toString();
	}
	
	return result;
}

Weather::Conditions* Weather::Service::create_conditions()
{
	return new Conditions(location());
}

#include "weather/service.moc"