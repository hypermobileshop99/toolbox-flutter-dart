import 'package:flutter/material.dart';

import 'pagewise/flutter_pagewise.dart';

class PaginateListView<T> extends StatelessWidget {
  final ItemBuilder<T> itemBuilder;
  final PageFuture<T> pageFuture;
  final int pageSize;
  final EdgeInsetsGeometry padding;
  final PagewiseLoadController<T> pageLoadController;

  /// default is false
  ///
  /// set to true if the future will change.
  final bool mutable;

  const PaginateListView({
    Key key,
    @required this.itemBuilder,
    @required this.pageFuture,
    this.pageSize = 10,
    this.padding,
    this.mutable = false,
    this.pageLoadController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mutable || pageLoadController != null
        ? PagewiseListView(
            itemBuilder: itemBuilder,
            padding: padding,
            pageLoadController: pageLoadController ??
                PagewiseLoadController(
                  pageSize: pageSize,
                  pageFuture: (int pageIndex) => pageFuture(pageIndex + 1),
                ),
          )
        : PagewiseListView(
            pageSize: pageSize,
            itemBuilder: itemBuilder,
            pageFuture: (int pageIndex) => pageFuture(pageIndex + 1),
            padding: padding,
          );
  }
}
