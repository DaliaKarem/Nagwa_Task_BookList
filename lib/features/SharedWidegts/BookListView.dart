import 'package:booklist/core/appColors.dart';
import 'package:booklist/features/data/Book_State.dart';
import 'package:flutter/material.dart';

import '../model/BookModel.dart';
class Booklistview extends StatelessWidget {
  const Booklistview({super.key, required this.list});
  final List<BookModel> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final book = list[index];
        return BookListItem(book: book);
      },
    );
  }
}

class BookListItem extends StatefulWidget {
  final BookModel book;

  const BookListItem({super.key, required this.book});

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Cover Image
                  Container(
                    width: 80,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: appColor.background,
                    ),
                    child: widget.book.formats?.imageJpeg != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.book.formats!.imageJpeg!,
                        width: 80,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                      ),
                    )
                        : const Center(child: Icon(Icons.book, size: 40)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        if (widget.book.authors.isNotEmpty)
                          Text(
                            'By ${widget.book.authors.map((a) => a.name).join(', ')}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: appColor.greyText,
                            ),
                          ),
                         SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.download, size: 16, color:appColor.greyText ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.book.downloadCount ?? 0} downloads',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: appColor.greyText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              if (widget.book.subjects != null && widget.book.subjects!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  widget.book.subjects!.join('\n'),
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: isExpanded ? null : 3,
                  overflow: isExpanded ? null : TextOverflow.ellipsis,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'Show Less' : 'Show More',
                      style: TextStyle(
                        color: appColor.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}