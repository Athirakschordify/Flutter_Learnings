import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Plus, Eye, Edit, Trash2, Users as UsersIcon } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import PageHeader from '@/components/common/PageHeader/PageHeader';
import SearchBar from '@/components/common/SearchBar/SearchBar';
import LoadingState from '@/components/common/LoadingState/LoadingState';
import { fetchUsers, deleteUser } from '@/store/slices/userSlice';
import { showAlert } from '@/lib/sweetalert';
import { TOAST_MESSAGES, USER_STATUS } from '@/constants';
import Swal from 'sweetalert2';

const UsersPage = () => {
    const dispatch = useDispatch();
    const { users, loading } = useSelector((state) => state.users);
    const [searchQuery, setSearchQuery] = useState('');

    useEffect(() => {
        dispatch(fetchUsers());
    }, [dispatch]);

    const handleDelete = async (id, name) => {
        const confirmed = await showAlert.confirmDelete(`Delete user "${name}"?`);
        if (confirmed) {
            showAlert.loading('Deleting user...');
            try {
                await dispatch(deleteUser(id)).unwrap();
                Swal.close();
                showAlert.success(TOAST_MESSAGES.DELETE_SUCCESS);
            } catch {
                Swal.close();
                showAlert.error(TOAST_MESSAGES.ERROR_GENERIC);
            }
        }
    };

    const filteredUsers = users.filter(
        (user) =>
            user.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
            user.email.toLowerCase().includes(searchQuery.toLowerCase())
    );

    if (loading) {
        return <LoadingState />;
    }

    return (
        <div className="space-y-6 animate-in fade-in duration-500">
            <PageHeader
                icon={UsersIcon}
                title="User Management"
                description="Manage and monitor all registered users"
                action={
                    <Button className="bg-gradient-to-r from-purple-600 to-pink-600 shadow-lg hover:shadow-xl">
                        <Plus className="h-4 w-4 mr-2" />
                        Add User
                    </Button>
                }
            />

            <Card>
                <CardHeader className="pb-4">
                    <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
                        <div>
                            <CardTitle>All Users ({filteredUsers.length})</CardTitle>
                            <CardDescription>A list of all registered users in your system</CardDescription>
                        </div>
                        <SearchBar
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            placeholder="Search users..."
                        />
                    </div>
                </CardHeader>
                <CardContent>
                    <div className="overflow-x-auto">
                        <table className="w-full">
                            <thead>
                                <tr className="border-b">
                                    <th className="text-left py-4 px-4 font-semibold text-sm text-muted-foreground">
                                        User
                                    </th>
                                    <th className="text-left py-4 px-4 font-semibold text-sm text-muted-foreground">
                                        Email
                                    </th>
                                    <th className="text-left py-4 px-4 font-semibold text-sm text-muted-foreground">
                                        Tickets
                                    </th>
                                    <th className="text-left py-4 px-4 font-semibold text-sm text-muted-foreground">
                                        Joined
                                    </th>
                                    <th className="text-left py-4 px-4 font-semibold text-sm text-muted-foreground">
                                        Status
                                    </th>
                                    <th className="text-left py-4 px-4 font-semibold text-sm text-muted-foreground">
                                        Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                {filteredUsers.map((user) => (
                                    <tr key={user.id} className="border-b hover:bg-accent/50 transition-colors">
                                        <td className="py-4 px-4">
                                            <div className="flex items-center gap-3">
                                                <Avatar className="h-10 w-10 border-2 border-background">
                                                    <AvatarFallback className="bg-gradient-to-br from-purple-600 to-pink-600 text-white font-semibold">
                                                        {user.name
                                                            .split(' ')
                                                            .map((n) => n[0])
                                                            .join('')}
                                                    </AvatarFallback>
                                                </Avatar>
                                                <span className="font-medium">{user.name}</span>
                                            </div>
                                        </td>
                                        <td className="py-4 px-4 text-sm text-muted-foreground">{user.email}</td>
                                        <td className="py-4 px-4">
                                            <Badge variant="secondary">{user.tickets}</Badge>
                                        </td>
                                        <td className="py-4 px-4 text-sm text-muted-foreground">{user.joined}</td>
                                        <td className="py-4 px-4">
                                            <Badge variant={user.status === USER_STATUS.ACTIVE ? 'success' : 'secondary'}>
                                                {user.status}
                                            </Badge>
                                        </td>
                                        <td className="py-4 px-4">
                                            <div className="flex items-center gap-1">
                                                <Button variant="ghost" size="icon" className="h-8 w-8">
                                                    <Eye className="h-4 w-4" />
                                                </Button>
                                                <Button variant="ghost" size="icon" className="h-8 w-8">
                                                    <Edit className="h-4 w-4" />
                                                </Button>
                                                <Button
                                                    variant="ghost"
                                                    size="icon"
                                                    className="h-8 w-8 hover:bg-destructive/10 hover:text-destructive"
                                                    onClick={() => handleDelete(user.id, user.name)}
                                                >
                                                    <Trash2 className="h-4 w-4" />
                                                </Button>
                                            </div>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
};

export default UsersPage;
