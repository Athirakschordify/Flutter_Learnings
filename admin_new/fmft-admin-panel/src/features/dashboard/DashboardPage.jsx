import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Users, Ticket, DollarSign, Mail, Calendar, TrendingUp, Activity } from 'lucide-react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';
import LoadingState from '@/components/common/LoadingState/LoadingState';
import { fetchDashboardData } from '@/store/slices/dashboardSlice';

const StatCard = ({ icon: Icon, title, value, change, gradient }) => (
    <Card className="overflow-hidden">
        <CardContent className="p-6">
            <div className="flex items-center justify-between">
                <div className="space-y-2">
                    <p className="text-sm font-medium text-muted-foreground">{title}</p>
                    <p className="text-3xl font-bold">{value}</p>
                    <p className="text-xs flex items-center gap-1 text-green-600">
                        <TrendingUp className="h-3 w-3" />
                        <span className="font-semibold">{change}</span>
                        <span className="text-muted-foreground">vs last month</span>
                    </p>
                </div>
                <div
                    className={`w-14 h-14 rounded-xl bg-gradient-to-br ${gradient} flex items-center justify-center shadow-lg`}
                >
                    <Icon className="w-7 h-7 text-white" />
                </div>
            </div>
        </CardContent>
    </Card>
);

const DashboardPage = () => {
    const dispatch = useDispatch();
    const { stats, recentActivity, upcomingEvents, loading } = useSelector(
        (state) => state.dashboard
    );

    useEffect(() => {
        dispatch(fetchDashboardData());
    }, [dispatch]);

    if (loading) {
        return <LoadingState />;
    }

    return (
        <div className="space-y-6 animate-in fade-in duration-500">
            <div className="flex items-center justify-between">
                <div>
                    <h2 className="text-3xl font-bold tracking-tight flex items-center gap-2">
                        Dashboard
                        <Activity className="h-6 w-6 text-primary" />
                    </h2>
                    <p className="text-muted-foreground mt-1">
                        Welcome back! Here's what's happening today.
                    </p>
                </div>
                <Badge variant="outline" className="px-4 py-2 text-sm">
                    <div className="w-2 h-2 rounded-full bg-green-500 mr-2 animate-pulse" />
                    Live
                </Badge>
            </div>

            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
                <StatCard
                    icon={Users}
                    title="Total Users"
                    value={stats?.totalUsers?.toLocaleString() || '0'}
                    change="+12.5%"
                    gradient="from-blue-500 to-cyan-500"
                />
                <StatCard
                    icon={Ticket}
                    title="Active Tickets"
                    value={stats?.activeTickets?.toLocaleString() || '0'}
                    change="+8.2%"
                    gradient="from-purple-500 to-pink-500"
                />
                <StatCard
                    icon={DollarSign}
                    title="Revenue"
                    value={`$${stats?.totalRevenue?.toLocaleString() || '0'}`}
                    change="+15.3%"
                    gradient="from-green-500 to-emerald-500"
                />
                <StatCard
                    icon={Mail}
                    title="Emails Scanned"
                    value={stats?.emailsScanned?.toLocaleString() || '0'}
                    change="+23.1%"
                    gradient="from-orange-500 to-red-500"
                />
            </div>

            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-7">
                <Card className="col-span-4">
                    <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                            <Activity className="h-5 w-5" />
                            Recent Activity
                        </CardTitle>
                        <CardDescription>Latest user actions across your platform</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <div className="space-y-3">
                            {recentActivity.map((activity) => (
                                <div
                                    key={activity.id}
                                    className="flex items-center gap-4 p-3 rounded-lg hover:bg-accent transition-colors"
                                >
                                    <Avatar className="h-10 w-10 border-2 border-background shadow-md">
                                        <AvatarFallback className="bg-gradient-to-br from-purple-600 to-pink-600 text-white text-sm font-semibold">
                                            {activity.user.charAt(0)}
                                        </AvatarFallback>
                                    </Avatar>
                                    <div className="flex-1 min-w-0">
                                        <p className="text-sm font-medium leading-none">{activity.user}</p>
                                        <p className="text-sm text-muted-foreground mt-1">{activity.action}</p>
                                    </div>
                                    <div className="text-xs text-muted-foreground whitespace-nowrap">
                                        {activity.time}
                                    </div>
                                </div>
                            ))}
                        </div>
                    </CardContent>
                </Card>

                <Card className="col-span-3">
                    <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                            <Calendar className="h-5 w-5" />
                            Upcoming Events
                        </CardTitle>
                        <CardDescription>Events scheduled for this month</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <div className="space-y-3">
                            {upcomingEvents.map((event) => (
                                <div
                                    key={event.id}
                                    className="flex items-center gap-3 p-3 rounded-lg hover:bg-accent transition-colors"
                                >
                                    <div className="h-10 w-10 rounded-lg bg-purple-100 flex items-center justify-center shrink-0">
                                        <Calendar className="h-5 w-5 text-purple-600" />
                                    </div>
                                    <div className="flex-1 min-w-0">
                                        <p className="text-sm font-medium leading-none truncate">{event.event}</p>
                                        <p className="text-xs text-muted-foreground mt-1">{event.date}</p>
                                    </div>
                                    <Badge variant="secondary" className="font-semibold shrink-0">
                                        ${event.amount}
                                    </Badge>
                                </div>
                            ))}
                        </div>
                    </CardContent>
                </Card>
            </div>
        </div>
    );
};

export default DashboardPage;
