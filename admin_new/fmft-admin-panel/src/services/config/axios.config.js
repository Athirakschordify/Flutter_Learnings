import axios from 'axios';
import { API_URL, API_TIMEOUT, HTTP_STATUS, IS_DEV } from '@/constants';
import { getAuthToken, removeAuthToken } from '@/utils/auth';
import { showAlert } from '@/lib/sweetalert';

const apiClient = axios.create({
    baseURL: API_URL,
    timeout: API_TIMEOUT,
    headers: {
        'Content-Type': 'application/json',
    },
});

apiClient.interceptors.request.use(
    (config) => {
        const token = getAuthToken();
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
        }
        if (IS_DEV) {
            console.log('📤 Request:', config.method?.toUpperCase(), config.url);
        }
        return config;
    },
    (error) => {
        return Promise.reject(error);
    }
);

apiClient.interceptors.response.use(
    (response) => {
        if (IS_DEV) {
            console.log('📥 Response:', response.status, response.config.url);
        }
        return response.data;
    },
    (error) => {
        const status = error.response?.status;
        const message = error.response?.data?.message || error.message;

        if (status === HTTP_STATUS.UNAUTHORIZED) {
            removeAuthToken();
            window.location.href = '/';
            showAlert.error('Session expired. Please login again.');
        } else if (status === HTTP_STATUS.FORBIDDEN) {
            showAlert.error('You do not have permission.');
        } else if (status >= HTTP_STATUS.SERVER_ERROR) {
            showAlert.error('Server error. Please try again later.');
        }

        return Promise.reject({ status, message, data: error.response?.data });
    }
);

export default apiClient;
