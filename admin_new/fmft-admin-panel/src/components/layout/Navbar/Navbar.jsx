import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { Menu, Bell, LogOut, User, Search } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { useAuth } from '@/hooks/useAuth';
import { fetchNotifications } from '@/store/slices/notificationSlice';
import { ROUTES } from '@/constants';

const Navbar = ({ onMenuToggle }) => {
    const { user, logout } = useAuth();
    const navigate = useNavigate();
    const dispatch = useDispatch();
    const { unreadCount } = useSelector((state) => state.notifications);

    useEffect(() => {
        dispatch(fetchNotifications());
    }, [dispatch]);

    return (
        <header className="sticky top-0 z-30 bg-background/95 backdrop-blur border-b">
            <div className="flex items-center justify-between px-6 py-3">
                <div className="flex items-center gap-4 flex-1">
                    <Button variant="ghost" size="icon" className="lg:hidden" onClick={onMenuToggle}>
                        <Menu className="h-5 w-5" />
                    </Button>

                    <div className="hidden md:flex items-center flex-1 max-w-md">
                        <div className="relative w-full">
                            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                            <Input placeholder="Search..." className="pl-9 h-9" />
                        </div>
                    </div>
                </div>

                <div className="flex items-center gap-2">
                    <Button
                        variant="ghost"
                        size="icon"
                        className="relative"
                        onClick={() => navigate(ROUTES.NOTIFICATIONS)}
                    >
                        <Bell className="h-5 w-5" />
                        {unreadCount > 0 && (
                            <span className="absolute -top-1 -right-1 h-5 w-5 rounded-full bg-destructive text-destructive-foreground text-xs font-bold flex items-center justify-center animate-pulse">
                                {unreadCount > 9 ? '9+' : unreadCount}
                            </span>
                        )}
                    </Button>

                    <div className="hidden sm:flex items-center gap-3 ml-4 pl-4 border-l">
                        <div className="text-right">
                            <p className="text-sm font-medium leading-none">{user?.name}</p>
                            <p className="text-xs text-muted-foreground mt-0.5">{user?.role}</p>
                        </div>
                        <Avatar className="h-9 w-9">
                            <AvatarFallback className="bg-gradient-to-br from-purple-600 to-pink-600 text-white text-sm">
                                {user?.name?.split(' ').map((n) => n[0]).join('') || <User className="h-4 w-4" />}
                            </AvatarFallback>
                        </Avatar>
                    </div>

                    <Button variant="ghost" size="icon" onClick={logout} title="Logout" className="ml-2">
                        <LogOut className="h-4 w-4" />
                    </Button>
                </div>
            </div>
        </header>
    );
};

export default Navbar;
