import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/age_screen.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_height_column.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/cutom_positioned_arrow.dart';
class HeightWheelPicker extends StatefulWidget {
  static String id = "tallscren";

  @override
  _HeightWheelPickerState createState() => _HeightWheelPickerState();
}

class _HeightWheelPickerState extends State<HeightWheelPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColorScaffoldBoarding,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: AppColor.overlayBackgroundGrey),
          ),
          const CustomHeightColumn(),
         CustomPositionedArrow(onPressed: (){
                            Navigator.pushNamed(context, AgeScreen.id);

         })
        ],
      ),
    );
  }
}
