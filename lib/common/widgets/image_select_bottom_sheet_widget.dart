import 'dart:ui';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
// use

/*

 IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (cnt) {
                        return ImageSelectBottomSheetWidget(
                          onCameraTap: () {
                            Navigator.pop(cnt);
                            log("camera");
                          },
                          onGalleryTap: () {
                            Navigator.pop(cnt);
                            log("gallery");
                          },
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.abc,
                  )),
 */

class ImageSelectBottomSheetWidget extends StatelessWidget {
  final void Function() onCameraTap;
  final void Function() onGalleryTap;
  const ImageSelectBottomSheetWidget({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
        bottom: 60,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onCameraTap,
            child: DottedBorderContainer(
              borderColor: appColors.primaryBlueColor,
              borderRadius: 9,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: appColors.primaryBlueColor,
                  size: 60,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onGalleryTap,
            child: DottedBorderContainer(
              borderColor: appColors.primaryBlueColor,
              borderRadius: 9,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.file_copy_outlined,
                  color: appColors.primaryBlueColor,
                  size: 60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DottedBorderContainer extends StatelessWidget {
  final Color borderColor;
  final Widget child;
  final double borderRadius;
  final double? strokeWidth;
  const DottedBorderContainer(
      {super.key,
      required this.borderColor,
      required this.child,
      required this.borderRadius,
      this.strokeWidth});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBorderPainter(
          borderColor: borderColor,
          borderRadius: borderRadius,
          strokeWidth: strokeWidth),
      child: child,
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderRadius;
  final double? strokeWidth;
  DottedBorderPainter({
    super.repaint,
    required this.borderColor,
    required this.borderRadius,
    this.strokeWidth,
  });
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final radius = borderRadius;
    final borderRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(borderRect, Radius.circular(radius)));
    drawDottedLine(canvas, path, paint, strokeWidth);
  }

  void drawDottedLine(
    Canvas canvas,
    Path path,
    Paint paint,
    double? strokeWidth,
  ) {
    // const double dashWidth = 2.0;
    // const double dashSpace = 3.0;
    double dashWidth = strokeWidth ?? 5.0;
    const double dashSpace = 3.0;
    double distance = 0.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
      distance = 0.0;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ImageAndPdfSelectBottomSheetWidget extends StatelessWidget {
  final void Function() onPdfTap;
  final void Function() onGalleryTap;
  const ImageAndPdfSelectBottomSheetWidget({
    super.key,
    required this.onPdfTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
        bottom: 60,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onGalleryTap,
            child: DottedBorderContainer(
              borderColor: appColors.primaryBlueColor,
              borderRadius: 9,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.file_copy_outlined,
                  color: appColors.primaryBlueColor,
                  size: 60,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onPdfTap,
            child: DottedBorderContainer(
              borderColor: appColors.primaryBlueColor,
              borderRadius: 9,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.picture_as_pdf_outlined,
                  color: appColors.primaryBlueColor,
                  size: 60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
