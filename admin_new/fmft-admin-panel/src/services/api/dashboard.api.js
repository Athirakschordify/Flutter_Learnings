export const dashboardAPI = {
    getStats: async () => {
        return Promise.resolve({
            success: true,
            data: {
                totalUsers: 12543,
                activeTickets: 8921,
                totalRevenue: 245680,
                emailsScanned: 45230,
            },
        });
    },

    getRecentActivity: async () => {
        return Promise.resolve({
            success: true,
            data: [
                { id: 1, user: 'John Doe', action: 'Created new ticket', time: '2 hours ago' },
                { id: 2, user: 'Sarah Smith', action: 'Updated profile', time: '3 hours ago' },
                { id: 3, user: 'Mike Johnson', action: 'Purchased ticket', time: '5 hours ago' },
                { id: 4, user: 'Emily Davis', action: 'Left a review', time: '6 hours ago' },
            ],
        });
    },

    getUpcomingEvents: async () => {
        return Promise.resolve({
            success: true,
            data: [
                { id: 1, event: 'Summer Music Festival', date: '2024-07-20', amount: 150 },
                { id: 2, event: 'Tech Conference 2024', date: '2024-06-15', amount: 299 },
                { id: 3, event: 'Comedy Night', date: '2024-05-10', amount: 45 },
                { id: 4, event: 'Food & Wine Expo', date: '2024-08-12', amount: 75 },
            ],
        });
    },
};
