class Menu {
  late int id;
  late bool isHeader;
  late String name;
  late String activeIcon;
  late String icon;

  Menu(this.id, this.name, this.icon, this.activeIcon, {this.isHeader = false});
}
