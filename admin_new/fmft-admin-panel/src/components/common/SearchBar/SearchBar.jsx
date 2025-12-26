import { Search, Filter } from 'lucide-react';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';

const SearchBar = ({ value, onChange, placeholder = 'Search...', onFilter }) => {
    return (
        <div className="flex gap-2 w-full sm:w-auto">
            <div className="relative flex-1 sm:w-64">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                <Input placeholder={placeholder} value={value} onChange={onChange} className="pl-9" />
            </div>
            {onFilter && (
                <Button variant="outline" size="icon" onClick={onFilter}>
                    <Filter className="h-4 w-4" />
                </Button>
            )}
        </div>
    );
};

export default SearchBar;
