import { Bell as BellIcon, Check, X, Clock, AlertCircle } from 'lucide-react'

const NotificationsPage = () => {
    const notifications = [
        { id: 1, type: 'success', title: 'New user registered', message: 'John Doe has successfully registered', time: '2 minutes ago', read: false },
        { id: 2, type: 'info', title: 'Ticket scanned', message: 'Ticket #12345 was scanned for Taylor Swift Concert', time: '15 minutes ago', read: false },
        { id: 3, type: 'warning', title: 'Low ticket availability', message: 'NBA Finals Game 7 has only 20 tickets remaining', time: '1 hour ago', read: true },
        { id: 4, type: 'success', title: 'Event created', message: 'New event "Hamilton Musical" has been created', time: '2 hours ago', read: true },
        { id: 5, type: 'error', title: 'Payment failed', message: 'Payment for ticket #67890 has failed', time: '3 hours ago', read: false },
        { id: 6, type: 'info', title: 'System update', message: 'System maintenance scheduled for tonight at 2 AM', time: '5 hours ago', read: true },
    ]

    const getIcon = (type) => {
        switch (type) {
            case 'success':
                return <Check className="w-5 h-5 text-green-600" />
            case 'error':
                return <X className="w-5 h-5 text-red-600" />
            case 'warning':
                return <AlertCircle className="w-5 h-5 text-yellow-600" />
            default:
                return <BellIcon className="w-5 h-5 text-blue-600" />
        }
    }

    const getBgColor = (type) => {
        switch (type) {
            case 'success':
                return 'bg-green-100'
            case 'error':
                return 'bg-red-100'
            case 'warning':
                return 'bg-yellow-100'
            default:
                return 'bg-blue-100'
        }
    }

    return (
        <div className="p-4 sm:p-6 lg:p-8">
            {/* Page Header */}
            <div className="mb-8">
                <h1 className="text-3xl font-bold text-gray-900">Notifications</h1>
                <p className="text-gray-600 mt-1">Stay updated with all system notifications</p>
            </div>

            {/* Stats Cards */}
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div className="flex items-center justify-between">
                        <div>
                            <p className="text-sm font-medium text-gray-600">Total</p>
                            <p className="text-2xl font-bold text-gray-900 mt-1">156</p>
                        </div>
                        <div className="w-12 h-12 bg-pink-100 rounded-lg flex items-center justify-center">
                            <BellIcon className="w-6 h-6 text-pink-600" />
                        </div>
                    </div>
                </div>
                <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div className="flex items-center justify-between">
                        <div>
                            <p className="text-sm font-medium text-gray-600">Unread</p>
                            <p className="text-2xl font-bold text-red-600 mt-1">12</p>
                        </div>
                        <span className="text-xs font-semibold text-red-600 bg-red-100 px-2 py-1 rounded-full">New</span>
                    </div>
                </div>
                <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div className="flex items-center justify-between">
                        <div>
                            <p className="text-sm font-medium text-gray-600">Today</p>
                            <p className="text-2xl font-bold text-blue-600 mt-1">23</p>
                        </div>
                        <Clock className="w-8 h-8 text-blue-600" />
                    </div>
                </div>
                <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div className="flex items-center justify-between">
                        <div>
                            <p className="text-sm font-medium text-gray-600">This Week</p>
                            <p className="text-2xl font-bold text-indigo-600 mt-1">89</p>
                        </div>
                        <span className="text-xs font-semibold text-green-600 bg-green-100 px-2 py-1 rounded-full">+15%</span>
                    </div>
                </div>
            </div>

            {/* Notifications List */}
            <div className="bg-white rounded-xl shadow-sm border border-gray-200">
                {/* Header */}
                <div className="p-6 border-b border-gray-200">
                    <div className="flex items-center justify-between">
                        <h2 className="text-lg font-semibold text-gray-900">All Notifications</h2>
                        <button className="text-sm text-indigo-600 hover:text-indigo-700 font-medium">
                            Mark all as read
                        </button>
                    </div>
                </div>

                {/* Notifications */}
                <div className="divide-y divide-gray-200">
                    {notifications.map((notification) => (
                        <div
                            key={notification.id}
                            className={`p-6 hover:bg-gray-50 transition-colors ${!notification.read ? 'bg-blue-50/30' : ''}`}
                        >
                            <div className="flex gap-4">
                                <div className={`w-10 h-10 ${getBgColor(notification.type)} rounded-lg flex items-center justify-center flex-shrink-0`}>
                                    {getIcon(notification.type)}
                                </div>
                                <div className="flex-1 min-w-0">
                                    <div className="flex items-start justify-between gap-4">
                                        <div className="flex-1">
                                            <h3 className="text-sm font-semibold text-gray-900 mb-1">
                                                {notification.title}
                                                {!notification.read && (
                                                    <span className="ml-2 inline-block w-2 h-2 bg-blue-600 rounded-full"></span>
                                                )}
                                            </h3>
                                            <p className="text-sm text-gray-600 mb-2">{notification.message}</p>
                                            <div className="flex items-center gap-2 text-xs text-gray-500">
                                                <Clock className="w-3 h-3" />
                                                <span>{notification.time}</span>
                                            </div>
                                        </div>
                                        <div className="flex gap-2">
                                            {!notification.read && (
                                                <button className="p-2 hover:bg-gray-100 rounded-lg transition-colors" title="Mark as read">
                                                    <Check className="w-4 h-4 text-gray-600" />
                                                </button>
                                            )}
                                            <button className="p-2 hover:bg-gray-100 rounded-lg transition-colors" title="Delete">
                                                <X className="w-4 h-4 text-gray-600" />
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    )
}

export default NotificationsPage
