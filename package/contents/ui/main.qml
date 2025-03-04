/*
 * Copyright 2016  Daniel Faust <hessijames@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http: //www.gnu.org/licenses/>.
 */
import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PC3
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    id: plasmoidItem
    property bool showHidden: plasmoid.configuration.showHidden
    property bool showDevices: plasmoid.configuration.showDevices
    property bool showTimeline: plasmoid.configuration.showTimeline
    property bool showSearches: plasmoid.configuration.showSearches
    property int widgetWidth: plasmoid.configuration.widgetWidth

    compactRepresentation: MouseArea {
      id: menuMouseArea
      anchors.fill: parent
      readonly property int iconSize: Kirigami.Units.iconSizes.large
      readonly property var sizing: {
        const displayedIcon = menuIcon

        let impWidth = 0;
        impWidth += menuIcon.width;
        impWidth += menuLabel.contentWidth + menuLabel.Layout.leftMargin + menuLabel.Layout.rightMargin;
        const impHeight = menuIcon.height > 0 ? menuIcon.height : iconSize
        return {
          preferredWidth: impWidth,
          preferredHeight: iconSize
        };
      }

      implicitWidth: iconSize
      implicitHeight: iconSize

      Layout.preferredWidth: sizing.preferredWidth
      Layout.preferredHeight: sizing.preferredHeight
      Layout.minimumWidth: Layout.preferredWidth
      Layout.minimumHeight: Layout.preferredHeight

      onClicked: plasmoidItem.expanded = !plasmoidItem.expanded
      hoverEnabled: true

      RowLayout { 
        id: menuRow
        anchors.fill: parent
        spacing: 0

        Kirigami.Icon {
          id: menuIcon
          visible: true
          source: 'folder-favorite'
          Layout.fillHeight: true
          Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }

        PC3.Label { 
          id: menuLabel
          Layout.fillHeight: true
          Layout.leftMargin: Kirigami.Units.smallSpacing
          Layout.rightMargin: Kirigami.Units.smallSpacing

          text: i18n('Places')
          horizontalAlignment: Text.AlignLeft
          verticalAlignment: Text.AlignVCenter
          wrapMode: Text.NoWrap
          fontSizeMode: Text.VerticalFit
        }
      }
    }


    fullRepresentation: FullRepresentation {}

    preferredRepresentation: compactRepresentation
}
