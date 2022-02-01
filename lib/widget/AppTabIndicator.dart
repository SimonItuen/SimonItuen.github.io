import 'package:flutter/widgets.dart';

enum AppTabIndicatorSize {
  tiny,
  normal,
  full,
}

class AppTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final AppTabIndicatorSize indicatorSize;

  const AppTabIndicator(
      {required this.indicatorHeight,
        required this.indicatorColor,
        required this.indicatorSize});

  @override
  _AppTabPainter createBoxPainter([VoidCallback? onChanged]) {
    return new _AppTabPainter(this, onChanged!);
  }
}

class _AppTabPainter extends BoxPainter {
  final AppTabIndicator decoration;

  _AppTabPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    Rect rect = Rect.fromLTRB(0, 0, 0, 0);
    if (decoration.indicatorSize == AppTabIndicatorSize.full) {
      rect = Offset(offset.dx,
          (configuration.size!.height - decoration.indicatorHeight)) &
      Size(configuration.size!.width, decoration.indicatorHeight);
    } else if (decoration.indicatorSize == AppTabIndicatorSize.normal) {
      rect = Offset(offset.dx + 6,
          (configuration.size!.height - decoration.indicatorHeight)) &
      Size(configuration.size!.width - 12, decoration.indicatorHeight);
    } else if (decoration.indicatorSize == AppTabIndicatorSize.tiny) {
      rect = Offset(offset.dx + configuration.size!.width / 2 - 8,
          (configuration.size!.height - decoration.indicatorHeight)) &
      Size(16, decoration.indicatorHeight);
    }

    final Paint paint = Paint();
    paint.color = decoration.indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect,
            topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        paint);
  }
}
