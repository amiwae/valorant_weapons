class DaftarWeapons {
  final num? status;
  final List<Data>? data;

  DaftarWeapons({
    this.status,
    this.data,
  });

  DaftarWeapons.fromJson(Map<String, dynamic> json)
      : status = json['status'] as num?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final String? uuid;
  final String? displayName;
  final String? category;
  final String? defaultSkinUuid;
  final String? displayIcon;
  final String? killStreamIcon;
  final String? assetPath;
  final WeaponStats? weaponStats;
  final ShopData? shopData;
  final List<Skins>? skins;

  Data({
    this.uuid,
    this.displayName,
    this.category,
    this.defaultSkinUuid,
    this.displayIcon,
    this.killStreamIcon,
    this.assetPath,
    this.weaponStats,
    this.shopData,
    this.skins,
  });

  Data.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'] as String?,
        displayName = json['displayName'] as String?,
        category = json['category'] as String?,
        defaultSkinUuid = json['defaultSkinUuid'] as String?,
        displayIcon = json['displayIcon'] as String?,
        killStreamIcon = json['killStreamIcon'] as String?,
        assetPath = json['assetPath'] as String?,
        weaponStats = (json['weaponStats'] as Map<String,dynamic>?) != null ? WeaponStats.fromJson(json['weaponStats'] as Map<String,dynamic>) : null,
        shopData = (json['shopData'] as Map<String,dynamic>?) != null ? ShopData.fromJson(json['shopData'] as Map<String,dynamic>) : null,
        skins = (json['skins'] as List?)?.map((dynamic e) => Skins.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'uuid' : uuid,
    'displayName' : displayName,
    'category' : category,
    'defaultSkinUuid' : defaultSkinUuid,
    'displayIcon' : displayIcon,
    'killStreamIcon' : killStreamIcon,
    'assetPath' : assetPath,
    'weaponStats' : weaponStats?.toJson(),
    'shopData' : shopData?.toJson(),
    'skins' : skins?.map((e) => e.toJson()).toList()
  };
}

class WeaponStats {
  final num? fireRate;
  final num? magazineSize;
  final num? runSpeedMultiplier;
  final num? equipTimeSeconds;
  final num? reloadTimeSeconds;
  final num? firstBulletAccuracy;
  final num? shotgunPelletCount;
  final String? wallPenetration;
  final String? feature;
  final dynamic fireMode;
  final String? altFireType;
  final AdsStats? adsStats;
  final dynamic altShotgunStats;
  final dynamic airBurstStats;
  final List<DamageRanges>? damageRanges;

  WeaponStats({
    this.fireRate,
    this.magazineSize,
    this.runSpeedMultiplier,
    this.equipTimeSeconds,
    this.reloadTimeSeconds,
    this.firstBulletAccuracy,
    this.shotgunPelletCount,
    this.wallPenetration,
    this.feature,
    this.fireMode,
    this.altFireType,
    this.adsStats,
    this.altShotgunStats,
    this.airBurstStats,
    this.damageRanges,
  });

  WeaponStats.fromJson(Map<String, dynamic> json)
      : fireRate = json['fireRate'] as num?,
        magazineSize = json['magazineSize'] as num?,
        runSpeedMultiplier = json['runSpeedMultiplier'] as num?,
        equipTimeSeconds = json['equipTimeSeconds'] as num?,
        reloadTimeSeconds = json['reloadTimeSeconds'] as num?,
        firstBulletAccuracy = json['firstBulletAccuracy'] as num?,
        shotgunPelletCount = json['shotgunPelletCount'] as num?,
        wallPenetration = json['wallPenetration'] as String?,
        feature = json['feature'] as String?,
        fireMode = json['fireMode'],
        altFireType = json['altFireType'] as String?,
        adsStats = (json['adsStats'] as Map<String,dynamic>?) != null ? AdsStats.fromJson(json['adsStats'] as Map<String,dynamic>) : null,
        altShotgunStats = json['altShotgunStats'],
        airBurstStats = json['airBurstStats'],
        damageRanges = (json['damageRanges'] as List?)?.map((dynamic e) => DamageRanges.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'fireRate' : fireRate,
    'magazineSize' : magazineSize,
    'runSpeedMultiplier' : runSpeedMultiplier,
    'equipTimeSeconds' : equipTimeSeconds,
    'reloadTimeSeconds' : reloadTimeSeconds,
    'firstBulletAccuracy' : firstBulletAccuracy,
    'shotgunPelletCount' : shotgunPelletCount,
    'wallPenetration' : wallPenetration,
    'feature' : feature,
    'fireMode' : fireMode,
    'altFireType' : altFireType,
    'adsStats' : adsStats?.toJson(),
    'altShotgunStats' : altShotgunStats,
    'airBurstStats' : airBurstStats,
    'damageRanges' : damageRanges?.map((e) => e.toJson()).toList()
  };
}

