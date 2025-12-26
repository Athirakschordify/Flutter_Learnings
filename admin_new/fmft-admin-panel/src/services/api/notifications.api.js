export const notificationsAPI = {
    getAll: async () => {
        return Promise.resolve({
            success: true,
            data: [
                {
                    id: 1,
                    title: 'New user registered',
                    message: 'John Doe just signed up',
                    time: '5 minutes ago',
                    read: false,
                    type: 'user',
                    link: '/users',
                },
                {
                    id: 2,
                    title: 'Ticket sold',
                    message: 'Summer Festival ticket purchased',
                    time: '1 hour ago',
                    read: false,
                    type: 'ticket',
                    link: '/tickets',
                },
                {
                    id: 3,
                    title: 'Payment received',
                    message: '$299 payment confirmed',
                    time: '2 hours ago',
                    read: true,
                    type: 'payment',
                    link: '/tickets',
                },
            ],
        });
    },

    markAsRead: async (id) => {
        return Promise.resolve({ success: true });
    },

    markAllAsRead: async () => {
        return Promise.resolve({ success: true });
    },
};
