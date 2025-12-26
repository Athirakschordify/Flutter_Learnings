import React from 'react'
import ReactDOM from 'react-dom/client'
import { Provider } from 'react-redux'
import { BrowserRouter } from 'react-router-dom'
import { Toaster } from 'sonner'
import { store } from './store'
import { ThemeProvider } from './components/ThemeProvider'
import App from './App'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')).render(
    <React.StrictMode>
        <Provider store={store}>
            <ThemeProvider defaultTheme="light" storageKey="admin-theme">
                <BrowserRouter>
                    <App />
                    <Toaster position="top-right" richColors />
                </BrowserRouter>
            </ThemeProvider>
        </Provider>
    </React.StrictMode>,
)
