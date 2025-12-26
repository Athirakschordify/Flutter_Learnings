export const usersAPI = {
    getAll: async () => {
        return Promise.resolve({
            success: true,
            data: [
                { id: 1, name: 'John Doe', email: 'john@email.com', tickets: 12, joined: '2024-01-15', status: 'active' },
                { id: 2, name: 'Sarah Smith', email: 'sarah@email.com', tickets: 8, joined: '2024-02-20', status: 'active' },
                { id: 3, name: 'Mike Johnson', email: 'mike@email.com', tickets: 15, joined: '2024-01-10', status: 'inactive' },
                { id: 4, name: 'Emily Davis', email: 'emily@email.com', tickets: 6, joined: '2024-03-05', status: 'active' },
            ],
        });
    },

    delete: async (id) => {
        return Promise.resolve({ success: true });
    },
};
