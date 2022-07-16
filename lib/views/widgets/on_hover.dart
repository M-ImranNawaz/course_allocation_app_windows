import 'package:fluent_ui/fluent_ui.dart';

class OnHover extends StatefulWidget {
  const OnHover({Key? key, required this.child, required this.index})
      : super(key: key);
  final Widget child;
  final index;
  //final Widget Function(bool isHovered) builder;
  @override
  State<OnHover> createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.005);
    // final hoveredTransform = Matrix4.identity()
    //   ..translate(8, 0, 0)
    //   ..scale(1.2);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: /* Animated */ Container(
        alignment: Alignment.bottomCenter,
        color: isHovered
            ? const Color.fromARGB(248, 232, 252, 237)
            : widget.index % 2 == 0
                ? Colors.transparent
                : const Color.fromARGB(255, 236, 236, 236),
        //duration: const Duration(milliseconds: 1),
        //clipBehavior: Clip.antiAliasWithSaveLayer,
        //transform: transform,
        child: widget.child,
      ),
    );
  }

  onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}
