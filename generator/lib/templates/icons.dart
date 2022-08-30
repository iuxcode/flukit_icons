const String
    fluIconsCode = /* '''
import 'package:flutter/material.dart';
import 'model.dart';


@immutable
class FluIcons {
%INDENT%const FluIcons._();

%CODE%
}
'''; */
    '''
enum FluIcons {
%NAMES%
}

extension FluIconsData on FluIcons {
%DATA%
}
''';

const String extensionGetter = '''
%INDENT%%TYPE% get %NAME% {
%INDENT%%INDENT%switch (this) {
%CONTENT%
%INDENT%%INDENT%}
%INDENT%}
''';
