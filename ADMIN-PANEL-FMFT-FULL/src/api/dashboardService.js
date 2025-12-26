import apiClient from './apiClient'
import { mockDashboardData, mockStats } from './mockData'

export const getDashboardStats = async () => {
    // const response = await apiClient.get('/dashboard/stats')
    // return response.data
    return new Promise((resolve) => {
        setTimeout(() => resolve(mockStats), 500)
    })
}

export const getDashboardChartData = async () => {
    // const response = await apiClient.get('/dashboard/charts')
    // return response.data
    return new Promise((resolve) => {
        setTimeout(() => resolve(mockDashboardData), 500)
    })
}
