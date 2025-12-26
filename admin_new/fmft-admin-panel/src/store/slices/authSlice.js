import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import { authAPI } from '@/services/api/auth.api';
import { setAuthToken, setUserData, removeAuthToken } from '@/utils/auth';

const initialState = {
    user: null,
    token: null,
    isAuthenticated: false,
    loading: false,
    error: null,
    sessionExpiry: null,
};

export const loginUser = createAsyncThunk('auth/login', async (credentials, { rejectWithValue }) => {
    try {
        const response = await authAPI.login(credentials);
        setAuthToken(response.data.token);
        setUserData(response.data.user);
        const sessionExpiry = Date.now() + 24 * 60 * 60 * 1000;
        return { user: response.data.user, token: response.data.token, sessionExpiry };
    } catch (error) {
        return rejectWithValue(error.message || 'Login failed');
    }
});

export const logoutUser = createAsyncThunk('auth/logout', async (_, { rejectWithValue }) => {
    try {
        await authAPI.logout();
        removeAuthToken();
        return true;
    } catch (error) {
        return rejectWithValue(error.message);
    }
});

export const checkSession = createAsyncThunk('auth/checkSession', async (_, { getState, rejectWithValue }) => {
    try {
        const { auth } = getState();
        if (!auth.isAuthenticated || !auth.sessionExpiry) {
            throw new Error('No active session');
        }
        if (Date.now() > auth.sessionExpiry) {
            throw new Error('Session expired');
        }
        return true;
    } catch (error) {
        removeAuthToken();
        return rejectWithValue(error.message);
    }
});

const authSlice = createSlice({
    name: 'auth',
    initialState,
    reducers: {
        clearError: (state) => {
            state.error = null;
        },
    },
    extraReducers: (builder) => {
        builder
            .addCase(loginUser.pending, (state) => {
                state.loading = true;
                state.error = null;
            })
            .addCase(loginUser.fulfilled, (state, action) => {
                state.loading = false;
                state.isAuthenticated = true;
                state.user = action.payload.user;
                state.token = action.payload.token;
                state.sessionExpiry = action.payload.sessionExpiry;
            })
            .addCase(loginUser.rejected, (state, action) => {
                state.loading = false;
                state.error = action.payload;
            })
            .addCase(logoutUser.fulfilled, (state) => {
                state.user = null;
                state.token = null;
                state.isAuthenticated = false;
                state.sessionExpiry = null;
            })
            .addCase(checkSession.rejected, (state) => {
                state.user = null;
                state.token = null;
                state.isAuthenticated = false;
                state.sessionExpiry = null;
            });
    },
});

export const { clearError } = authSlice.actions;
export default authSlice.reducer;
