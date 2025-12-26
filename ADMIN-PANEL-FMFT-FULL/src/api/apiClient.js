/**
 * @file apiClient.js
 * @description Centralized Axios instance configuration with global interceptors.
 */

import axios from 'axios'
import { toast } from 'sonner'

/**
 * Axios instance with base configuration.
 * @type {import('axios').AxiosInstance}
 */
const apiClient = axios.create({
    baseURL: import.meta.env.VITE_API_URL || 'https://api.example.com',
    headers: {
        'Content-Type': 'application/json',
    },
})

/**
 * Request Interceptor:
 * Attaches the Bearer token from localStorage to every request if it exists.
 */
apiClient.interceptors.request.use((config) => {
    const token = localStorage.getItem('token')
    if (token) {
        config.headers.Authorization = `Bearer ${token}`
    }
    return config
})

/**
 * Response Interceptor:
 * Handles global success and failure states.
 * - 401: Automatically logs out the user and redirects to login on session expiry.
 * - Other Errors: Displays a descriptive toast notification.
 */
apiClient.interceptors.response.use(
    (response) => response,
    (error) => {
        const message = error.response?.data?.message || error.message || 'Something went wrong'

        if (error.response?.status === 401) {
            toast.error('Session expired. Please login again.')
            localStorage.clear()
            window.location.href = '/login'
        } else {
            toast.error(message)
        }

        return Promise.reject(error)
    }
)

export default apiClient
