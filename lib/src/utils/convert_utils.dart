// Copyright 2018 The FlutterCandies author. All rights reserved.
// Use of this source code is governed by an Apache license that can be found
// in the LICENSE file.

import '../filter/filter_option_group.dart';
import '../types/entity.dart';
import '../types/types.dart';

class ConvertUtils {
  const ConvertUtils._();

  static List<AssetPathEntity> convertToPathList(
    Map<String, dynamic> data, {
     RequestType type,
    FilterOptionGroup optionGroup,
  }) {
    final List<AssetPathEntity> result = <AssetPathEntity>[];
    final List<Map<dynamic, dynamic>> list =
        (data['data'] as List<dynamic>).cast<Map<dynamic, dynamic>>();
    for (final Map<dynamic, dynamic> item in list) {
      // Skip paths with empty assets.
      if (item['assetCount'] == 0) {
        continue;
      }
      result.add(
        convertMapToPath(
          item.cast<String, dynamic>(),
          type: type,
          optionGroup: optionGroup ?? FilterOptionGroup(),
        ),
      );
    }
    return result;
  }

  static List<AssetEntity> convertToAssetList(Map<String, dynamic> data) {
    final List<AssetEntity> result = <AssetEntity>[];
    final List<Map<dynamic, dynamic>> list =
        (data['data'] as List<dynamic>).cast<Map<dynamic, dynamic>>();
    for (final Map<dynamic, dynamic> item in list) {
      result.add(convertMapToAsset(item.cast<String, dynamic>()));
    }
    return result;
  }

  static AssetPathEntity convertMapToPath(
    Map<String, dynamic> data, {
     RequestType type,
    FilterOptionGroup optionGroup,
  }) {
    final int modified = data['modified'] != null ? data['modified'] as int: null;
    final DateTime lastModified = modified != null
        ? DateTime.fromMillisecondsSinceEpoch(modified * 1000)
        : null;
    final AssetPathEntity result = AssetPathEntity(
      id: data['id'] as String,
      name: data['name'] as String,
      // ignore: deprecated_member_use_from_same_package
      assetCount: data['assetCount'] != null ?  data['assetCount'] as int: 0,
      albumType: data['albumType'] != null ? data['albumType'] as int : 1,
      filterOption: optionGroup ?? FilterOptionGroup(),
      lastModified: lastModified,
      type: type,
      isAll: data['isAll'] as bool,
    );
    return result;
  }

  static AssetEntity convertMapToAsset(
    Map<String, dynamic> data, {
    String title,
  }) {
    final AssetEntity result = AssetEntity(
      id: data['id'] as String,
      typeInt: data['type'] as int,
      width: data['width'] as int,
      height: data['height'] as int,
      duration: data['duration'] != null ? data['duration'] as int : 0,
      orientation: data['orientation'] != null ? data['orientation'] as int: 0,
      isFavorite: data['favorite'] != null ? data['favorite'] as bool:  false,
      title: data['title']!= null ? data['title'] as String: title,
      subtype: data['subtype']!= null ? data['subtype'] as int :0,
      createDateSecond: data['createDt'] != null ? data['createDt'] as int : null,
      modifiedDateSecond: data['modifiedDt']!= null ?  data['modifiedDt'] as int : null,
      relativePath: data['relativePath'] != null ? data['relativePath'] as String : null,
      latitude: data['lat'] != null ? data['lat'] as double : null,
      longitude: data['lng'] != null ?  data['lng'] as double : null,
      mimeType: data['mimeType'] != null ? data['mimeType'] as String : null,
    );
    return result;
  }
}
