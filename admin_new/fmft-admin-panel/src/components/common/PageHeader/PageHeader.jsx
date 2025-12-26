const PageHeader = ({ icon: Icon, title, description, action }) => {
    return (
        <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-6">
            <div>
                <h2 className="text-3xl font-bold tracking-tight flex items-center gap-2">
                    {Icon && <Icon className="h-7 w-7" />}
                    {title}
                </h2>
                {description && <p className="text-muted-foreground mt-1">{description}</p>}
            </div>
            {action && <div>{action}</div>}
        </div>
    );
};

export default PageHeader;
