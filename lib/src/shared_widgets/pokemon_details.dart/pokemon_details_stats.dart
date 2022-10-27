import 'package:flutter/material.dart';

import 'package:pokedex/src/core/constants/color_constants.dart';

import '../../../locator.dart';
import '../../core/utils/custom_textstyle.dart';

class PokemonStat extends StatelessWidget {
  const PokemonStat({Key? key, this.stat, this.statValue, this.valueColor = Colors.transparent}) : super(key: key);
  final String? stat;
  final num? statValue;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 18),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                stat!,
                style: locator<CustomTextStyle>()
                    .notoSansFont(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.color_0xff6B6B6B),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                statValue.toString(),
                style: locator<CustomTextStyle>()
                    .notoSansFont(fontSize: 14, fontWeight: FontWeight.bold, color: ColorConstants.color_0xff161A33),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: LinearProgressIndicator(
              backgroundColor: ColorConstants.color_0xffE8E8E8,
              value: (statValue?.toDouble() ?? 0) / 100,
              minHeight: 4,
              color: valueColor,
            ),
          )
        ],
      ),
    );
  }
}
