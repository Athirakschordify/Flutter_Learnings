import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { Bell, CheckCheck, User, Ticket, DollarSign, Star, Settings as SettingsIcon } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';
import PageHeader from '@/components/common/PageHeader/PageHeader';
import { fetchNotifications, markAsRead, markAllAsRead } from '@/store/slices/notificationSlice';
import { showAlert } from '@/lib/sweetalert';
import { cn } from '@/lib/utils';
import { NOTIFICATION_TYPES } from '@/constants';

const getIcon = (type) => {
    const icons = {
        [NOTIFICATION_TYPES.USER]: User,
        [NOTIFICATION_TYPES.TICKET]: Ticket,
        [NOTIFICATION_TYPES.PAYMENT]: DollarSign,
        [NOTIFICATION_TYPES.REVIEW]: Star,
        [NOTIFICATION_TYPES.SYSTEM]: SettingsIcon,
    };
    return icons[type] || Bell;
};

const NotificationItem = ({ notification, onMarkAsRead, onNavigate }) => {
    const Icon = getIcon(notification.type);

    const handleClick = () => {
        if (!notification.read) {
            onMarkAsRead(notification.id);
        }
        if (notification.link) {
            onNavigate(notification.link);
        }
    };

    return (
        <div
            className={cn(
                'flex gap-4 p-4 rounded-lg transition-colors hover:bg-accent cursor-pointer border',
                !notification.read && 'bg-primary/5 border-primary/20'
            )}
            onClick={handleClick}
        >
            <div
                className={cn(
                    'h-12 w-12 rounded-full flex items-center justify-center shrink-0',
                    notification.read ? 'bg-muted' : 'bg-primary/10'
                )}
            >
                <Icon
                    className={cn('h-6 w-6', notification.read ? 'text-muted-foreground' : 'text-primary')}
                />
            </div>
            <div className="flex-1 min-w-0">
                <div className="flex items-start justify-between gap-2">
                    <div className="flex-1">
                        <div className="flex items-center gap-2">
                            <p className={cn('text-sm font-semibold', !notification.read && 'text-foreground')}>
                                {notification.title}
                            </p>
                            {!notification.read && (
                                <Badge variant="default" className="text-xs px-1.5 py-0">
                                    New
                                </Badge>
                            )}
                        </div>
                        <p className="text-sm text-muted-foreground mt-1">{notification.message}</p>
                        <p className="text-xs text-muted-foreground mt-2">{notification.time}</p>
                    </div>
                    {!notification.read && (
                        <div className="h-2 w-2 rounded-full bg-primary shrink-0 mt-1 animate-pulse" />
                    )}
                </div>
            </div>
        </div>
    );
};

const NotificationsPage = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const { notifications, unreadCount } = useSelector((state) => state.notifications);

    useEffect(() => {
        dispatch(fetchNotifications());
    }, [dispatch]);

    const handleMarkAsRead = (id) => {
        dispatch(markAsRead(id));
    };

    const handleMarkAllAsRead = () => {
        dispatch(markAllAsRead())
            .unwrap()
            .then(() => {
                showAlert.toast('All notifications marked as read', 'success');
            });
    };

    return (
        <div className="space-y-6 animate-in fade-in duration-500 max-w-4xl mx-auto">
            <PageHeader
                icon={Bell}
                title="Notifications"
                description={`You have ${unreadCount} unread notification${unreadCount !== 1 ? 's' : ''}`}
                action={
                    unreadCount > 0 && (
                        <Button onClick={handleMarkAllAsRead} variant="outline">
                            <CheckCheck className="h-4 w-4 mr-2" />
                            Mark all as read
                        </Button>
                    )
                }
            />

            <Card>
                <CardHeader>
                    <CardTitle>All Notifications</CardTitle>
                    <CardDescription>Stay updated with your latest activities</CardDescription>
                </CardHeader>
                <CardContent>
                    {notifications.length === 0 ? (
                        <div className="py-12 text-center">
                            <Bell className="h-12 w-12 mx-auto text-muted-foreground opacity-50 mb-4" />
                            <p className="text-sm text-muted-foreground">No notifications yet</p>
                        </div>
                    ) : (
                        <div className="space-y-3">
                            {notifications.map((notification, index) => (
                                <div key={notification.id}>
                                    <NotificationItem
                                        notification={notification}
                                        onMarkAsRead={handleMarkAsRead}
                                        onNavigate={(link) => navigate(link)}
                                    />
                                    {index < notifications.length - 1 && <Separator className="my-3" />}
                                </div>
                            ))}
                        </div>
                    )}
                </CardContent>
            </Card>
        </div>
    );
};

export default NotificationsPage;
