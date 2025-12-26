import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import { notificationsAPI } from '@/services/api/notifications.api';

const initialState = {
    notifications: [],
    unreadCount: 0,
    loading: false,
    error: null,
};

export const fetchNotifications = createAsyncThunk('notifications/fetchAll', async (_, { rejectWithValue }) => {
    try {
        const response = await notificationsAPI.getAll();
        return response.data;
    } catch (error) {
        return rejectWithValue(error.message);
    }
});

export const markAsRead = createAsyncThunk('notifications/markAsRead', async (id, { rejectWithValue }) => {
    try {
        await notificationsAPI.markAsRead(id);
        return id;
    } catch (error) {
        return rejectWithValue(error.message);
    }
});

export const markAllAsRead = createAsyncThunk('notifications/markAllAsRead', async (_, { rejectWithValue }) => {
    try {
        await notificationsAPI.markAllAsRead();
        return true;
    } catch (error) {
        return rejectWithValue(error.message);
    }
});

const notificationSlice = createSlice({
    name: 'notifications',
    initialState,
    reducers: {},
    extraReducers: (builder) => {
        builder
            .addCase(fetchNotifications.fulfilled, (state, action) => {
                state.notifications = action.payload;
                state.unreadCount = action.payload.filter((n) => !n.read).length;
            })
            .addCase(markAsRead.fulfilled, (state, action) => {
                const notification = state.notifications.find((n) => n.id === action.payload);
                if (notification) {
                    notification.read = true;
                    state.unreadCount = Math.max(0, state.unreadCount - 1);
                }
            })
            .addCase(markAllAsRead.fulfilled, (state) => {
                state.notifications.forEach((n) => (n.read = true));
                state.unreadCount = 0;
            });
    },
});

export default notificationSlice.reducer;
