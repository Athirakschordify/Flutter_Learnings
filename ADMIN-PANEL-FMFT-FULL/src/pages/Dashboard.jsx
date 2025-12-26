import { useState, useEffect } from 'react'
import { Users, CreditCard, Activity, TrendingUp, Loader2 } from 'lucide-react'
import {
    AreaChart, Area, XAxis, YAxis,
    CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar
} from 'recharts'
import { getDashboardStats, getDashboardChartData } from '../api/dashboardService'

const StatCard = ({ title, value, icon: Icon, trend, color, isLoading }) => (
    <div className="bg-white dark:bg-gray-800 p-6 rounded-2xl border border-gray-100 dark:border-gray-700 shadow-sm hover:shadow-md transition-all">
        <div className="flex items-start justify-between">
            {isLoading ? (
                <div className="space-y-3 w-full">
                    <div className="h-4 w-24 bg-gray-100 dark:bg-gray-700 rounded animate-pulse" />
                    <div className="h-8 w-32 bg-gray-200 dark:bg-gray-600 rounded animate-pulse" />
                </div>
            ) : (
                <div>
                    <p className="text-sm font-medium text-gray-500 dark:text-gray-400">{title}</p>
                    <h3 className="text-2xl font-bold text-gray-900 dark:text-white mt-1">{value}</h3>
                    <div className="flex items-center gap-1 mt-2">
                        <TrendingUp className="w-4 h-4 text-green-500" />
                        <span className="text-xs font-medium text-green-500">+{trend}%</span>
                        <span className="text-xs text-gray-400 ml-1">from last month</span>
                    </div>
                </div>
            )}
            {!isLoading && (
                <div className={`p-3 rounded-xl ${color} bg-opacity-10 transition-colors`}>
                    <Icon className={`w-6 h-6 ${color.replace('bg-', 'text-')}`} />
                </div>
            )}
        </div>
    </div>
)

const Dashboard = () => {
    const [stats, setStats] = useState([])
    const [chartData, setChartData] = useState([])
    const [isLoading, setIsLoading] = useState(true)

    useEffect(() => {
        fetchData()
    }, [])

    const fetchData = async () => {
        setIsLoading(true)
        try {
            const [statsData, chartsData] = await Promise.all([
                getDashboardStats(),
                getDashboardChartData()
            ])
            setStats(statsData)
            setChartData(chartsData)
        } catch (error) {
            // Error handled by interceptor
        } finally {
            setIsLoading(false)
        }
    }

    const iconMap = {
        'Total Users': Users,
        'Active Sessions': Activity,
        'Total Revenue': CreditCard
    }

    return (
        <div className="space-y-8 animate-in fade-in duration-500">
            <div>
                <h1 className="text-2xl font-bold text-gray-900 dark:text-white transition-colors">Dashboard Overview</h1>
                <p className="text-gray-500 dark:text-gray-400 mt-1 transition-colors">Monitor your system performance and user activity.</p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {(isLoading ? Array(3).fill({}) : stats).map((stat, index) => (
                    <StatCard
                        key={index}
                        {...stat}
                        icon={iconMap[stat.title]}
                        isLoading={isLoading}
                    />
                ))}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 relative min-h-[400px]">
                {isLoading && (
                    <div className="absolute inset-0 bg-white/30 dark:bg-gray-900/30 backdrop-blur-[1px] z-10 flex items-center justify-center rounded-2xl">
                        <Loader2 className="w-10 h-10 text-primary animate-spin" />
                    </div>
                )}

                {/* Revenue Overview Chart */}
                <div className="bg-white dark:bg-gray-800 p-6 rounded-2xl border border-gray-100 dark:border-gray-700 shadow-sm transition-colors">
                    <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-6">Revenue Overview</h2>
                    <div className="h-80 w-full">
                        <ResponsiveContainer width="100%" height="100%">
                            <AreaChart data={chartData}>
                                <defs>
                                    <linearGradient id="colorRev" x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.1} />
                                        <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                                    </linearGradient>
                                </defs>
                                <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e5e7eb" />
                                <XAxis dataKey="name" axisLine={false} tickLine={false} tick={{ fontSize: 12, fill: '#9ca3af' }} />
                                <YAxis axisLine={false} tickLine={false} tick={{ fontSize: 12, fill: '#9ca3af' }} />
                                <Tooltip
                                    contentStyle={{ backgroundColor: '#fff', borderRadius: '12px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                                />
                                <Area type="monotone" dataKey="revenue" stroke="#3b82f6" strokeWidth={3} fillOpacity={1} fill="url(#colorRev)" />
                            </AreaChart>
                        </ResponsiveContainer>
                    </div>
                </div>

                {/* User Growth Chart */}
                <div className="bg-white dark:bg-gray-800 p-6 rounded-2xl border border-gray-100 dark:border-gray-700 shadow-sm transition-colors">
                    <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-6">User Growth</h2>
                    <div className="h-80 w-full">
                        <ResponsiveContainer width="100%" height="100%">
                            <BarChart data={chartData}>
                                <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e5e7eb" />
                                <XAxis dataKey="name" axisLine={false} tickLine={false} tick={{ fontSize: 12, fill: '#9ca3af' }} />
                                <YAxis axisLine={false} tickLine={false} tick={{ fontSize: 12, fill: '#9ca3af' }} />
                                <Tooltip
                                    cursor={{ fill: '#f3f4f6' }}
                                    contentStyle={{ backgroundColor: '#fff', borderRadius: '12px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                                />
                                <Bar dataKey="users" fill="#8b5cf6" radius={[4, 4, 0, 0]} barSize={32} />
                            </BarChart>
                        </ResponsiveContainer>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Dashboard
