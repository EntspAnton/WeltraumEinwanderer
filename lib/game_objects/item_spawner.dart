import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/coin.dart';
import 'package:weltraum_einwanderer/item.dart';
import 'package:weltraum_einwanderer/weapon_item.dart';

enum ItemType {
  goldCoin,
  blueCoin,
  azureCoin,
  greenCoin,
  purpleCoin,
  shooterWeapon,
  shotgunWeapon,
  spiralWeapon,
  fuckYouAllWeapon
}

class ItemSpawner {
  List<ItemType> items = [
    ItemType.goldCoin,
    ItemType.blueCoin,
    ItemType.azureCoin,
    ItemType.greenCoin,
    ItemType.purpleCoin
  ];
  late List<double> propabilities;
  List<double> weights = [50, 30, 10, 7, 3];

  late ItemType currentWeapon;

  ItemSpawner({required this.currentWeapon}) {
    propabilities = calculatePropabilities();
  }

  List<double> calculatePropabilities() {
    double sum = 0;
    List<double> newPropabilities = [];

    for (double weight in weights) {
      sum += weight;
    }

    for (double weight in weights) {
      newPropabilities.add(weight / sum);
    }
    return newPropabilities;
  }

  void addItem(ItemType item, double weight) {
    items.add(item);
    weights.add(weight);
    propabilities = calculatePropabilities();
  }

  dynamic getRandomItem(Vector2 position) {
    print(items);
    print(weights);
    print(propabilities);
    ItemType itemType;
    do {
      itemType = randomChoice(items, propabilities);
    } while (itemType == currentWeapon);
    print(itemType);

    switch (itemType) {
      case ItemType.goldCoin:
        return GoldCoin(position: position);
      case ItemType.blueCoin:
        return BlueCoin(position: position);
      case ItemType.azureCoin:
        return AzureCoin(position: position);
      case ItemType.greenCoin:
        return GreenCoin(position: position);
      case ItemType.purpleCoin:
        return PurpleCoin(position: position);
      case ItemType.shooterWeapon:
        return ShooterWeaponItem(position: position);
      case ItemType.shotgunWeapon:
        return ShotgunWeaponItem(position: position);
      case ItemType.spiralWeapon:
        return SpiralWeaponItem(position: position);
      case ItemType.fuckYouAllWeapon:
        return FuckYouAllWeaponItem(position: position);
    }
  }
}
