import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/components/button_bar/gf_button_bar.dart';
import 'package:ui_kit/components/header_bar/gf_title_bar.dart';
import 'package:ui_kit/components/image/gf_image_overlay.dart';
import 'package:ui_kit/position/gf_position.dart';

enum GFCardType { basic, social, image}

class GFCard extends StatelessWidget {

  const GFCard({
    Key key,
    this.color,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.padding = const EdgeInsets.all(12.0),
    this.margin,
    this.clipBehavior,
    this.semanticContainer,
    this.title,
    this.content,
    this.image,
    this.buttonBar,
    this.imageOverlay,
    this.titlePosition,
    this.borderRadius,
    this.border,
    this.boxFit,
    this.colorFilter
  }) : assert(elevation == null || elevation >= 0.0),
        assert(borderOnForeground != null),
        super(key: key);

  /// [GFPosition] titlePosition helps to set titlebar at top of card
  final GFPosition titlePosition;

  /// The card's background color.
  final Color color;

  /// The z-coordinate at which to place this card. This controls the size of the shadow below the card.
  final double elevation;

  /// The shape of the card's [Material].
  final ShapeBorder shape;

  /// Whether to paint the [shape] border in front of the [child].
  final bool borderOnForeground;

  /// If this property is null then [ThemeData.cardTheme.clipBehavior] is used.
  final Clip clipBehavior;

  /// The empty space that surrounds the card. Defines the card's outer [Container.margin].
  final EdgeInsetsGeometry margin;

  /// The empty space that surrounds the card. Defines the card's outer [Container.margin]..
  final EdgeInsetsGeometry padding;

  /// Whether this widget represents a single semantic container, or if false
  /// a collection of individual semantic nodes.
  final bool semanticContainer;

  /// The title to display inside the [GFTitleBar]. see [GFTitleBar]
  final GFTitleBar title;

  /// widget can be used to define content
  final Widget content;

  /// image widget can be used
  final Image image;

  /// overlay image [GFImageOverlay] widget can be used
  final ImageProvider imageOverlay;

  /// widget can be used to define buttons bar, see [GFButtonBar]
  final GFButtonBar buttonBar;

  /// How the image should be inscribed into the box.
  /// The default is [BoxFit.scaleDown] if [centerSlice] is null, and
  /// [BoxFit.fill] if [centerSlice] is not null.
  final BoxFit boxFit;

  /// A color filter to apply to the image before painting it.
  final ColorFilter colorFilter;

  /// The corners of this [GFCard] are rounded by this [BorderRadius].
  final BorderRadiusGeometry borderRadius;

  /// A border to draw above the [GFCard].
  final Border border;

  static const double _defaultElevation = 1.0;
  static const Clip _defaultClipBehavior = Clip.none;

  @override
  Widget build(BuildContext context) {
    final CardTheme cardTheme = CardTheme.of(context);

    Widget cardChild = Column(
      children: <Widget>[
        titlePosition == GFPosition.start ? title != null ? title : Container() : image != null ? ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
          child: image,
        ): Container(),
        titlePosition == GFPosition.start ? image != null ? image : Container(): title != null ? title : Container(),
        Padding(
          padding: padding,
          child: content,
        ),
        buttonBar,
      ],
    );

    Widget overlayImage = GFImageOverlay(
      width: MediaQuery.of(context).size.width,
      child: cardChild,
      color: color ?? cardTheme.color ?? Theme.of(context).cardColor,
      image: imageOverlay,
      boxFit: boxFit,
      colorFilter: colorFilter,
      border: border,
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(4.0)),
    );

    return Container(
      margin: margin ?? cardTheme.margin ?? const EdgeInsets.all(16.0),
      child: Material(
        type: MaterialType.card,
        color: color ?? cardTheme.color ?? Theme.of(context).cardColor,
        elevation: elevation ?? cardTheme.elevation ?? _defaultElevation,
        shape: shape ?? cardTheme.shape ?? const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        borderOnForeground: borderOnForeground,
        clipBehavior: clipBehavior ?? cardTheme.clipBehavior ?? _defaultClipBehavior,
        child: imageOverlay == null ? cardChild : overlayImage
      ),
    );
  }
}


