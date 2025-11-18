import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    this.containerColor,
     this.containerText,
    required this.containerTextColor,
    this.containerBorderColor,
    required this.screenToOpen,
  });

  final Color? containerColor;
  final Color containerTextColor;
  final String? containerText;
  final Color? containerBorderColor;
  final Widget screenToOpen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screenToOpen),
          );
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(

                color: containerColor,
                border: Border.all(
                  color: containerBorderColor ?? Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                     Icon(
                      Icons.arrow_back_ios_new,
                      size: 22.sp,
                      color: Colors.red,
                    ),
                    Spacer(flex:10),
                    Text(
                      containerText!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: containerTextColor,

                      ),
                    ),
                    Spacer(flex:1),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
