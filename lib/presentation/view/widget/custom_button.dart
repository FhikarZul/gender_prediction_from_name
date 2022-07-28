import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final GestureTapCallback? onPressed;
  final Color colors;
  final bool? enabled;
  final double? width;

  const CustomButton({
    Key? key,
    required this.label,
    this.onPressed,
    required this.colors,
    this.enabled = true,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: enabled! ? colors : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: !enabled! ? null : onPressed,
        child: Container(
          width: width ?? double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