class AdsStats {
  final num? zoomMultiplier;
  final num? fireRate;
  final num? runSpeedMultiplier;
  final num? burstCount;
  final num? firstBulletAccuracy;

  AdsStats({
    this.zoomMultiplier,
    this.fireRate,
    this.runSpeedMultiplier,
    this.burstCount,
    this.firstBulletAccuracy,
  });

  AdsStats.fromJson(Map<String, dynamic> json)
      : zoomMultiplier = json['zoomMultiplier'] as num?,
        fireRate = json['fireRate'] as num?,
        runSpeedMultiplier = json['runSpeedMultiplier'] as num?,
        burstCount = json['burstCount'] as num?,
        firstBulletAccuracy = json['firstBulletAccuracy'] as num?;

  Map<String, dynamic> toJson() => {
    'zoomMultiplier' : zoomMultiplier,
    'fireRate' : fireRate,
    'runSpeedMultiplier' : runSpeedMultiplier,
    'burstCount' : burstCount,
    'firstBulletAccuracy' : firstBulletAccuracy
  };
}

class DamageRanges {
  final num? rangeStartMeters;
  final num? rangeEndMeters;
  final num? headDamage;
  final num? bodyDamage;
  final num? legDamage;

  DamageRanges({
    this.rangeStartMeters,
    this.rangeEndMeters,
    this.headDamage,
    this.bodyDamage,
    this.legDamage,
  });

  DamageRanges.fromJson(Map<String, dynamic> json)
      : rangeStartMeters = json['rangeStartMeters'] as num?,
        rangeEndMeters = json['rangeEndMeters'] as num?,
        headDamage = json['headDamage'] as num?,
        bodyDamage = json['bodyDamage'] as num?,
        legDamage = json['legDamage'] as num?;

  Map<String, dynamic> toJson() => {
    'rangeStartMeters' : rangeStartMeters,
    'rangeEndMeters' : rangeEndMeters,
    'headDamage' : headDamage,
    'bodyDamage' : bodyDamage,
    'legDamage' : legDamage
  };
}

class ShopData {
  final num? cost;
  final String? category;
  final String? categoryText;
  final GridPosition? gridPosition;
  final bool? canBeTrashed;
  final dynamic image;
  final String? newImage;
  final dynamic newImage2;
  final String? assetPath;

  ShopData({
    this.cost,
    this.category,
    this.categoryText,
    this.gridPosition,
    this.canBeTrashed,
    this.image,
    this.newImage,
    this.newImage2,
    this.assetPath,
  });

  ShopData.fromJson(Map<String, dynamic> json)
      : cost = json['cost'] as num?,
        category = json['category'] as String?,
        categoryText = json['categoryText'] as String?,
        gridPosition = (json['gridPosition'] as Map<String,dynamic>?) != null ? GridPosition.fromJson(json['gridPosition'] as Map<String,dynamic>) : null,
        canBeTrashed = json['canBeTrashed'] as bool?,
        image = json['image'],
        newImage = json['newImage'] as String?,
        newImage2 = json['newImage2'],
        assetPath = json['assetPath'] as String?;

