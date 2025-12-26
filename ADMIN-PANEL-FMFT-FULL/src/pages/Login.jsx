import { useState } from 'react'
import { useDispatch } from 'react-redux'
import { useNavigate } from 'react-router-dom'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import * as z from 'zod'
import { loginSuccess } from '../store/auth/authSlice'
import { login } from '../api/authService'
import { Mail, Lock, Loader2, AlertCircle } from 'lucide-react'
import { toast } from 'sonner'

const loginSchema = z.object({
    email: z.string().email('Invalid email address'),
    password: z.string().min(6, 'Password must be at least 6 characters'),
})

const Login = () => {
    const [isLoading, setIsLoading] = useState(false)
    const dispatch = useDispatch()
    const navigate = useNavigate()

    const {
        register,
        handleSubmit,
        formState: { errors },
    } = useForm({
        resolver: zodResolver(loginSchema),
    })

    const onSubmit = async (values) => {
        setIsLoading(true)
        try {
            const data = await login(values)
            dispatch(loginSuccess(data))
            toast.success('Login successful! Welcome back.')
            navigate('/dashboard')
        } catch (err) {
            // Error is already handled by interceptor toast
        } finally {
            setIsLoading(false)
        }
    }

    return (
        <div className="min-h-screen bg-gray-50 dark:bg-gray-900 flex items-center justify-center p-4 transition-colors">
            <div className="max-w-md w-full bg-white dark:bg-gray-800 rounded-2xl shadow-xl p-8 border border-gray-100 dark:border-gray-700">
                <div className="text-center mb-8">
                    <h1 className="text-3xl font-bold text-gray-900 dark:text-white">Welcome Back</h1>
                    <p className="text-gray-500 dark:text-gray-400 mt-2">Sign in to your account</p>
                </div>

                <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
                    <div>
                        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">Email Address</label>
                        <div className="relative">
                            <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                            <input
                                {...register('email')}
                                type="email"
                                className={`w-full pl-10 pr-4 py-2.5 bg-gray-50 dark:bg-gray-700 border ${errors.email ? 'border-red-500' : 'border-gray-200 dark:border-gray-600'
                                    } rounded-xl focus:ring-2 focus:ring-primary focus:border-transparent transition-all outline-none text-sm dark:text-white`}
                                placeholder="admin@fmft.com"
                            />
                        </div>
                        {errors.email && (
                            <p className="text-xs text-red-500 mt-1 flex items-center gap-1">
                                <AlertCircle className="w-3 h-3" /> {errors.email.message}
                            </p>
                        )}
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">Password</label>
                        <div className="relative">
                            <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                            <input
                                {...register('password')}
                                type="password"
                                className={`w-full pl-10 pr-4 py-2.5 bg-gray-50 dark:bg-gray-700 border ${errors.password ? 'border-red-500' : 'border-gray-200 dark:border-gray-600'
                                    } rounded-xl focus:ring-2 focus:ring-primary focus:border-transparent transition-all outline-none text-sm dark:text-white`}
                                placeholder="••••••••"
                            />
                        </div>
                        {errors.password && (
                            <p className="text-xs text-red-500 mt-1 flex items-center gap-1">
                                <AlertCircle className="w-3 h-3" /> {errors.password.message}
                            </p>
                        )}
                    </div>

                    <div className="flex items-center justify-between text-sm">
                        <label className="flex items-center gap-2 cursor-pointer">
                            <input type="checkbox" className="w-4 h-4 rounded border-gray-300 dark:border-gray-600 text-primary focus:ring-primary" />
                            <span className="text-gray-600 dark:text-gray-400">Remember me</span>
                        </label>
                        <a href="#" className="text-primary font-medium hover:underline">Forgot password?</a>
                    </div>

                    <button
                        type="submit"
                        disabled={isLoading}
                        className="w-full bg-primary hover:bg-primary/90 text-white font-semibold py-3 rounded-xl transition-all flex items-center justify-center gap-2 disabled:opacity-50"
                    >
                        {isLoading ? <Loader2 className="w-5 h-5 animate-spin" /> : 'Sign In'}
                    </button>
                </form>

                <p className="text-center mt-8 text-sm text-gray-500 dark:text-gray-400">
                    Don't have an account? <a href="#" className="text-primary font-medium hover:underline">Sign up</a>
                </p>
            </div>
        </div>
    )
}

export default Login
