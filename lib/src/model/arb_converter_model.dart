class ArbConverterModel {
  ArbConverterModel({
      this.defaultLoc, 
      this.defaultLang, 
      this.output,
      this.languages,});

  ArbConverterModel.fromJson(dynamic json) {
    defaultLoc = json['default_loc'];
    defaultLang = json['default_lang'];
    output = json['output'];
    languages = json['languages'] != null ? Map<String,String>.from(json['languages']) : null;
  }
  String? defaultLoc;
  String? defaultLang;
  String? output;
  Map<String,String>? languages;
ArbConverterModel copyWith({  String? defaultLoc,
  String? defaultLang,
  String? output,
  Map<String,String>? languages,
}) => ArbConverterModel(  defaultLoc: defaultLoc ?? this.defaultLoc,
  defaultLang: defaultLang ?? this.defaultLang,
  output: output ?? this.output,
  languages: languages ?? this.languages,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['default_loc'] = defaultLoc;
    map['default_lang'] = defaultLang;
    map['output'] = output;
    map['languages'] = languages;
    return map;
  }

}