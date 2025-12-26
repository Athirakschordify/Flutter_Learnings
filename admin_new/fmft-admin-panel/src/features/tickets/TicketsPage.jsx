import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Download, Eye, Ticket as TicketIcon } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import PageHeader from '@/components/common/PageHeader/PageHeader';
import SearchBar from '@/components/common/SearchBar/SearchBar';
import LoadingState from '@/components/common/LoadingState/LoadingState';
import { fetchTickets } from '@/store/slices/ticketSlice';
import { TICKET_STATUS } from '@/constants';

const TicketsPage = () => {
    const dispatch = useDispatch();
    const { tickets, loading } = useSelector((state) => state.tickets);
    const [searchQuery, setSearchQuery] = useState('');

    useEffect(() => {
        dispatch(fetchTickets());
    }, [dispatch]);

    const filteredTickets = tickets.filter(
        (ticket) =>
            ticket.event.toLowerCase().includes(searchQuery.toLowerCase()) ||
            ticket.user.toLowerCase().includes(searchQuery.toLowerCase())
    );

    if (loading) {
        return <LoadingState />;
    }

    return (
        <div className="space-y-6 animate-in fade-in duration-500">
            <PageHeader
                icon={TicketIcon}
                title="Ticket Management"
                description="View and manage all event tickets"
                action={
                    <Button className="bg-gradient-to-r from-purple-600 to-pink-600 shadow-lg hover:shadow-xl">
                        <Download className="h-4 w-4 mr-2" />
                        Export Data
                    </Button>
                }
            />

            <Card>
                <CardHeader className="pb-4">
                    <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
                        <div>
                            <CardTitle>All Tickets ({filteredTickets.length})</CardTitle>
                            <CardDescription>
                                Complete list of tickets issued across all events
                            </CardDescription>
                        </div>
                        <SearchBar
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            placeholder="Search tickets..."
                        />
                    </div>
                </CardHeader>
                <CardContent>
                    <div className="overflow-x-auto">
                        <table className="w-full">
                            <thead>
                                <tr className="border-b">
                                    <th className="text-left py-4 px-4 font-semibold text-sm text-muted-foreground">
                                        Event
                                    </th>
                                    <th className="text-left py-4 px-4 font-semibold text-sm text-muted-foreground">
                                        User
                                    </th>
                                    <th className="text-left py-4 px-4 font-semibold text-sm text-muted-foreground">
                                        Date
                                    </th>
                                    <th className="text-left py-4 px-4 font-semibold text-sm text-muted-foreground">
                                        Amount
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
                                {filteredTickets.map((ticket) => (
                                    <tr key={ticket.id} className="border-b hover:bg-accent/50 transition-colors">
                                        <td className="py-4 px-4">
                                            <div className="flex items-center gap-3">
                                                <div className="h-10 w-10 rounded-lg bg-purple-100 flex items-center justify-center shrink-0">
                                                    <TicketIcon className="h-5 w-5 text-purple-600" />
                                                </div>
                                                <span className="font-medium">{ticket.event}</span>
                                            </div>
                                        </td>
                                        <td className="py-4 px-4 text-sm text-muted-foreground">{ticket.user}</td>
                                        <td className="py-4 px-4 text-sm text-muted-foreground">{ticket.date}</td>
                                        <td className="py-4 px-4">
                                            <span className="font-semibold text-green-600">${ticket.amount}</span>
                                        </td>
                                        <td className="py-4 px-4">
                                            <Badge
                                                variant={ticket.status === TICKET_STATUS.ACTIVE ? 'success' : 'secondary'}
                                            >
                                                {ticket.status}
                                            </Badge>
                                        </td>
                                        <td className="py-4 px-4">
                                            <div className="flex items-center gap-1">
                                                <Button variant="ghost" size="icon" className="h-8 w-8">
                                                    <Eye className="h-4 w-4" />
                                                </Button>
                                                <Button variant="ghost" size="icon" className="h-8 w-8">
                                                    <Download className="h-4 w-4" />
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

export default TicketsPage;
