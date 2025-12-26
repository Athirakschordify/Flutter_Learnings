export const authAPI = {
    login: async (credentials) => {
        // Mock API
        return new Promise((resolve) => {
            setTimeout(() => {
                resolve({
                    success: true,
                    data: {
                        token: 'mock_token_' + Date.now(),
                        user: {
                            id: 1,
                            email: credentials.email,
                            name: 'Admin User',
                            role: 'admin',
                        },
                    },
                });
            }, 1000);
        });
    },

    logout: async () => {
        return Promise.resolve({ success: true });
    },
};
