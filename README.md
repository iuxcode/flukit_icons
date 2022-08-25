# `Flukit_icons`

**3000+ Pixel-perfect svg unicons for your next flutter project.**

</br>

![flukit_icons]('')

</br>

Special thanks to [**Unicons**](https://github.com/iconscout/unicons), [**vue-unicons**](https://github.com/antonreshetov/vue-unicons/blob/master/README.md) and [**Vuesax**]('') authors without whom this project would not have been carried out. 🙏

</br>

## Demo

</br>

You can get the latest gallery release [**here**](https://github.com/charles9904/flukit_icons_gallery/releases/tag/Flukit_flukit_icons).

</br>

## Installation

</br>

```yaml
# Add flukit_icons as a dependency to your pubspec.yaml

dependencies:

  flukit_icons: 1.0.0
```

</br>

## Usage

</br>

```dart
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

class MyBeautifulApp extends StatelessWidget {
  const MyBeautifulApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FluIcon(icon: FluIcons.githubUnicon),
            FluIcon(icon: FluIcons.flash, style: FluIconStyles.bulk),
          ],
        ),
      ),
    );
  }
}
```

</br>

## Options

</br>

|Name|Description|Type|default value|
|:---|:---|:---|---:|
|`icon` * |Icon to be displayed|[FluIconData]('')| -
|`style` |Icon style. can be `linear`, `broken`, `twotone` or `bulk`. Some icons doesn't have all fourth style. Refer to the [gallery]('') to know more |[FluIconStyles]('')| FluIconStyles.twotone
|`size`|Icon size|[double]('')|24|
|`strokewidth`|Icon strokewidth|[double]('')|1.5|
|`color` ?|icon color|[Color]('')|Colors.black|

</br>

Note: `*` marked options are required and `?` marked options are nullable.

</br>

## Contribution

</br>

`flukit_icons` is a fully open-source project, and contributions are welcome.Always happy if anyone wants to help to improve this package! 😊

</br>

## Feature requests

</br>

If you need any features Please open an issue so that we can discuss your feature request 🙏

</br>

---

</br>

Made with 💙 in Togo.
