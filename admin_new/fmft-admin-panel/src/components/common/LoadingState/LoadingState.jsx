import { Spinner } from '@/components/ui/spinner';

const LoadingState = ({ message = 'Loading...' }) => {
    return (
        <div className="flex flex-col items-center justify-center min-h-[400px]">
            <Spinner size="lg" />
            <p className="mt-4 text-sm text-muted-foreground">{message}</p>
        </div>
    );
};

export default LoadingState;
