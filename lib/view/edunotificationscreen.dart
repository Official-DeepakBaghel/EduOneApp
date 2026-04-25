import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EduNotificationScreen extends StatefulWidget {
  const EduNotificationScreen({super.key});

  @override
  State<EduNotificationScreen> createState() => _EduNotificationScreenState();
}

class _EduNotificationScreenState extends State<EduNotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<_NotificationItem> _allNotifications = [
    _NotificationItem(
      id: '1',
      title: 'Assignment Due',
      body: 'Your Math assignment is due tomorrow at 11:59 PM.',
      time: '2 min ago',
      type: NotifType.assignment,
      isRead: false,
    ),
    _NotificationItem(
      id: '2',
      title: 'New Note Available',
      body: 'Physics Chapter 5 notes have been uploaded by your teacher.',
      time: '15 min ago',
      type: NotifType.note,
      isRead: false,
    ),
    _NotificationItem(
      id: '3',
      title: 'Class Cancelled',
      body: 'Chemistry lecture for today has been cancelled.',
      time: '1 hr ago',
      type: NotifType.announcement,
      isRead: true,
    ),
    _NotificationItem(
      id: '4',
      title: 'Result Published',
      body: 'Mid-term results for Computer Science are now available.',
      time: '3 hrs ago',
      type: NotifType.result,
      isRead: true,
    ),
    _NotificationItem(
      id: '5',
      title: 'New Playlist Added',
      body: 'Calculus video playlist has been added to EduNotes Hub.',
      time: 'Yesterday',
      type: NotifType.note,
      isRead: true,
    ),
    _NotificationItem(
      id: '6',
      title: 'Holiday Notice',
      body: 'College will remain closed on Monday due to national holiday.',
      time: '2 days ago',
      type: NotifType.announcement,
      isRead: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<_NotificationItem> get _unread =>
      _allNotifications.where((n) => !n.isRead).toList();

  List<_NotificationItem> _forTab(int index) {
    if (index == 0) return List.from(_allNotifications);
    if (index == 1) return _unread;
    return _allNotifications.where((n) => n.isRead).toList();
  }

  void _markAllRead() {
    setState(() {
      for (var n in _allNotifications) {
        n.isRead = true;
      }
    });
  }

  void _dismiss(String id) {
    setState(() {
      _allNotifications.removeWhere((n) => n.id == id);
    });
  }

  void _markRead(String id) {
    setState(() {
      final n = _allNotifications.firstWhere((n) => n.id == id);
      n.isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _unread.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0821),
      appBar: AppBar(
        backgroundColor: const Color(0xFF130F2A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: Text(
                'Mark all read',
                style: GoogleFonts.outfit(
                  color: const Color(0xFFFAF2A0),
                  fontSize: 13,
                ),
              ),
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF9C27B0),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600),
          tabs: [
            const Tab(text: 'All'),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Unread'),
                  if (unreadCount > 0) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9C27B0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$unreadCount',
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Tab(text: 'Read'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(3, (tabIndex) {
          final items = _forTab(tabIndex);
          if (items.isEmpty) return _buildEmpty();
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _NotificationCard(
                item: item,
                onDismiss: () => _dismiss(item.id),
                onTap: () => _markRead(item.id),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1035),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF673AB7).withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_off_outlined,
              size: 52,
              color: Color(0xFF673AB7),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'All caught up!',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No notifications here.',
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ─── Notification Card ──────────────────────────────────────────────────────

class _NotificationCard extends StatelessWidget {
  final _NotificationItem item;
  final VoidCallback onDismiss;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.item,
    required this.onDismiss,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 26),
      ),
      onDismissed: (_) => onDismiss(),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: item.isRead
                ? const Color(0xFF130F2A)
                : const Color(0xFF1E1035),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: item.isRead
                  ? Colors.white10
                  : const Color(0xFF673AB7).withOpacity(0.5),
              width: 1.2,
            ),
            boxShadow: item.isRead
                ? []
                : [
                    BoxShadow(
                      color: const Color(0xFF673AB7).withOpacity(0.15),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon badge
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.type.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.type.icon, color: item.type.color, size: 22),
              ),
              const SizedBox(width: 14),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontWeight: item.isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (!item.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF9C27B0),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.body,
                      style: GoogleFonts.outfit(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.time,
                      style: GoogleFonts.outfit(
                        color: item.type.color.withOpacity(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Data Models ─────────────────────────────────────────────────────────────

enum NotifType { assignment, note, announcement, result }

extension NotifTypeExt on NotifType {
  IconData get icon {
    switch (this) {
      case NotifType.assignment:
        return Icons.assignment_outlined;
      case NotifType.note:
        return Icons.menu_book_outlined;
      case NotifType.announcement:
        return Icons.campaign_outlined;
      case NotifType.result:
        return Icons.emoji_events_outlined;
    }
  }

  Color get color {
    switch (this) {
      case NotifType.assignment:
        return const Color(0xFFFF7043);
      case NotifType.note:
        return const Color(0xFF42A5F5);
      case NotifType.announcement:
        return const Color(0xFFFAF2A0);
      case NotifType.result:
        return const Color(0xFF66BB6A);
    }
  }
}

class _NotificationItem {
  final String id;
  final String title;
  final String body;
  final String time;
  final NotifType type;
  bool isRead;

  _NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    required this.isRead,
  });
}
