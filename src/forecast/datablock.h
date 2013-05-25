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


#ifndef FORECAST_DATABLOCK_H
#define FORECAST_DATABLOCK_H

#include <QObject>
#include <QList>

namespace Weather {
	class Location;
}

namespace Forecast {

	class Point;
	
	class Block : public QObject
	{
		Q_OBJECT
		
		Q_PROPERTY(Weather::Location *location READ location NOTIFY locationChanged);
		Q_PROPERTY(QString path READ path NOTIFY pathChanged)
		
		Q_PROPERTY(QList<Point*> data READ data WRITE set NOTIFY dataChanged)
		Q_PROPERTY(QString summary READ summary WRITE setSummary NOTIFY summaryChanged);
		Q_PROPERTY(QString icon READ icon WRITE setIcon NOTIFY iconChanged);

	public:
		explicit Block(Weather::Location *location, const QString& path);
		virtual ~Block();
		
	public slots:
		void load();
	
	#include "forecast/datablock.gen"
	};

}

#endif // FORECAST_DATABLOCK_H
