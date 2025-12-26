import { InboxIcon } from 'lucide-react';

const EmptyState = ({ icon: Icon = InboxIcon, message = 'No data available' }) => {
    return (
        <div className="py-12 text-center">
            <Icon className="h-12 w-12 mx-auto text-muted-foreground opacity-50 mb-4" />
            <p className="text-sm font-medium text-muted-foreground">{message}</p>
        </div>
    );
};

export default EmptyState;
