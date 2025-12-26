import { Settings as SettingsIcon, Save } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Separator } from '@/components/ui/separator';
import PageHeader from '@/components/common/PageHeader/PageHeader';
import { showAlert } from '@/lib/sweetalert';
import { TOAST_MESSAGES } from '@/constants';

const SettingsPage = () => {
    const handleSave = () => {
        showAlert.success(TOAST_MESSAGES.SAVE_SUCCESS);
    };

    return (
        <div className="space-y-6 animate-in fade-in duration-500 max-w-4xl">
            <PageHeader
                icon={SettingsIcon}
                title="Settings"
                description="Manage your application preferences and configuration"
            />

            <Card>
                <CardHeader>
                    <CardTitle>General Settings</CardTitle>
                    <CardDescription>Configure basic application settings</CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                    <div className="grid gap-4 sm:grid-cols-2">
                        <div className="space-y-2">
                            <Label htmlFor="appName">Application Name</Label>
                            <Input id="appName" defaultValue="FMFT" />
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="supportEmail">Support Email</Label>
                            <Input id="supportEmail" type="email" defaultValue="support@fmft.com" />
                        </div>
                    </div>

                    <Separator />

                    <div className="space-y-4">
                        <h4 className="font-semibold text-sm">Notification Preferences</h4>
                        <div className="flex items-center justify-between p-4 border rounded-lg">
                            <div>
                                <p className="font-medium text-sm">Email Notifications</p>
                                <p className="text-xs text-muted-foreground mt-0.5">
                                    Send email notifications to users
                                </p>
                            </div>
                            <Button variant="outline" size="sm">
                                Enable
                            </Button>
                        </div>
                    </div>

                    <Button onClick={handleSave} className="bg-gradient-to-r from-purple-600 to-pink-600">
                        <Save className="h-4 w-4 mr-2" />
                        Save Changes
                    </Button>
                </CardContent>
            </Card>

            <Card>
                <CardHeader>
                    <CardTitle>Email Scanner Settings</CardTitle>
                    <CardDescription>Configure email scanning preferences</CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                    <div className="flex items-center justify-between p-4 border rounded-lg">
                        <div>
                            <p className="font-medium text-sm">Auto Scan Emails</p>
                            <p className="text-xs text-muted-foreground mt-0.5">
                                Automatically scan incoming emails for tickets
                            </p>
                        </div>
                        <Button variant="outline" size="sm">
                            Enable
                        </Button>
                    </div>
                    <div className="space-y-2">
                        <Label htmlFor="scanFrequency">Scan Frequency</Label>
                        <select
                            id="scanFrequency"
                            className="w-full h-10 px-3 rounded-md border border-input bg-background text-sm"
                        >
                            <option>Real-time</option>
                            <option>Every 5 minutes</option>
                            <option>Hourly</option>
                            <option>Daily</option>
                        </select>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
};

export default SettingsPage;
