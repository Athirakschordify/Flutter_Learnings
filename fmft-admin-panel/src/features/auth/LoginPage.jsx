import { useState } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { useNavigate } from 'react-router-dom'
import { loginStart, loginSuccess, loginFailure } from '../../store/slices/authSlice'
import { Lock, Mail, Eye, EyeOff, Ticket, Shield, KeyRound } from 'lucide-react'

const LoginPage = () => {
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [showPassword, setShowPassword] = useState(false)
    const dispatch = useDispatch()
    const navigate = useNavigate()
    const { loading, error } = useSelector((state) => state.auth)

    const handleSubmit = async (e) => {
        e.preventDefault()
        dispatch(loginStart())

        try {
            // Simulate API call - replace with actual API call
            await new Promise((resolve) => setTimeout(resolve, 1000))

            // Mock successful login
            dispatch(
                loginSuccess({
                    user: { email, name: 'Admin User' },
                    token: 'mock-jwt-token',
                })
            )
            navigate('/dashboard')
        } catch (err) {
            dispatch(loginFailure(err.message || 'Login failed'))
        }
    }

    return (
        <div className="fixed inset-0 h-screen w-screen flex overflow-hidden">
            {/* Left Panel - FMFT Branding */}
            <div className="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-indigo-600 via-purple-600 to-pink-600 relative overflow-hidden">
                {/* Animated Background Pattern */}
                <div className="absolute inset-0 opacity-10">
                    {/* Ticket Pattern Background */}
                    <div className="absolute top-10 left-10 w-64 h-40 bg-white rounded-2xl rotate-12 opacity-20"></div>
                    <div className="absolute top-40 right-20 w-72 h-44 bg-white rounded-2xl -rotate-6 opacity-15"></div>
                    <div className="absolute bottom-32 left-32 w-56 h-36 bg-white rounded-2xl rotate-3 opacity-20"></div>
                    <div className="absolute bottom-10 right-10 w-80 h-48 bg-white rounded-2xl -rotate-12 opacity-10"></div>
                </div>

                {/* Animated Gradient Blobs */}
                <div className="absolute inset-0 opacity-30">
                    <div className="absolute top-20 left-20 w-72 h-72 bg-yellow-300 rounded-full mix-blend-overlay filter blur-3xl animate-pulse"></div>
                    <div className="absolute bottom-20 right-20 w-96 h-96 bg-pink-400 rounded-full mix-blend-overlay filter blur-3xl animate-pulse delay-1000"></div>
                    <div className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-80 h-80 bg-blue-400 rounded-full mix-blend-overlay filter blur-3xl animate-pulse delay-500"></div>
                </div>

                {/* Content - Centered */}
                <div className="relative z-10 flex items-center justify-center w-full h-full px-16">
                    <div className="text-center max-w-lg">
                        {/* Logo */}
                        <div className="flex items-center justify-center gap-3 mb-8">
                            <div className="w-16 h-16 bg-white/20 backdrop-blur-lg rounded-2xl flex items-center justify-center border-2 border-white/40 shadow-2xl">
                                <Ticket className="w-8 h-8 text-white" />
                            </div>
                            <div className="text-left">
                                <h1 className="text-4xl font-bold tracking-tight text-white">FMFT</h1>
                                <p className="text-sm text-white/80 font-medium">Find My Future Ticket</p>
                            </div>
                        </div>

                        {/* Title */}
                        <h2 className="text-5xl font-bold leading-tight mb-6 text-white">
                            Welcome Back!
                        </h2>

                        {/* Description */}
                        <p className="text-xl text-white/90 leading-relaxed">
                            Manage users, tickets, events, and analytics for the ultimate ticket management platform.
                        </p>
                    </div>
                </div>
            </div>

            {/* Right Panel - Login Form */}
            <div className="w-full lg:w-1/2 flex items-center justify-center bg-gradient-to-br from-gray-50 to-gray-100 p-6 sm:p-8 overflow-y-auto">
                <div className="w-full max-w-md">
                    {/* Mobile Logo - Centered */}
                    <div className="lg:hidden flex flex-col items-center justify-center text-center mb-8">
                        <div className="w-16 h-16 bg-gradient-to-br from-indigo-600 to-pink-600 rounded-2xl flex items-center justify-center shadow-xl mb-3">
                            <Ticket className="w-8 h-8 text-white" />
                        </div>
                        <h1 className="text-2xl font-bold text-gray-900">FMFT Admin</h1>
                        <p className="text-xs text-gray-600 mt-1">Find My Future Ticket</p>
                    </div>

                    {/* Form Header */}
                    <div className="mb-8">
                        <h2 className="text-3xl font-bold text-gray-900 mb-2">Admin Sign In</h2>
                        <p className="text-gray-600">Access your admin dashboard to manage the platform</p>
                    </div>

                    {/* Login Form */}
                    <form onSubmit={handleSubmit} className="space-y-6">
                        {/* Email Field */}
                        <div>
                            <label htmlFor="email" className="block text-sm font-semibold text-gray-700 mb-2">
                                Admin Email
                            </label>
                            <div className="relative group">
                                <div className="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <Mail className="h-5 w-5 text-gray-400 group-focus-within:text-indigo-500 transition-colors" />
                                </div>
                                <input
                                    id="email"
                                    type="email"
                                    value={email}
                                    onChange={(e) => setEmail(e.target.value)}
                                    className="block w-full pl-12 pr-4 py-3.5 bg-white border-2 border-gray-200 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-all text-gray-900 placeholder-gray-400 hover:border-gray-300"
                                    placeholder="admin@fmft.com"
                                    required
                                />
                            </div>
                        </div>

                        {/* Password Field */}
                        <div>
                            <label htmlFor="password" className="block text-sm font-semibold text-gray-700 mb-2">
                                Password
                            </label>
                            <div className="relative group">
                                <div className="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <KeyRound className="h-5 w-5 text-gray-400 group-focus-within:text-indigo-500 transition-colors" />
                                </div>
                                <input
                                    id="password"
                                    type={showPassword ? 'text' : 'password'}
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                    className="block w-full pl-12 pr-12 py-3.5 bg-white border-2 border-gray-200 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-all text-gray-900 placeholder-gray-400 hover:border-gray-300"
                                    placeholder="••••••••"
                                    required
                                />
                                <button
                                    type="button"
                                    onClick={() => setShowPassword(!showPassword)}
                                    className="absolute inset-y-0 right-0 pr-4 flex items-center hover:bg-gray-50 rounded-r-xl transition-colors"
                                >
                                    {showPassword ? (
                                        <EyeOff className="h-5 w-5 text-gray-400 hover:text-gray-600" />
                                    ) : (
                                        <Eye className="h-5 w-5 text-gray-400 hover:text-gray-600" />
                                    )}
                                </button>
                            </div>
                        </div>

                        {/* Remember Me & Forgot Password */}
                        <div className="flex items-center justify-between">
                            <label className="flex items-center cursor-pointer group">
                                <input
                                    type="checkbox"
                                    className="w-4 h-4 text-indigo-600 border-gray-300 rounded focus:ring-indigo-500 cursor-pointer"
                                />
                                <span className="ml-2 text-sm text-gray-600 group-hover:text-gray-900 transition-colors">Remember me</span>
                            </label>
                            <a href="#" className="text-sm font-semibold text-indigo-600 hover:text-indigo-700 transition-colors">
                                Forgot password?
                            </a>
                        </div>

                        {/* Error Message */}
                        {error && (
                            <div className="bg-red-50 border-2 border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm font-medium flex items-center gap-2">
                                <Shield className="w-4 h-4" />
                                {error}
                            </div>
                        )}

                        {/* Submit Button */}
                        <button
                            type="submit"
                            disabled={loading}
                            className="w-full bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-600 text-white py-4 px-6 rounded-xl font-semibold hover:shadow-2xl hover:scale-[1.02] focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:scale-100 shadow-lg"
                        >
                            {loading ? (
                                <span className="flex items-center justify-center">
                                    <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                        <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                                        <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                    </svg>
                                    Signing in...
                                </span>
                            ) : (
                                <span className="flex items-center justify-center gap-2">
                                    <Lock className="w-5 h-5" />
                                    Sign In to Dashboard
                                </span>
                            )}
                        </button>
                    </form>

                    {/* Footer */}
                    <div className="mt-8 text-center space-y-3">
                        <p className="text-sm text-gray-500 flex items-center justify-center gap-2">
                            <Shield className="w-4 h-4" />
                            Protected by enterprise-grade security
                        </p>
                        <p className="text-xs text-gray-400">
                            FMFT Admin Panel v1.0 • Ticket Management System
                        </p>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default LoginPage
