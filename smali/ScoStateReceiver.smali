.class public Lapp/liveclearmic/ScoStateReceiver;
.super Landroid/content/BroadcastReceiver;

.field private service:Lapp/liveclearmic/ProbeService;

.method public constructor <init>(Lapp/liveclearmic/ProbeService;)V
.locals 0
invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
iput-object p1, p0, Lapp/liveclearmic/ScoStateReceiver;->service:Lapp/liveclearmic/ProbeService;
return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
.locals 1
iget-object v0, p0, Lapp/liveclearmic/ScoStateReceiver;->service:Lapp/liveclearmic/ProbeService;
if-eqz v0, :done
invoke-virtual {v0, p2}, Lapp/liveclearmic/ProbeService;->onScoStateChanged(Landroid/content/Intent;)V
:done
return-void
.end method
