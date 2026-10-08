.class public Lapp/liveclearmic/BudsReceiver;
.super Landroid/content/BroadcastReceiver;

.method public constructor <init>()V
.locals 0
invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
.locals 7
:start
if-eqz p2, :done
invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;
move-result-object v0
const-string v1, "android.bluetooth.headset.profile.action.CONNECTION_STATE_CHANGED"
invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v0
if-eqz v0, :done

invoke-static {p1}, Lapp/liveclearmic/HeadsetStore;->hasSaved(Landroid/content/Context;)Z
move-result v0
if-eqz v0, :done

# React only to the one headset explicitly selected in LiveClearMic.
const-string v0, "android.bluetooth.device.extra.DEVICE"
invoke-virtual {p2, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;
move-result-object v2
check-cast v2, Landroid/bluetooth/BluetoothDevice;
if-eqz v2, :done
invoke-static {p1, v2}, Lapp/liveclearmic/HeadsetStore;->isSavedBluetoothDevice(Landroid/content/Context;Landroid/bluetooth/BluetoothDevice;)Z
move-result v3
if-eqz v3, :done

const-string v0, "android.bluetooth.profile.extra.STATE"
const/4 v1, -1
invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
move-result v0

const/4 v1, 2
if-eq v0, v1, :connected
const/4 v1, 0
if-eq v0, v1, :disconnected
goto/16 :done

:connected
invoke-static {p1}, Lapp/liveclearmic/ProbeService;->isUserClosed(Landroid/content/Context;)Z
move-result v1
if-eqz v1, :connected_allowed
const-string v1, "Bluetooth-headset verbonden, maar LiveClearMic is via het menu afgesloten; automatische herstart blijft gepauzeerd."
invoke-static {v1}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
invoke-static {p1}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
goto/16 :done
:connected_allowed
sget-boolean v1, Lapp/liveclearmic/ProbeService;->active:Z
if-nez v1, :done
const-string v1, "Geselecteerde Bluetooth-headset verbonden; automatische herstart wordt aangevraagd."
invoke-static {v1}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
new-instance v4, Landroid/content/Intent;
const-class v5, Lapp/liveclearmic/ProbeService;
invoke-direct {v4, p1, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const-string v5, "AUTO_CONNECT"
invoke-virtual {v4, v5}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
invoke-virtual {p1, v4}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
goto/16 :done

:disconnected
const-string v1, "Geselecteerde Bluetooth-headset ontkoppeld; LiveClearMic-meldingen worden direct gesloten."
invoke-static {v1}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
# The HFP profile broadcast for the selected device is authoritative here.
# Do not wait for AudioManager.getAvailableCommunicationDevices(), which can lag behind.
invoke-static {p1}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
sget-boolean v1, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v1, :done
new-instance v4, Landroid/content/Intent;
const-class v5, Lapp/liveclearmic/ProbeService;
invoke-direct {v4, p1, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const-string v5, "DISCONNECT"
invoke-virtual {v4, v5}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
invoke-virtual {p1, v4}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method
