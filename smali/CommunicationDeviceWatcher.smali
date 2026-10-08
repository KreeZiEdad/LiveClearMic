.class public Lapp/liveclearmic/CommunicationDeviceWatcher;
.super Ljava/lang/Object;
.implements Landroid/media/AudioManager$OnCommunicationDeviceChangedListener;

.field private service:Lapp/liveclearmic/ProbeService;

.method public constructor <init>(Lapp/liveclearmic/ProbeService;)V
.locals 0
invoke-direct {p0}, Ljava/lang/Object;-><init>()V
iput-object p1, p0, Lapp/liveclearmic/CommunicationDeviceWatcher;->service:Lapp/liveclearmic/ProbeService;
return-void
.end method

.method public onCommunicationDeviceChanged(Landroid/media/AudioDeviceInfo;)V
.locals 1
iget-object v0, p0, Lapp/liveclearmic/CommunicationDeviceWatcher;->service:Lapp/liveclearmic/ProbeService;
if-eqz v0, :done
invoke-virtual {v0, p1}, Lapp/liveclearmic/ProbeService;->onCommunicationDeviceChanged(Landroid/media/AudioDeviceInfo;)V
:done
return-void
.end method
