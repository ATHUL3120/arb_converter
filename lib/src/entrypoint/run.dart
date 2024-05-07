// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:arb_converter/src/model/arb_converter_model.dart';
import 'package:checked_yaml/checked_yaml.dart';
import 'package:translator/translator.dart';

void execute(List<String> args) async {
  File arbConverter = File("arb_converter.yaml");
  if (await arbConverter.exists()) {
    final arbDefault = arbConverter.readAsStringSync();
    final values= checkedYamlDecode(arbDefault, (o) => o);
    final value=ArbConverterModel.fromJson(values);
    File defaultFile = File(value.defaultLoc??'lib/l10n/intl_en.arb');
    if(await defaultFile.exists()) {
      final defaultFileValue = await defaultFile.readAsString();
      final defaultJson=Map<String,String>.from(jsonDecode(defaultFileValue));
      for (var language in (value.languages??{}).entries) {
        Map<String,String> lang={};
        for (var element in defaultJson.entries) {
          print("Translating ${language.key}...");
          final translator = GoogleTranslator();
          final input = element.value;

          final output= await translator.translate(input, from: value.defaultLang??'en', to: language.key);
          lang[element.key]=output.text;
        }
        String fileName="${value.output??'lib/l10n/'}${language.value}.arb";
        final file= File(fileName);
        // Write to the file
        file.writeAsStringSync(jsonEncode(lang));
        print('File created: $fileName');
      }

    }else{
      print("The Default File is not exist( ${value.defaultLoc??'lib/l10n/intl_en.arb'} )");
    }


  }
  // Parser parser = const Parser(
  //   pubspecPath: 'pubspec.yaml',
  //   flavorizrPath: 'flavorizr.yaml',
  // );
  //
  // Flavorizr? flavorizr;
  // try {
  //   flavorizr = parser.parse();
  // } catch (e) {
  //   stderr.writeln(e);
  //   exit(65);
  // }
  //
  // if (argProcessors.isNotEmpty) {
  //   flavorizr.instructions = argProcessors;
  // }
  //
  // Processor processor = Processor(flavorizr);
  // processor.execute();
}
