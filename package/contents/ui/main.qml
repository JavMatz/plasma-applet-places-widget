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
    id: matePlaces
    property bool showHidden: plasmoid.configuration.showHidden
    property bool showDevices: plasmoid.configuration.showDevices
    property bool showTimeline: plasmoid.configuration.showTimeline
    property bool showSearches: plasmoid.configuration.showSearches
    property int panelButtonStyle: plasmoid.configuration.panelButtonStyle
    property int widgetWidth: plasmoid.configuration.widgetWidth

    compactRepresentation: MouseArea {
      id: menuMouseArea
      readonly property bool tooSmall: Plasmoid.formFactor === PlasmaCore.Types.Horizontal && Math.round(2 * (menuMouseArea.height / 5)) <= Kirigami.Theme.smallFont.pixelSize
      readonly property int iconSize: Kirigami.Units.iconSizes.large
      readonly property var sizing: {
        const displayedIcon = menuIcon

        let impWidth = 0;
        impWidth += panelButtonStyle === 0 || panelButtonStyle === 2 ? menuIcon.width : 0;
        impWidth += panelButtonStyle === 1 || panelButtonStyle === 2 ? menuLabel.contentWidth + menuLabel.Layout.leftMargin + menuLabel.Layout.rightMargin : 0;
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

      onClicked: matePlaces.expanded = !matePlaces.expanded
      hoverEnabled: true

      RowLayout { 
        id: menuRow
        anchors.fill: parent
        spacing: 0

        Kirigami.Icon {
          id: menuIcon

          Layout.fillWidth: matePlaces.vertical
          Layout.fillHeight: !matePlaces.vertical
          Layout.preferredWidth: matePlaces.vertical ? -1 : height / (implicitHeight / implicitWidth)
          Layout.preferredHeight: !matePlaces.vertical ? -1 : width * (implicitHeight / implicitWidth)
          Layout.maximumHeight: Kirigami.Units.iconSizes.huge
          Layout.maximumWidth: Kirigami.Units.iconSizes.huge
          Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

          visible: panelButtonStyle === 0 || panelButtonStyle === 2
          source: 'folder-favorite'
        }

        PC3.Label { 
          id: menuLabel
          Layout.fillHeight: true
          Layout.leftMargin: Kirigami.Units.smallSpacing
          Layout.rightMargin: Kirigami.Units.smallSpacing

          text: i18n('Places')
          textFormat: Text.StyledText
          horizontalAlignment: Text.AlignLeft
          verticalAlignment: Text.AlignVCenter
          wrapMode: Text.NoWrap
          fontSizeMode: Text.VerticalFit
          font.pixelSize: menuMouseArea.tooSmall ? Kirigami.Theme.defaultFont.pixelSize : Kirigami.Units.iconSizes.roundedIconSize(Kirigami.Units.gridUnit * 2)
          minimumPointSize: Kirigami.Theme.smallFont.pointSize
          visible: panelButtonStyle === 1 || panelButtonStyle === 2
        }
      }
    }


    fullRepresentation: FullRepresentation {}

    preferredRepresentation: compactRepresentation
}
