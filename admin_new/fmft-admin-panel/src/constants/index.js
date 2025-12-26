// Environment variables (VITE_ prefix)
export const APP_NAME = import.meta.env.VITE_APP_NAME || 'FMFT Admin';
export const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';
export const API_TIMEOUT = parseInt(import.meta.env.VITE_API_TIMEOUT) || 10000;
export const APP_VERSION = import.meta.env.VITE_APP_VERSION || '1.0.0';
export const IS_DEV = import.meta.env.DEV;
export const IS_MOCK_API = import.meta.env.VITE_MOCK_API === 'true';

export const ROUTES = {
    HOME: '/',
    DASHBOARD: '/dashboard',
    USERS: '/users',
    TICKETS: '/tickets',
    NOTIFICATIONS: '/notifications',
    SETTINGS: '/settings',
    EMAILS: '/emails',
};

export const USER_STATUS = {
    ACTIVE: 'active',
    INACTIVE: 'inactive',
    SUSPENDED: 'suspended',
};

export const TICKET_STATUS = {
    ACTIVE: 'active',
    EXPIRED: 'expired',
    CANCELLED: 'cancelled',
    USED: 'used',
};

export const NOTIFICATION_TYPES = {
    USER: 'user',
    TICKET: 'ticket',
    PAYMENT: 'payment',
    REVIEW: 'review',
    SYSTEM: 'system',
};

export const TOAST_MESSAGES = {
    LOGIN_SUCCESS: 'Welcome back!',
    LOGIN_ERROR: 'Login failed. Please try again.',
    LOGOUT_SUCCESS: 'Logged out successfully',
    SESSION_EXPIRED: 'Session expired. Please login again.',
    SAVE_SUCCESS: 'Saved successfully!',
    DELETE_SUCCESS: 'Deleted successfully!',
    UPDATE_SUCCESS: 'Updated successfully!',
    ERROR_GENERIC: 'Something went wrong. Please try again.',
    LOAD_ERROR: 'Failed to load data',
};

export const HTTP_STATUS = {
    OK: 200,
    CREATED: 201,
    BAD_REQUEST: 400,
    UNAUTHORIZED: 401,
    FORBIDDEN: 403,
    NOT_FOUND: 404,
    SERVER_ERROR: 500,
};

export const STORAGE_KEYS = {
    AUTH_TOKEN: 'fmft_auth_token',
    USER_DATA: 'fmft_user_data',
};
