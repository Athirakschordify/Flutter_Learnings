import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import { dashboardAPI } from '@/services/api/dashboard.api';

const initialState = {
    stats: null,
    recentActivity: [],
    upcomingEvents: [],
    loading: false,
    error: null,
};

export const fetchDashboardData = createAsyncThunk('dashboard/fetchData', async (_, { rejectWithValue }) => {
    try {
        const [statsRes, activityRes, eventsRes] = await Promise.all([
            dashboardAPI.getStats(),
            dashboardAPI.getRecentActivity(),
            dashboardAPI.getUpcomingEvents(),
        ]);
        return {
            stats: statsRes.data,
            recentActivity: activityRes.data,
            upcomingEvents: eventsRes.data,
        };
    } catch (error) {
        return rejectWithValue(error.message);
    }
});

const dashboardSlice = createSlice({
    name: 'dashboard',
    initialState,
    reducers: {},
    extraReducers: (builder) => {
        builder
            .addCase(fetchDashboardData.pending, (state) => {
                state.loading = true;
            })
            .addCase(fetchDashboardData.fulfilled, (state, action) => {
                state.loading = false;
                state.stats = action.payload.stats;
                state.recentActivity = action.payload.recentActivity;
                state.upcomingEvents = action.payload.upcomingEvents;
            })
            .addCase(fetchDashboardData.rejected, (state, action) => {
                state.loading = false;
                state.error = action.payload;
            });
    },
});

export default dashboardSlice.reducer;
