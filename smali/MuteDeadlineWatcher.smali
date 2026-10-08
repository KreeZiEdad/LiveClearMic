.class public Lapp/liveclearmic/MuteDeadlineWatcher;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

.field private service:Lapp/liveclearmic/ProbeService;

.method public constructor <init>(Lapp/liveclearmic/ProbeService;)V
.locals 0
invoke-direct {p0}, Ljava/lang/Object;-><init>()V
iput-object p1, p0, Lapp/liveclearmic/MuteDeadlineWatcher;->service:Lapp/liveclearmic/ProbeService;
return-void
.end method

.method public run()V
.locals 1
iget-object v0, p0, Lapp/liveclearmic/MuteDeadlineWatcher;->service:Lapp/liveclearmic/ProbeService;
if-eqz v0, :done
invoke-virtual {v0}, Lapp/liveclearmic/ProbeService;->deadlineAdaptiveMute()V
:done
return-void
.end method
