import { createSlice } from '@reduxjs/toolkit'

const initialState = {
    user: JSON.parse(localStorage.getItem('user')) || null,
    token: localStorage.getItem('token') || null,
    isAuthenticated: !!localStorage.getItem('token'),
    redirectPath: null, // To store where the user was trying to go
}

const authSlice = createSlice({
    name: 'auth',
    initialState,
    reducers: {
        loginSuccess: (state, action) => {
            state.user = action.payload.user
            state.token = action.payload.token
            state.isAuthenticated = true
            localStorage.setItem('user', JSON.stringify(action.payload.user))
            localStorage.setItem('token', action.payload.token)
        },
        logout: (state) => {
            state.user = null
            state.token = null
            state.isAuthenticated = false
            localStorage.removeItem('user')
            localStorage.removeItem('token')
        },
        setRedirectPath: (state, action) => {
            state.redirectPath = action.payload
        },
        clearRedirectPath: (state) => {
            state.redirectPath = null
        }
    },
})

export const { loginSuccess, logout, setRedirectPath, clearRedirectPath } = authSlice.actions
export default authSlice.reducer
