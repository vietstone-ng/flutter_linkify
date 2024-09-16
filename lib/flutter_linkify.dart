import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/theme_map.dart';
import 'package:highlighter/highlighter.dart';
import 'package:linkify/linkify.dart';

export 'package:linkify/linkify.dart'
    show
        LinkifyElement,
        LinkifyOptions,
        LinkableElement,
        TextElement,
        Linkifier,
        UrlElement,
        UrlLinkifier,
        EmailElement,
        EmailLinkifier;

final _codeTheme = themeMap['a11y-light'] ?? {};
const _defaultFontFamily = 'monospace';
const _rootKey = 'root';
const _defaultFontColor = Color(0xff000000);
const _defaultBackgroundColor = Color(0xffffffff);

/// Callback clicked link
typedef LinkCallback = void Function(LinkableElement link);

/// Turns URLs into links
class Linkify extends StatelessWidget {
  /// Text to be linkified
  final String text;

  /// Linkifiers to be used for linkify
  final List<Linkifier> linkifiers;

  /// Callback for tapping a link
  final LinkCallback? onOpen;

  /// linkify's options.
  final LinkifyOptions options;

  // TextSpan

  /// Style for non-link text
  final TextStyle? style;

  /// Style of link text
  final TextStyle? linkStyle;

  // Text.rich

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// Text direction of the text
  final TextDirection? textDirection;

  /// The maximum number of lines for the text to span, wrapping if necessary
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel
  final double textScaleFactor;

  /// Whether the text should break at soft line breaks.
  final bool softWrap;

  /// The strut style used for the vertical layout
  final StrutStyle? strutStyle;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale
  final Locale? locale;

  /// Defines how to measure the width of the rendered text.
  final TextWidthBasis textWidthBasis;

  /// Defines how the paragraph will apply TextStyle.height to the ascent of the first line and descent of the last line.
  final TextHeightBehavior? textHeightBehavior;

  final bool useMouseRegion;

  final String? codeThemeKey;

