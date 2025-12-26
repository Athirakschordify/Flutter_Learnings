import { useState } from 'react'
import { useDispatch } from 'react-redux'
import { useNavigate } from 'react-router-dom'
import { Bell, Search, Settings, LogOut, Menu, User, Sun, Moon, Monitor } from 'lucide-react'
import { logout } from '../store/auth/authSlice'
import { useTheme } from './ThemeProvider'
import { clsx } from 'clsx'
import { twMerge } from 'tailwind-merge'

function cn(...inputs) {
    return twMerge(clsx(inputs))
}

const TopBar = ({ toggleSidebar }) => {
    const [showUserDropdown, setShowUserDropdown] = useState(false)
    const [showNotifications, setShowNotifications] = useState(false)
    const [showThemeMenu, setShowThemeMenu] = useState(false)
    const { theme, setTheme } = useTheme()

    const dispatch = useDispatch()
    const navigate = useNavigate()

    const handleLogout = () => {
        dispatch(logout())
        navigate('/login')
    }

    return (
        <header className="h-16 bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between px-4 md:px-6 sticky top-0 z-30 transition-colors">
            <div className="flex items-center gap-4">
                <button
                    className="p-2 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-md focus:outline-none"
                    onClick={toggleSidebar}
                >
                    <Menu className="w-5 h-5" />
                </button>

                {/* Search Bar */}
                <div className="hidden md:flex items-center relative">
                    <Search className="w-4 h-4 absolute left-3 text-gray-400" />
                    <input
                        type="text"
                        placeholder="Search..."
                        className="pl-10 pr-4 py-2 bg-gray-100 dark:bg-gray-700 border-transparent rounded-full text-sm focus:bg-white dark:focus:bg-gray-600 focus:border-primary focus:ring-0 transition-all w-64 dark:text-white"
                    />
                </div>
            </div>

            <div className="flex items-center gap-2 md:gap-4">
                {/* Theme Toggle */}
                <div className="relative">
                    <button
                        className="p-2 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-full"
                        onClick={() => setShowThemeMenu(!showThemeMenu)}
                    >
                        {theme === 'light' ? <Sun className="w-5 h-5" /> : theme === 'dark' ? <Moon className="w-5 h-5" /> : <Monitor className="w-5 h-5" />}
                    </button>

                    {showThemeMenu && (
                        <div className="absolute right-0 mt-2 w-36 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-lg z-50 overflow-hidden py-1">
                            {[
                                { label: 'Light', value: 'light', icon: Sun },
                                { label: 'Dark', value: 'dark', icon: Moon },
                                { label: 'System', value: 'system', icon: Monitor },
                            ].map((t) => (
                                <button
                                    key={t.value}
                                    className={cn(
                                        "w-full flex items-center gap-3 px-4 py-2 text-sm transition-colors",
                                        theme === t.value ? "text-primary bg-primary/10" : "text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700"
                                    )}
                                    onClick={() => {
                                        setTheme(t.value)
                                        setShowThemeMenu(false)
                                    }}
                                >
                                    <t.icon className="w-4 h-4" /> {t.label}
                                </button>
                            ))}
                        </div>
                    )}
                </div>

                {/* Notifications */}
                <div className="relative">
                    <button
                        className="p-2 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-full relative"
                        onClick={() => setShowNotifications(!showNotifications)}
                    >
                        <Bell className="w-5 h-5" />
                        <span className="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full border-2 border-white dark:border-gray-800"></span>
                    </button>

                    {showNotifications && (
                        <div className="absolute right-0 mt-2 w-80 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-lg z-50 overflow-hidden">
                            <div className="p-4 border-b border-gray-100 dark:border-gray-700 flex justify-between items-center">
                                <h3 className="text-sm font-semibold dark:text-white">Notifications</h3>
                                <span className="text-xs text-primary font-medium cursor-pointer">Mark all as read</span>
                            </div>
                            <div className="max-h-64 overflow-y-auto">
                                <div className="p-4 border-b border-gray-50 dark:border-gray-700 flex gap-3 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                    <div className="w-2 h-2 mt-1.5 bg-primary rounded-full flex-shrink-0"></div>
                                    <div>
                                        <p className="text-sm text-gray-800 dark:text-gray-200">New user registered recently.</p>
                                        <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">2 minutes ago</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    )}
                </div>

                {/* User Dropdown */}
                <div className="relative">
                    <button
                        className="flex items-center gap-2 pl-2 pr-1 py-1 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors"
                        onClick={() => setShowUserDropdown(!showUserDropdown)}
                    >
                        <div className="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white text-xs font-bold ring-2 ring-white dark:ring-gray-800">
                            AD
                        </div>
                    </button>

                    {showUserDropdown && (
                        <div className="absolute right-0 mt-2 w-56 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-lg z-50 overflow-hidden py-1">
                            <button className="w-full flex items-center gap-3 px-4 py-2.5 text-sm text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                <User className="w-4 h-4" /> My Profile
                            </button>
                            <button className="w-full flex items-center gap-3 px-4 py-2.5 text-sm text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                <Settings className="w-4 h-4" /> Settings
                            </button>
                            <div className="border-t border-gray-100 dark:border-gray-700 my-1"></div>
                            <button
                                className="w-full flex items-center gap-3 px-4 py-2.5 text-sm text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 transition-colors"
                                onClick={handleLogout}
                            >
                                <LogOut className="w-4 h-4" /> Logout
                            </button>
                        </div>
                    )}
                </div>
            </div>
        </header>
    )
}

export default TopBar
