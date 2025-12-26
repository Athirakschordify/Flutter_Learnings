import { useState } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { useNavigate, useLocation } from 'react-router-dom'
import { logout } from '../../store/slices/authSlice'
import {
    LogOut,
    LayoutDashboard,
    Users,
    Ticket,
    Calendar,
    Bell,
    Settings,
    Menu,
    X,
    Search,
    ChevronDown,
    User
} from 'lucide-react'

const DashboardLayout = ({ children }) => {
    const dispatch = useDispatch()
    const navigate = useNavigate()
    const location = useLocation()
    const { user } = useSelector((state) => state.auth)
    const [sidebarOpen, setSidebarOpen] = useState(true)
    const [mobileMenuOpen, setMobileMenuOpen] = useState(false)

    const handleLogout = () => {
        dispatch(logout())
        navigate('/login')
    }

    const menuItems = [
        { icon: LayoutDashboard, label: 'Dashboard', path: '/dashboard' },
        { icon: Users, label: 'Users', path: '/dashboard/users' },
        { icon: Ticket, label: 'Tickets', path: '/dashboard/tickets' },
        { icon: Calendar, label: 'Events', path: '/dashboard/events' },
        { icon: Bell, label: 'Notifications', path: '/dashboard/notifications' },
        { icon: Settings, label: 'Settings', path: '/dashboard/settings' },
    ]

    const isActive = (path) => location.pathname === path

    return (
        <div className="fixed inset-0 flex h-screen bg-gray-50 overflow-hidden">
            {/* Sidebar */}
            <aside className={`${sidebarOpen ? 'w-64' : 'w-20'} hidden lg:flex flex-col bg-gradient-to-b from-indigo-600 to-purple-700 text-white transition-all duration-300 ease-in-out`}>
                {/* Logo */}
                <div className="flex items-center justify-between p-4 border-b border-white/10">
                    {sidebarOpen ? (
                        <div className="flex items-center gap-3">
                            <div className="w-10 h-10 bg-white/20 backdrop-blur-lg rounded-xl flex items-center justify-center">
                                <Ticket className="w-6 h-6 text-white" />
                            </div>
                            <div>
                                <h1 className="text-lg font-bold">FMFT</h1>
                                <p className="text-xs text-white/70">Admin Panel</p>
                            </div>
                        </div>
                    ) : (
                        <div className="w-10 h-10 bg-white/20 backdrop-blur-lg rounded-xl flex items-center justify-center mx-auto">
                            <Ticket className="w-6 h-6 text-white" />
                        </div>
                    )}
                </div>

                {/* Navigation */}
                <nav className="flex-1 p-4 space-y-2 overflow-y-auto">
                    {menuItems.map((item, index) => (
                        <button
                            key={index}
                            onClick={() => navigate(item.path)}
                            className={`w-full flex items-center gap-3 px-4 py-3 rounded-xl transition-all duration-200 ${isActive(item.path)
                                ? 'bg-white text-indigo-700 shadow-lg font-semibold'
                                : 'bg-transparent text-white hover:bg-white/10'
                                }`}
                        >
                            <item.icon className="w-5 h-5 flex-shrink-0" />
                            {sidebarOpen && <span className="font-medium">{item.label}</span>}
                        </button>
                    ))}
                </nav>

                {/* Collapse Button */}
                <div className="p-4 border-t border-white/10">
                    <button
                        onClick={() => setSidebarOpen(!sidebarOpen)}
                        className="w-full flex items-center justify-center gap-2 px-4 py-3 bg-white/10 hover:bg-white/20 rounded-xl transition-all"
                    >
                        <Menu className="w-5 h-5" />
                        {sidebarOpen && <span className="text-sm font-medium">Collapse</span>}
                    </button>
                </div>
            </aside>

            {/* Mobile Sidebar Overlay */}
            {mobileMenuOpen && (
                <div className="fixed inset-0 z-50 lg:hidden">
                    <div className="absolute inset-0 bg-black/50" onClick={() => setMobileMenuOpen(false)}></div>
                    <aside className="absolute left-0 top-0 bottom-0 w-64 bg-gradient-to-b from-indigo-600 to-purple-700 text-white flex flex-col">
                        {/* Mobile Logo */}
                        <div className="flex items-center justify-between p-4 border-b border-white/10">
                            <div className="flex items-center gap-3">
                                <div className="w-10 h-10 bg-white/20 backdrop-blur-lg rounded-xl flex items-center justify-center">
                                    <Ticket className="w-6 h-6 text-white" />
                                </div>
                                <div>
                                    <h1 className="text-lg font-bold">FMFT</h1>
                                    <p className="text-xs text-white/70">Admin Panel</p>
                                </div>
                            </div>
                            <button onClick={() => setMobileMenuOpen(false)} className="p-2 hover:bg-white/10 rounded-lg">
                                <X className="w-5 h-5" />
                            </button>
                        </div>

                        {/* Mobile Navigation */}
                        <nav className="flex-1 p-4 space-y-2 overflow-y-auto">
                            {menuItems.map((item, index) => (
                                <button
                                    key={index}
                                    onClick={() => {
                                        navigate(item.path)
                                        setMobileMenuOpen(false)
                                    }}
                                    className={`w-full flex items-center gap-3 px-4 py-3 rounded-xl transition-all duration-200 ${isActive(item.path)
                                        ? 'bg-white text-indigo-700 shadow-lg font-semibold'
                                        : 'text-white hover:bg-white/10'
                                        }`}
                                >
                                    <item.icon className="w-5 h-5 flex-shrink-0" />
                                    <span className="font-medium">{item.label}</span>
                                </button>
                            ))}
                        </nav>
                    </aside>
                </div>
            )}

            {/* Main Content Area */}
            <div className="flex-1 flex flex-col overflow-hidden">
                {/* Top Header Navbar */}
                <header className="bg-white border-b border-gray-200 shadow-sm">
                    <div className="flex items-center justify-between px-4 sm:px-6 lg:px-8 py-4">
                        {/* Left: Mobile Menu */}
                        <div className="flex items-center gap-4">
                            <button
                                onClick={() => setMobileMenuOpen(true)}
                                className="lg:hidden p-2 hover:bg-gray-100 rounded-lg transition-colors"
                            >
                                <Menu className="w-6 h-6 text-gray-600" />
                            </button>
                        </div>

                        {/* Right: Notifications + User Menu */}
                        <div className="flex items-center gap-3">
                            {/* Notifications */}
                            <button className="relative p-2 hover:bg-gray-100 rounded-lg transition-colors">
                                <Bell className="w-6 h-6 text-gray-600" />
                                <span className="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                            </button>

                            {/* User Menu */}
                            <div className="flex items-center gap-3 pl-3 border-l border-gray-200">
                                <div className="hidden sm:block text-right">
                                    <p className="text-sm font-semibold text-gray-900">{user?.name || 'Admin User'}</p>
                                    <p className="text-xs text-gray-500">{user?.email || 'admin@fmft.com'}</p>
                                </div>
                                <div className="relative group">
                                    <button className="flex items-center gap-2 p-2 hover:bg-gray-100 rounded-lg transition-colors">
                                        <div className="w-10 h-10 bg-gradient-to-br from-indigo-600 to-pink-600 rounded-full flex items-center justify-center">
                                            <User className="w-6 h-6 text-white" />
                                        </div>
                                        <ChevronDown className="w-4 h-4 text-gray-600 hidden sm:block" />
                                    </button>

                                    {/* Dropdown Menu */}
                                    <div className="hidden group-hover:block absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-gray-200 py-2 z-50">
                                        <a href="#" className="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">
                                            <User className="w-4 h-4" />
                                            Profile
                                        </a>
                                        <a href="#" className="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">
                                            <Settings className="w-4 h-4" />
                                            Settings
                                        </a>
                                        <hr className="my-2 border-gray-200" />
                                        <button
                                            onClick={handleLogout}
                                            className="w-full flex items-center gap-2 px-4 py-2 text-sm text-red-600 hover:bg-red-50"
                                        >
                                            <LogOut className="w-4 h-4" />
                                            Logout
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </header>

                {/* Main Content */}
                <main className="flex-1 overflow-y-auto">
                    {children}
                </main>
            </div>
        </div>
    )
}

export default DashboardLayout
