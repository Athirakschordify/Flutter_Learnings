import { STORAGE_KEYS } from '@/constants';

export const setAuthToken = (token) => {
    localStorage.setItem(STORAGE_KEYS.AUTH_TOKEN, token);
};

export const getAuthToken = () => {
    return localStorage.getItem(STORAGE_KEYS.AUTH_TOKEN);
};

export const removeAuthToken = () => {
    localStorage.removeItem(STORAGE_KEYS.AUTH_TOKEN);
    localStorage.removeItem(STORAGE_KEYS.USER_DATA);
};

export const setUserData = (userData) => {
    localStorage.setItem(STORAGE_KEYS.USER_DATA, JSON.stringify(userData));
};

export const getUserData = () => {
    const data = localStorage.getItem(STORAGE_KEYS.USER_DATA);
    return data ? JSON.parse(data) : null;
};

export const isAuthenticated = () => {
    return !!getAuthToken();
};
