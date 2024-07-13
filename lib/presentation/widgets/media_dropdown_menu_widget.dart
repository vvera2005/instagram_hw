import 'package:flutter/material.dart';
import '../../core/app_theme/enum/enum_media.dart';

class MediaDropDownWidget extends StatefulWidget {
  const MediaDropDownWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MediaDropDownWidgetState createState() => _MediaDropDownWidgetState();
}

class _MediaDropDownWidgetState extends State<MediaDropDownWidget> {
  MediaEnum _selectedMedia = MediaEnum.guide;
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;
  final GlobalKey _dropdownKey = GlobalKey();

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    final size = (_dropdownKey.currentContext!.findRenderObject()! as RenderBox).size;
    (_dropdownKey.currentContext!.findRenderObject()! as RenderBox).localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: MediaEnum.values.map((media) {
                return ListTile(
                  title: Text(media.toString().split('.').last),
                  onTap: () {
                    setState(() {
                      _selectedMedia = media;
                    });
                    _overlayEntry!.remove();
                    _overlayEntry = null;
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        key: _dropdownKey,
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_selectedMedia.toString().split('.').last),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
