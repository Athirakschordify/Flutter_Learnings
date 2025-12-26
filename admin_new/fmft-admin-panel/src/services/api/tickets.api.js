export const ticketsAPI = {
    getAll: async () => {
        return Promise.resolve({
            success: true,
            data: [
                { id: 1, event: 'Summer Music Festival', user: 'John Doe', date: '2024-07-20', status: 'active', amount: 150 },
                { id: 2, event: 'Tech Conference 2024', user: 'Sarah Smith', date: '2024-06-15', status: 'active', amount: 299 },
                { id: 3, event: 'Comedy Night', user: 'Mike Johnson', date: '2024-05-10', status: 'expired', amount: 45 },
                { id: 4, event: 'Food & Wine Expo', user: 'Emily Davis', date: '2024-08-12', status: 'active', amount: 75 },
            ],
        });
    },

    delete: async (id) => {
        return Promise.resolve({ success: true });
    },
};
