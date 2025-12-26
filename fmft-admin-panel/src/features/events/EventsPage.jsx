import { Calendar as CalendarIcon, Search, Plus, MapPin, Clock } from 'lucide-react'

const EventsPage = () => {
    const events = [
        { id: 1, name: 'Taylor Swift Concert', date: '2024-12-25', time: '20:00', venue: 'Madison Square Garden', tickets: 450, capacity: 500 },
        { id: 2, name: 'NBA Finals Game 7', date: '2024-12-30', time: '19:30', venue: 'Staples Center', tickets: 380, capacity: 400 },
        { id: 3, name: 'Hamilton Musical', date: '2025-01-05', time: '19:00', venue: 'Broadway Theater', tickets: 290, capacity: 300 },
        { id: 4, name: 'Coachella Festival', date: '2025-04-15', time: '12:00', venue: 'Indio, CA', tickets: 5200, capacity: 6000 },
        { id: 5, name: 'Kevin Hart Comedy Show', date: '2025-01-10', time: '21:00', venue: 'Comedy Club', tickets: 180, capacity: 200 },
    ]

    return (
        <div className="p-4 sm:p-6 lg:p-8">
            {/* Page Header */}
            <div className="mb-8">
                <h1 className="text-3xl font-bold text-gray-900">Events</h1>
                <p className="text-gray-600 mt-1">Manage all events and their tickets</p>
            </div>

            {/* Stats Cards */}
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div className="flex items-center justify-between">
                        <div>
                            <p className="text-sm font-medium text-gray-600">Total Events</p>
                            <p className="text-2xl font-bold text-gray-900 mt-1">156</p>
                        </div>
                        <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                            <CalendarIcon className="w-6 h-6 text-green-600" />
                        </div>
                    </div>
                </div>
                <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div className="flex items-center justify-between">
                        <div>
                            <p className="text-sm font-medium text-gray-600">Upcoming</p>
                            <p className="text-2xl font-bold text-blue-600 mt-1">89</p>
                        </div>
                        <span className="text-xs font-semibold text-blue-600 bg-blue-100 px-2 py-1 rounded-full">57%</span>
                    </div>
                </div>
                <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div className="flex items-center justify-between">
                        <div>
                            <p className="text-sm font-medium text-gray-600">This Month</p>
                            <p className="text-2xl font-bold text-indigo-600 mt-1">23</p>
                        </div>
                        <span className="text-xs font-semibold text-green-600 bg-green-100 px-2 py-1 rounded-full">+15%</span>
                    </div>
                </div>
                <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div className="flex items-center justify-between">
                        <div>
                            <p className="text-sm font-medium text-gray-600">Past Events</p>
                            <p className="text-2xl font-bold text-gray-600 mt-1">67</p>
                        </div>
                        <span className="text-xs font-semibold text-gray-600 bg-gray-100 px-2 py-1 rounded-full">43%</span>
                    </div>
                </div>
            </div>

            {/* Events Grid */}
            <div className="bg-white rounded-xl shadow-sm border border-gray-200">
                {/* Header */}
                <div className="p-6 border-b border-gray-200">
                    <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                        <div className="relative flex-1 max-w-md">
                            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
                            <input
                                type="text"
                                placeholder="Search events..."
                                className="w-full pl-10 pr-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                            />
                        </div>
                        <button className="flex items-center gap-2 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors">
                            <Plus className="w-4 h-4" />
                            <span className="text-sm font-medium">Create Event</span>
                        </button>
                    </div>
                </div>

                {/* Events List */}
                <div className="p-6 space-y-4">
                    {events.map((event) => (
                        <div key={event.id} className="border border-gray-200 rounded-lg p-6 hover:shadow-md transition-shadow">
                            <div className="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
                                <div className="flex-1">
                                    <h3 className="text-lg font-semibold text-gray-900 mb-2">{event.name}</h3>
                                    <div className="flex flex-wrap gap-4 text-sm text-gray-600">
                                        <div className="flex items-center gap-2">
                                            <CalendarIcon className="w-4 h-4" />
                                            <span>{event.date}</span>
                                        </div>
                                        <div className="flex items-center gap-2">
                                            <Clock className="w-4 h-4" />
                                            <span>{event.time}</span>
                                        </div>
                                        <div className="flex items-center gap-2">
                                            <MapPin className="w-4 h-4" />
                                            <span>{event.venue}</span>
                                        </div>
                                    </div>
                                </div>
                                <div className="flex items-center gap-6">
                                    <div className="text-center">
                                        <p className="text-2xl font-bold text-indigo-600">{event.tickets}</p>
                                        <p className="text-xs text-gray-500">Tickets Sold</p>
                                    </div>
                                    <div className="text-center">
                                        <p className="text-2xl font-bold text-gray-900">{event.capacity}</p>
                                        <p className="text-xs text-gray-500">Capacity</p>
                                    </div>
                                    <button className="px-4 py-2 border border-indigo-600 text-indigo-600 rounded-lg hover:bg-indigo-50 transition-colors">
                                        View Details
                                    </button>
                                </div>
                            </div>
                            {/* Progress Bar */}
                            <div className="mt-4">
                                <div className="flex justify-between text-xs text-gray-600 mb-1">
                                    <span>Ticket Sales</span>
                                    <span>{Math.round((event.tickets / event.capacity) * 100)}%</span>
                                </div>
                                <div className="w-full bg-gray-200 rounded-full h-2">
                                    <div
                                        className="bg-indigo-600 h-2 rounded-full transition-all"
                                        style={{ width: `${(event.tickets / event.capacity) * 100}%` }}
                                    ></div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    )
}

export default EventsPage
