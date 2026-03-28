class Conversation {
  final int id;
  final String name;
  final String avatar;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final bool isUnread;

  Conversation({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.isUnread,
  });
}

final List<Conversation> conversationsData = [
  Conversation(
    id: 1,
    name: 'أحمد العتيبي',
    avatar:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBD7QzxS4N4elj8ejYMHvvU2--FLvfsacCdVQGMug5KNpcQba7qEm02NaRhY8Zb4aicFG4Vdzd3xzGA0VPE3wJ7rhxFhIh4byf0z1GO70pZ6o3wuZc27vpqwrirl3kQ0texCflkboaG6Ig0XNCkgp8k2SnpGJL2ax1NHtTEXbaUYHBzz4UbHvjR9BVCaAo3XWRBujA5IFvyWPzlsp-YxaX3N3htQNHGELDwDzYqUj1dJSxH5ZMBZmiEJuS1EEuqtlsIfJ5kcNwDv2s',
    lastMessage: 'بكم السعر النهائي للسيارة؟ صامل جداً',
    time: 'منذ ٥ دقائق',
    unreadCount: 2,
    isOnline: true,
    isUnread: true,
  ),
  Conversation(
    id: 2,
    name: 'شركة العقارات المميزة',
    avatar:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDnzvBo8VBbRg_PBouAQulOq0Bue5U-zkXOa7udabWZ2v7RBrKzbpeczANsF2nvrGdlYP6IPkx_SsrQurbxWSvajNklJ6urmz6NqaX74cqo1069QkSDzKiXMpbr-fe97G5IzO4H7aDEIHusZxq9-rj8jkVOfZ5Sqt9fAXpERuadO9tY5nniB5EcvGMq-18D_RjFzg-DO5YQtwpr7lq35XHYW9Dh4qI2JWlA2EW2zHOzuiu5IAX5iS9pqNaJRB-p9HzfTroMCniYl24',
    lastMessage: 'تم استلام طلبك لمعاينة الشقة، سنقوم بالتواصل معك قريباً.',
    time: 'أمس',
    unreadCount: 0,
    isOnline: false,
    isUnread: false,
  ),
  Conversation(
    id: 3,
    name: 'صالح محمد',
    avatar:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDKtCQ6ojS2Mdfl43oueKYAuPxUzUcLFyvXy00yGocLprOF6gFwqgL2DHyYpAmYpSf0R_YTIRnRUBOfM2g0gdUrc8l9njbqvhiQZx4sOnU8VK-988P9sTMVhRNrkuZutb7FKEQ5RarukJEko8AY0kXxmavUC9rkopXr0wG13K1xFaq5InTYr4gJK_pa-75vjIAs1l93KNHMJixS8chUn1jyVWqYiY0q6_kVrJZ1Br2fexATEydItJOY0YjUd7y5wTsKXutW244Sq2A',
    lastMessage: 'أرسل لي الموقع لو سمحت',
    time: '١٠:٣٠ ص',
    unreadCount: 1,
    isOnline: true,
    isUnread: true,
  ),
  Conversation(
    id: 4,
    name: 'ليلى الحربي',
    avatar:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDLWHSmb06WTda_7QKviLJ4FdLFhl1tB0AJt8u2CCNYnq2ixse2QQL1aw2C37bG7y1mpfDNQeYN4wGZGBpirPfNbhr4L0DqOvlYRQSJoVvSr72DfLAvCapZwEiYX53D2ejoqUY2EWmfqF2EJhS4n9RZfFO41Jes8M_2JCoyvaAlbAUAZqCs13PtcM4IQN3roDOeobS7BT9jqM3o1IP8UidU8_mCGDeOXKhnK9DT9O9Q5wQV9mSLaqQxKwMLEGkDaQncQ16dBeWfCsk',
    lastMessage: 'هل الجهاز لا يزال تحت الضمان؟',
    time: '١٤ أكتوبر',
    unreadCount: 0,
    isOnline: false,
    isUnread: false,
  ),
  Conversation(
    id: 5,
    name: 'فهد بن خالد',
    avatar:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD-UExF3E2q8MbNhUEl7KgmIrXvmP5sEm7dxaE_sOCafP2yDEJw7LT1R4heBuA0Ppdn-O_2ti9DeheVJtZIAedxrrHi7_DEq6_kkUTq-RHsjA2qvDktPgiTH6pjT9088-9ZoQ3WtqdyBZfUDcci4Uztsl6h80j_THXBb5em1efoETQAejYNL89HAfbZBmFLQWs2yi8-_6clw2LehK0L1enjYCc2jwWuaZHFQ8CXrz45j8t4DWj8dX48NoOPHu4njdcaN5X4zmrpSqY',
    lastMessage: 'تم البيع يا غالي، الله يبارك للمشتري',
    time: '١٢ أكتوبر',
    unreadCount: 0,
    isOnline: false,
    isUnread: false,
  ),
];
