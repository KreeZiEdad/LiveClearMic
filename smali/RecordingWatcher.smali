.class public Lapp/liveclearmic/RecordingWatcher;
.super Landroid/media/AudioManager$AudioRecordingCallback;

.field private service:Lapp/liveclearmic/ProbeService;

.method public constructor <init>(Lapp/liveclearmic/ProbeService;)V
.locals 0
invoke-direct {p0}, Landroid/media/AudioManager$AudioRecordingCallback;-><init>()V
iput-object p1, p0, Lapp/liveclearmic/RecordingWatcher;->service:Lapp/liveclearmic/ProbeService;
return-void
.end method

.method public onRecordingConfigChanged(Ljava/util/List;)V
.locals 1
iget-object v0, p0, Lapp/liveclearmic/RecordingWatcher;->service:Lapp/liveclearmic/ProbeService;
if-eqz v0, :done
invoke-virtual {v0, p1}, Lapp/liveclearmic/ProbeService;->onRecordingConfigsChanged(Ljava/util/List;)V
:done
return-void
.end method
