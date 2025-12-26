import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import { ticketsAPI } from '@/services/api/tickets.api';

const initialState = {
    tickets: [],
    loading: false,
    error: null,
};

export const fetchTickets = createAsyncThunk('tickets/fetchAll', async (_, { rejectWithValue }) => {
    try {
        const response = await ticketsAPI.getAll();
        return response.data;
    } catch (error) {
        return rejectWithValue(error.message);
    }
});

const ticketSlice = createSlice({
    name: 'tickets',
    initialState,
    reducers: {},
    extraReducers: (builder) => {
        builder
            .addCase(fetchTickets.pending, (state) => {
                state.loading = true;
            })
            .addCase(fetchTickets.fulfilled, (state, action) => {
                state.loading = false;
                state.tickets = action.payload;
            })
            .addCase(fetchTickets.rejected, (state, action) => {
                state.loading = false;
                state.error = action.payload;
            });
    },
});

export default ticketSlice.reducer;
