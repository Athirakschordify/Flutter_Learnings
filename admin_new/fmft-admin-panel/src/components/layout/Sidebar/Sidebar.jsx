import { Link, useLocation } from 'react-router-dom';
import { BarChart3, Users, Ticket, Mail, Bell, Settings, Sparkles } from 'lucide-react';
import { cn } from '@/lib/utils';
import { Separator } from '@/components/ui/separator';
import { ROUTES } from '@/constants';

const Sidebar = ({ isOpen, onClose }) => {
    const location = useLocation();

    const menuItems = [
        { path: ROUTES.DASHBOARD, label: 'Dashboard', icon: BarChart3 },
        { path: ROUTES.USERS, label: 'Users', icon: Users },
        { path: ROUTES.TICKETS, label: 'Tickets', icon: Ticket },
        { path: ROUTES.NOTIFICATIONS, label: 'Notifications', icon: Bell },
        { path: ROUTES.EMAILS, label: 'Email Scanner', icon: Mail },
        { path: ROUTES.SETTINGS, label: 'Settings', icon: Settings },
    ];

    return (
        <>
            <aside
                className={cn(
                    'fixed top-0 left-0 z-40 h-screen w-64 transition-transform duration-300 bg-card border-r',
                    isOpen ? 'translate-x-0' : '-translate-x-full lg:translate-x-0'
                )}
            >
                <div className="flex flex-col h-full">
                    <div className="flex items-center gap-3 px-6 py-5 border-b">
                        <div className="w-10 h-10 bg-gradient-to-br from-purple-600 to-pink-600 rounded-xl flex items-center justify-center shadow-lg">
                            <Sparkles className="w-5 h-5 text-white" />
                        </div>
                        <div>
                            <span className="text-lg font-bold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent block">
                                FMFT Admin
                            </span>
                            <span className="text-xs text-muted-foreground">Management Portal</span>
                        </div>
                    </div>

                    <nav className="flex-1 px-3 py-4 space-y-1 overflow-y-auto">
                        {menuItems.map((item) => {
                            const Icon = item.icon;
                            const isActive = location.pathname === item.path;

                            return (
                                <Link
                                    key={item.path}
                                    to={item.path}
                                    onClick={onClose}
                                    className={cn(
                                        'flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all',
                                        isActive
                                            ? 'bg-primary text-primary-foreground shadow-sm'
                                            : 'text-muted-foreground hover:bg-accent hover:text-accent-foreground'
                                    )}
                                >
                                    <Icon className="w-5 h-5" />
                                    <span className="font-medium text-sm">{item.label}</span>
                                </Link>
                            );
                        })}
                    </nav>

                    <Separator />
                    <div className="p-4">
                        <div className="bg-gradient-to-br from-purple-50 to-pink-50 rounded-lg p-4 border">
                            <div className="flex items-center gap-2 mb-2">
                                <Sparkles className="h-4 w-4 text-purple-600" />
                                <span className="text-sm font-semibold">Upgrade Pro</span>
                            </div>
                            <p className="text-xs text-muted-foreground mb-3">
                                Unlock advanced features
                            </p>
                            <button className="w-full bg-gradient-to-r from-purple-600 to-pink-600 text-white text-xs font-medium py-2 rounded-md hover:shadow-lg transition-shadow">
                                Learn More
                            </button>
                        </div>
                    </div>
                </div>
            </aside>

            {isOpen && (
                <div
                    className="fixed inset-0 bg-black/50 z-30 lg:hidden backdrop-blur-sm"
                    onClick={onClose}
                />
            )}
        </>
    );
};

export default Sidebar;
