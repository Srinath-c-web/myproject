import 'package:flutter/material.dart';
import '../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  final VoidCallback? onBookmark;
  final bool bookmarked;

  const EventCard({super.key, required this.event, required this.onTap, this.onBookmark, this.bookmarked = false});

  Color _categoryColor(BuildContext context) {
    switch (event.category) {
      case 'Sports': return Colors.green;
      case 'Cultural': return Colors.orange;
      case 'Workshop': return Colors.deepPurple;
      case 'Hackathon': return Colors.blue;
      default: return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _categoryColor(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color: Colors.grey.shade200)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 82, height: 82,
                decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(14)),
                child: Icon(_iconForCategory(event.category), color: color, size: 34),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(event.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                const SizedBox(height: 6),
                Text('${event.date.day} ${_month(event.date.month)} • ${event.time}', style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                const SizedBox(height: 4),
                Text(event.venue, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                const SizedBox(height: 7),
                Wrap(spacing: 5, children: event.tags.take(2).map((t) => Chip(label: Text(t, style: const TextStyle(fontSize: 10)), padding: EdgeInsets.zero, visualDensity: VisualDensity.compact)).toList()),
              ])),
              IconButton(onPressed: onBookmark, icon: Icon(bookmarked ? Icons.favorite : Icons.favorite_border, color: bookmarked ? Colors.red : Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForCategory(String c) => switch (c) {
    'Sports' => Icons.sports_cricket,
    'Workshop' => Icons.school,
    'Hackathon' => Icons.code,
    'Cultural' => Icons.theater_comedy,
    _ => Icons.terminal,
  };

  String _month(int m) => const ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m - 1];
}