  const Linkify({
    Key? key,
    required this.text,
    this.linkifiers = defaultLinkifiers,
    this.onOpen,
    this.options = const LinkifyOptions(),
    // TextSpan
    this.style,
    this.linkStyle,
    // RichText
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.softWrap = true,
    this.strutStyle,
    this.locale,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.useMouseRegion = true,
    this.codeThemeKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elements = linkify(
      text,
      options: options,
      linkifiers: linkifiers,
    );

    return Text.rich(
      buildTextSpan(
        elements,
        style: style ?? Theme.of(context).textTheme.bodyMedium,
        onOpen: onOpen,
        useMouseRegion: useMouseRegion,
        linkStyle: (style ?? Theme.of(context).textTheme.bodyMedium)
            ?.copyWith(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            )
            .merge(linkStyle),
        codeThemeKey: codeThemeKey,
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      softWrap: softWrap,
      strutStyle: strutStyle,
      locale: locale,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}

/// Turns URLs into links
class SelectableLinkify extends StatelessWidget {
  /// Text to be linkified
  final String text;

  /// The number of font pixels for each logical pixel
  final double textScaleFactor;

  /// Linkifiers to be used for linkify
  final List<Linkifier> linkifiers;

  /// Callback for tapping a link
  final LinkCallback? onOpen;

  /// linkify's options.
  final LinkifyOptions options;

  // TextSpan

  /// Style for non-link text
  final TextStyle? style;

  /// Style of link text
  final TextStyle? linkStyle;

  // Text.rich

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// Text direction of the text
  final TextDirection? textDirection;

  /// The minimum number of lines to occupy when the content spans fewer lines.
  final int? minLines;

  /// The maximum number of lines for the text to span, wrapping if necessary
  final int? maxLines;

  /// The strut style used for the vertical layout
  final StrutStyle? strutStyle;

  /// Defines how to measure the width of the rendered text.
  final TextWidthBasis? textWidthBasis;

  // SelectableText.rich

  /// Defines the focus for this widget.
  final FocusNode? focusNode;

  /// Whether to show cursor
  final bool showCursor;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Builds the text selection toolbar when requested by the user
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// How thick the cursor will be
  final double cursorWidth;

  /// How rounded the corners of the cursor should be
  final Radius? cursorRadius;

  /// The color to use when painting the cursor
  final Color? cursorColor;

  /// Determines the way that drag start behavior is handled
  final DragStartBehavior dragStartBehavior;

  /// If true, then long-pressing this TextField will select text and show the cut/copy/paste menu,
  /// and tapping will move the text caret
  final bool enableInteractiveSelection;

  /// Called when the user taps on this selectable text (not link)
  final GestureTapCallback? onTap;

  final ScrollPhysics? scrollPhysics;

  /// Defines how the paragraph will apply TextStyle.height to the ascent of the first line and descent of the last line.
  final TextHeightBehavior? textHeightBehavior;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// Optional delegate for building the text selection handles and toolbar.
  final TextSelectionControls? selectionControls;

  /// Called when the user changes the selection of text (including the cursor location).
  final SelectionChangedCallback? onSelectionChanged;

  final bool useMouseRegion;

  final String? codeThemeKey;

  const SelectableLinkify(
      {Key? key,
      required this.text,
      this.linkifiers = defaultLinkifiers,
      this.onOpen,
      this.options = const LinkifyOptions(),
      // TextSpan
      this.style,
      this.linkStyle,
      // RichText
      this.textAlign,
      this.textDirection,
      this.minLines,
      this.maxLines,
      // SelectableText
      this.focusNode,
      this.textScaleFactor = 1.0,
      this.strutStyle,
      this.showCursor = false,
      this.autofocus = false,
      this.contextMenuBuilder,
      this.cursorWidth = 2.0,
      this.cursorRadius,
      this.cursorColor,
      this.dragStartBehavior = DragStartBehavior.start,
      this.enableInteractiveSelection = true,
      this.onTap,
      this.scrollPhysics,
      this.textWidthBasis,
      this.textHeightBehavior,
      this.cursorHeight,
      this.selectionControls,
      this.onSelectionChanged,
      this.useMouseRegion = false,
      this.codeThemeKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elements = linkify(
      text,
      options: options,
      linkifiers: linkifiers,
    );

    return SelectableText.rich(
      buildTextSpan(
        elements,
        style: style ?? Theme.of(context).textTheme.bodyMedium,
        onOpen: onOpen,
        linkStyle: (style ?? Theme.of(context).textTheme.bodyMedium)
            ?.copyWith(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            )
            .merge(linkStyle),
        useMouseRegion: useMouseRegion,
        codeThemeKey: codeThemeKey,
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      minLines: minLines,
      maxLines: maxLines,
      focusNode: focusNode,
      strutStyle: strutStyle,
      showCursor: showCursor,
      textScaleFactor: textScaleFactor,
      autofocus: autofocus,
      contextMenuBuilder: contextMenuBuilder,
      cursorWidth: cursorWidth,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      onTap: onTap,
      scrollPhysics: scrollPhysics,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      cursorHeight: cursorHeight,
      selectionControls: selectionControls,
      onSelectionChanged: onSelectionChanged,
    );
  }
}

class LinkableSpan extends WidgetSpan {
  LinkableSpan({
    required MouseCursor mouseCursor,
    required InlineSpan inlineSpan,
  }) : super(
          child: MouseRegion(
            cursor: mouseCursor,
            child: Text.rich(
              inlineSpan,
            ),
          ),
        );
}

/// Raw TextSpan builder for more control on the RichText
TextSpan buildTextSpan(
  List<LinkifyElement> elements, {
  TextStyle? style,
  TextStyle? linkStyle,
  LinkCallback? onOpen,
  bool useMouseRegion = false,
  String? codeThemeKey,
}) =>
    TextSpan(
      children: buildTextSpanChildren(
        elements,
        style: style,
        linkStyle: linkStyle,
        onOpen: onOpen,
        useMouseRegion: useMouseRegion,
        codeThemeKey: codeThemeKey,
      ),
    );

/// Raw TextSpan builder for more control on the RichText
List<InlineSpan>? buildTextSpanChildren(
  List<LinkifyElement> elements, {
  TextStyle? style,
  TextStyle? linkStyle,
  LinkCallback? onOpen,
  bool useMouseRegion = false,
  String? codeThemeKey,
}) {
  List<InlineSpan> children = [];
  for (var element in elements) {
    if (element is LinkableElement) {
      children.add(TextSpan(
        text: element.text,
        style: linkStyle,
        recognizer: onOpen != null
            ? (TapGestureRecognizer()..onTap = () => onOpen(element))
            : null,
        mouseCursor: useMouseRegion ? SystemMouseCursors.click : null,
      ));
    } else if (element is CodeBlockElement) {
      final codeTheme = themeMap[codeThemeKey] ?? _codeTheme;
      final bgColor =
          codeTheme[_rootKey]?.backgroundColor ?? _defaultBackgroundColor;
      var textStyle = TextStyle(
        fontFamily: _defaultFontFamily,
        color: codeTheme[_rootKey]?.color ?? _defaultFontColor,
        backgroundColor: bgColor,
      );

      final source = element.code;
      final language = element.language;

      if (element.isTripleBackticks) {
        // generate a code block with triple backticks
        children.add(WidgetSpan(
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: RichText(
              text: TextSpan(
                style: textStyle,
                children: _convert(
                  highlight
                      .parse(source, language: language, autoDetection: true)
                      .nodes!,
                ),
              ),
            ),
          ),
        ));
      } else {
        // generate inline code, add 2 spaces before and after
        children.add(TextSpan(
          style: textStyle,
          children: [
            TextSpan(text: '\u00A0', style: textStyle),
            ..._convert(
                highlight
                    .parse(source, language: language, autoDetection: true)
                    .nodes!,
                parentStyle: textStyle),
            TextSpan(text: '\u00A0', style: textStyle),
          ],
        ));
      }
    } else if (element is TextElement) {
      children.add(TextSpan(
        text: element.text,
        style: style,
      ));
    }
  }
  return children;
}

List<TextSpan> _convert(List<Node> nodes, {TextStyle? parentStyle}) {
  List<TextSpan> spans = [];
  var currentSpans = spans;
  List<List<TextSpan>> stack = [];

  traverse(Node node) {
    var inlineStyle =
        node.className == null ? null : _codeTheme[node.className!];
    TextStyle? style;
    if (parentStyle != null) {
      style = parentStyle.merge(inlineStyle);
    } else {
      style = inlineStyle;
    }

    if (node.value != null) {
      currentSpans.add(TextSpan(text: node.value, style: style));
    } else if (node.children != null) {
      List<TextSpan> tmp = [];
      currentSpans.add(TextSpan(children: tmp, style: style));
      stack.add(currentSpans);
      currentSpans = tmp;

      for (var n in node.children!) {
        traverse(n);
        if (n == node.children!.last) {
          currentSpans = stack.isEmpty ? spans : stack.removeLast();
        }
      }
    }
  }

  for (var node in nodes) {
    traverse(node);
  }

  return spans;
}

class LinkifySpan extends TextSpan {
  LinkifySpan({
    required String text,
    TextStyle? linkStyle,
    LinkCallback? onOpen,
    LinkifyOptions options = const LinkifyOptions(),
    List<Linkifier> linkifiers = defaultLinkifiers,
    bool useMouseRegion = false,
    super.style,
    super.recognizer,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.semanticsLabel,
    super.locale,
    super.spellOut,
  }) : super(
          children: buildTextSpanChildren(
            linkify(text, options: options, linkifiers: linkifiers),
            style: style,
            linkStyle: linkStyle,
            onOpen: onOpen,
            useMouseRegion: useMouseRegion,
          ),
        );
}
