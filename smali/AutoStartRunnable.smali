.class public Lapp/liveclearmic/AutoStartRunnable;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

.field private context:Landroid/content/Context;
.field private attempt:I

.method public constructor <init>(Landroid/content/Context;)V
.locals 1
invoke-direct {p0}, Ljava/lang/Object;-><init>()V
iput-object p1, p0, Lapp/liveclearmic/AutoStartRunnable;->context:Landroid/content/Context;
const/4 v0, 0
iput v0, p0, Lapp/liveclearmic/AutoStartRunnable;->attempt:I
return-void
.end method

.method public run()V
.locals 6
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-nez v0, :done
:start
iget-object v0, p0, Lapp/liveclearmic/AutoStartRunnable;->context:Landroid/content/Context;
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->hasBudsConnected(Landroid/content/Context;)Z
move-result v1
if-eqz v1, :retry
new-instance v1, Landroid/content/Intent;
const-class v2, Lapp/liveclearmic/ProbeService;
invoke-direct {v1, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const-string v2, "AUTO_CONNECT"
invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
invoke-virtual {v0, v1}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
const-string v0, "Bluetooth: geselecteerde headset verbonden; AUTO automatisch gestart."
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
goto/16 :done
:retry
iget v1, p0, Lapp/liveclearmic/AutoStartRunnable;->attempt:I
add-int/lit8 v1, v1, 1
iput v1, p0, Lapp/liveclearmic/AutoStartRunnable;->attempt:I
const/4 v2, 6
if-lt v1, v2, :again
const-string v0, "Bluetooth: geselecteerde headset verbonden, maar nog niet als communicatie-apparaat beschikbaar binnen de wachttijd."
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
goto/16 :done
:again
new-instance v2, Landroid/os/Handler;
invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
move-result-object v3
invoke-direct {v2, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
const-wide/16 v3, 800
invoke-virtual {v2, p0, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method
