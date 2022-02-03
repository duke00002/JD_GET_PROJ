import 'package:jd_get_proj/database/providers/transport_table_provider.dart';

class TransportItemModel {
  //表列名
  int? id;
  //姓名
  String? name;
  //电话
  String? phone;
  //省
  String? province;
  //市
  String? city;
  //区
  String? district;
  //地址
  String? address;
  //是否默认(bool型，在SQL中是1，0)
  bool? isDefault;

  TransportItemModel(this.id, this.name, this.phone, this.province, this.city,
      this.district, this.address, this.isDefault);

  //生成空类(命名构造函数)
  TransportItemModel.init();

  TransportItemModel.fromJson(Map<String, dynamic> json) {
    id = json[TransportTableProvider.columnId];
    name = json[TransportTableProvider.columnName];
    phone = json[TransportTableProvider.columnPhone];
    province = json[TransportTableProvider.columnProvince];
    city = json[TransportTableProvider.columnCity];
    district = json[TransportTableProvider.columnDistrict];
    address = json[TransportTableProvider.columnAddress];
    //SQL:bool型为0或者1
    isDefault =
        json[TransportTableProvider.columnIsDefault] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    //不插入ID
    data[TransportTableProvider.columnName] = name;
    data[TransportTableProvider.columnPhone] = phone;
    data[TransportTableProvider.columnProvince] = province;
    data[TransportTableProvider.columnCity] = city;
    data[TransportTableProvider.columnDistrict] = district;
    data[TransportTableProvider.columnAddress] = address;
    data[TransportTableProvider.columnIsDefault] = isDefault! ? 1 : 0;
    return data;
  }
}
