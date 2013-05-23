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


#ifndef FORECAST_H
#define FORECAST_H

#include "weather/service.h"

namespace Forecast {

	class Forecast : public Weather::Service
	{
		Q_OBJECT

	public:
		explicit Forecast(QObject* parent = 0);
		virtual ~Forecast();
		
		virtual void download(Weather::Location* location);
		virtual Weather::Conditions* create_conditions(Weather::Location* location);
		virtual void json_query(Weather::Location* location, const QString& query, const QString& params, QObject* receiver, const char* slot);
		
		static QString temp(float value) { return validate(value, format(value) + TEMP_F); }
		static QString clouds(float value) { return validate(value, format(value * 100) + '%'); }
		static QString humidity(float value) { return validate(value, format(value * 100) + '%'); }
		
	protected:
		virtual QString prefix() { return "https://api.forecast.io"; }
		QString internalLocation(Weather::Location *location);
		
	private slots:
		void onWeatherDownloaded(Weather::Location *location, QString error, const QVariantMap& data);
		
	private:
		static QString validate(float value, QString string) {
			if (value != -99) {
				return string;
			} else {
				return "";
			}
		}
		
		static QString format(float value) {
			return QLocale::system().toString(round(value), 'g', 3);
		}
		
		static float round(float value) {
			if (value < 1e-10) 
				return 0;
			else
				return value;
		}
		
	#include "forecast/forecast.gen"
	};

};

#endif // FORECAST_H