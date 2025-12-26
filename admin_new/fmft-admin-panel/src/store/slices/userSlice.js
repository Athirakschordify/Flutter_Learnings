import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import { usersAPI } from '@/services/api/users.api';

const initialState = {
    users: [],
    loading: false,
    error: null,
};

export const fetchUsers = createAsyncThunk('users/fetchAll', async (_, { rejectWithValue }) => {
    try {
        const response = await usersAPI.getAll();
        return response.data;
    } catch (error) {
        return rejectWithValue(error.message);
    }
});

export const deleteUser = createAsyncThunk('users/delete', async (id, { rejectWithValue }) => {
    try {
        await usersAPI.delete(id);
        return id;
    } catch (error) {
        return rejectWithValue(error.message);
    }
});

const userSlice = createSlice({
    name: 'users',
    initialState,
    reducers: {},
    extraReducers: (builder) => {
        builder
            .addCase(fetchUsers.pending, (state) => {
                state.loading = true;
            })
            .addCase(fetchUsers.fulfilled, (state, action) => {
                state.loading = false;
                state.users = action.payload;
            })
            .addCase(fetchUsers.rejected, (state, action) => {
                state.loading = false;
                state.error = action.payload;
            })
            .addCase(deleteUser.fulfilled, (state, action) => {
                state.users = state.users.filter((user) => user.id !== action.payload);
            });
    },
});

export default userSlice.reducer;
