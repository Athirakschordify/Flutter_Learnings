import apiClient from './apiClient'

export const login = async (credentials) => {
    // Replace with actual API endpoint
    // const response = await apiClient.post('/auth/login', credentials)
    // return response.data

    // Mocking for now
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve({
                user: { id: 1, name: 'Admin', email: credentials.email },
                token: 'mock-jwt-token',
            })
        }, 1000)
    })
}

export const logoutApi = async () => {
    // await apiClient.post('/auth/logout')
}