  Map<String, dynamic> toJson() => {
    'cost' : cost,
    'category' : category,
    'categoryText' : categoryText,
    'gridPosition' : gridPosition?.toJson(),
    'canBeTrashed' : canBeTrashed,
    'image' : image,
    'newImage' : newImage,
    'newImage2' : newImage2,
    'assetPath' : assetPath
  };
}

class GridPosition {
  final num? row;
  final num? column;

  GridPosition({
    this.row,
    this.column,
  });

  GridPosition.fromJson(Map<String, dynamic> json)
      : row = json['row'] as num?,
        column = json['column'] as num?;

  Map<String, dynamic> toJson() => {
    'row' : row,
    'column' : column
  };
}

class Skins {
  final String? uuid;
  final String? displayName;
  final String? themeUuid;
  final String? contentTierUuid;
  final String? displayIcon;
  final dynamic wallpaper;
  final String? assetPath;
  final List<Chromas>? chromas;
  final List<Levels>? levels;

  Skins({
    this.uuid,
    this.displayName,
    this.themeUuid,
    this.contentTierUuid,
    this.displayIcon,
    this.wallpaper,
    this.assetPath,
    this.chromas,
    this.levels,
  });

  Skins.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'] as String?,
        displayName = json['displayName'] as String?,
        themeUuid = json['themeUuid'] as String?,
        contentTierUuid = json['contentTierUuid'] as String?,
        displayIcon = json['displayIcon'] as String?,
        wallpaper = json['wallpaper'],
        assetPath = json['assetPath'] as String?,
        chromas = (json['chromas'] as List?)?.map((dynamic e) => Chromas.fromJson(e as Map<String,dynamic>)).toList(),
        levels = (json['levels'] as List?)?.map((dynamic e) => Levels.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'uuid' : uuid,
    'displayName' : displayName,
    'themeUuid' : themeUuid,
    'contentTierUuid' : contentTierUuid,
    'displayIcon' : displayIcon,
    'wallpaper' : wallpaper,
    'assetPath' : assetPath,
    'chromas' : chromas?.map((e) => e.toJson()).toList(),
    'levels' : levels?.map((e) => e.toJson()).toList()
  };
}

class Chromas {
  final String? uuid;
  final String? displayName;
  final dynamic displayIcon;
  final String? fullRender;
  final dynamic swatch;
  final dynamic streamedVideo;
  final String? assetPath;

  Chromas({
    this.uuid,
    this.displayName,
    this.displayIcon,
    this.fullRender,
    this.swatch,
    this.streamedVideo,
    this.assetPath,
  });

  Chromas.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'] as String?,
        displayName = json['displayName'] as String?,
        displayIcon = json['displayIcon'],
        fullRender = json['fullRender'] as String?,
        swatch = json['swatch'],
        streamedVideo = json['streamedVideo'],
        assetPath = json['assetPath'] as String?;

  Map<String, dynamic> toJson() => {
    'uuid' : uuid,
    'displayName' : displayName,
    'displayIcon' : displayIcon,
    'fullRender' : fullRender,
    'swatch' : swatch,
    'streamedVideo' : streamedVideo,
    'assetPath' : assetPath
  };
}

class Levels {
  final String? uuid;
  final String? displayName;
  final dynamic levelItem;
  final String? displayIcon;
  final dynamic streamedVideo;
  final String? assetPath;

  Levels({
    this.uuid,
    this.displayName,
    this.levelItem,
    this.displayIcon,
    this.streamedVideo,
    this.assetPath,
  });

  Levels.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'] as String?,
        displayName = json['displayName'] as String?,
        levelItem = json['levelItem'],
        displayIcon = json['displayIcon'] as String?,
        streamedVideo = json['streamedVideo'],
        assetPath = json['assetPath'] as String?;

  Map<String, dynamic> toJson() => {
    'uuid' : uuid,
    'displayName' : displayName,
    'levelItem' : levelItem,
    'displayIcon' : displayIcon,
    'streamedVideo' : streamedVideo,
    'assetPath' : assetPath
  };
}