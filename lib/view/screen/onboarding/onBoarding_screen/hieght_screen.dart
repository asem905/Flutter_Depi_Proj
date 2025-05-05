import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/Routes/route.dart';
import 'package:flutter_application_depi/constants/color.dart';
import 'package:flutter_application_depi/view/screen/onboarding/custom_onboarding_widgets/custom_buttons.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_height_column.dart';

class HeightWheelPicker extends StatefulWidget {

  @override
  _HeightWheelPickerState createState() => _HeightWheelPickerState();
}

class _HeightWheelPickerState extends State<HeightWheelPicker> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    return Scaffold(
      backgroundColor: AppColor.primaarybg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.03,
          ),
          child: Column(
            children: [
              SizedBox(height: height * 0.05),
              const Expanded(child: CustomHeightColumn()),
              CustomRowButton(
                     onBack: (){
                                       Navigator.of(context).pop();
 
                },
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.age);
                  },
                  width: width,
                  height: height),
            ],
          ),
        ),
      ),
    );
  }
}
