/**
 * @file userService.js
 * @description Services for managing user data. Currently using mock promises.
 */

import apiClient from './apiClient'
import { mockUsers } from './mockData'

/**
 * Fetches the list of all users.
 * @returns {Promise<Array>} A promise that resolves to an array of user objects.
 */
export const getUsers = async () => {
    // const response = await apiClient.get('/users')
    // return response.data
    return new Promise((resolve) => {
        setTimeout(() => resolve([...mockUsers]), 500)
    })
}

/**
 * Creates a new user.
 * @param {Object} userData - The data for the new user.
 * @returns {Promise<Object>} A promise that resolves to the created user object.
 */
export const createUser = async (userData) => {
    // const response = await apiClient.post('/users', userData)
    // return response.data
    return new Promise((resolve) => {
        setTimeout(() => resolve({ ...userData, id: Date.now(), joined: new Date().toISOString().split('T')[0] }), 500)
    })
}

/**
 * Updates an existing user by ID.
 * @param {string|number} id - The unique identifier of the user.
 * @param {Object} userData - The updated data.
 * @returns {Promise<Object>} A promise that resolves to the updated user object.
 */
export const updateUser = async (id, userData) => {
    // const response = await apiClient.put(`/users/${id}`, userData)
    // return response.data
    return new Promise((resolve) => {
        setTimeout(() => resolve({ ...userData, id }), 500)
    })
}

/**
 * Deletes a user by ID.
 * @param {string|number} id - The unique identifier of the user.
 * @returns {Promise<boolean>} A promise that resolves to true if deleted.
 */
export const deleteUser = async (id) => {
    // await apiClient.delete(`/users/${id}`)
    return new Promise((resolve) => {
        setTimeout(() => resolve(true), 500)
    })
}
