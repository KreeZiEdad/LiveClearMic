.class public Lapp/liveclearmic/ProbeService;
.super Landroid/app/Service;
.implements Ljava/lang/Runnable;
.field public static volatile active:Z
.field public static message:Ljava/lang/String;
.field public static logText:Ljava/lang/String;
.field private audio:Landroid/media/AudioManager;
.field private handler:Landroid/os/Handler;
.field private wake:Landroid/os/PowerManager$WakeLock;
.field private stopped:Z
.field private started:J
.field private selected:Landroid/media/AudioDeviceInfo;
.field private legacySco:Z
.field private lastDevice:Ljava/lang/String;
.field private reasserts:I
.field private previousMode:I
.field private track:Landroid/media/AudioTrack;
.field private silent:[B
.field private lostTicks:I
.field private disconnectTicks:I
.field public static volatile filterActive:Z
.field public static volatile filterBypassed:Z
.field public static volatile lastDetectionAt:J
.field public static volatile lastSetDeviceMs:J
.field public static volatile lastScoReturnMs:J
.field public static volatile lastTrackBuiltMs:J
.field public static volatile lastTrackPlayMs:J
.field public static volatile lastHfpReadyMs:J
.field public static volatile lastRouteConfirmMs:J
.field public static volatile lastRouteActiveMs:J
.field public static volatile lastWasFirstStart:Z
.field private static volatile suppressControlOff:Z
.field private noRecordingTicks:I
.field private recordingWatcher:Lapp/liveclearmic/RecordingWatcher;
.field private hfpStarts:I
.field private mutePrevious:Z
.field private volatile mutePending:Z
.field private muteStartedAt:J
.field public static volatile lastMuteDurationMs:J
.field public static volatile lastMuteReleaseReason:Ljava/lang/String;
.field private scoReceiver:Lapp/liveclearmic/ScoStateReceiver;
.field private volatile scoAudioConnected:Z
.field public static volatile lastScoConnectedMs:J
.field public static volatile lastRecordingInputBluetoothMs:J
.field public static volatile lastRecordingInputDevice:Ljava/lang/String;
.field public static volatile lastRecordingInputMatched:Z
.field private lastRecordingInput:Ljava/lang/String;
.field private communicationWatcher:Lapp/liveclearmic/CommunicationDeviceWatcher;
.field private volatile selectedCommRouteActive:Z
.field private communicationRouteSelectedAt:J
.field public static volatile lastCommDeviceCallbackMs:J
.field public static volatile lastPolledCommRouteMs:J
.field public static volatile lastTrackRoutedMs:J
.field public static volatile lastAdaptiveRouteMs:J
.field public static volatile lastAdaptiveRouteSource:Ljava/lang/String;
.field public static volatile lastStartMuteEnabled:Z
.field private systemMuteApplied:Z
.field public static volatile lastSystemMuteOnMs:J
.field public static volatile lastSystemMuteOffMs:J
.field public static volatile lastSystemMuteSetOk:Z
.field public static volatile lastSystemMuteRestoreOk:Z
.field private muteDeadlineAt:J
.field private muteTargetMs:I
.field public static volatile lastMuteTargetDeltaMs:J

.method public constructor <init>()V
.locals 0
invoke-direct {p0}, Landroid/app/Service;-><init>()V
return-void
.end method


.method public static isCallActive(Landroid/content/Context;)Z
.locals 3
const-string v0, "audio"
invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v0
check-cast v0, Landroid/media/AudioManager;
invoke-virtual {v0}, Landroid/media/AudioManager;->getMode()I
move-result v1
const/4 v2, 2
if-eq v1, v2, :call_active
const/4 v2, 3
if-eq v1, v2, :call_active
const/4 v0, 0
return v0
:call_active
const/4 v0, 1
return v0
.end method

.method public static isStartMuteEnabled(Landroid/content/Context;)Z
.locals 3
const-string v0, "liveclearmic_state"
const/4 v1, 0
invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
const-string v2, "startmute_enabled_174"
const/4 v1, 1
invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
move-result v0
return v0
.end method

.method public static setStartMuteEnabled(Landroid/content/Context;Z)V
.locals 3
const-string v0, "liveclearmic_state"
const/4 v1, 0
invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
move-result-object v0
const-string v1, "startmute_enabled_174"
invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
return-void
.end method

.method public static getStartMuteDurationMs(Landroid/content/Context;)I
.locals 4
const-string v0, "liveclearmic_state"
const/4 v1, 0
invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
const-string v2, "startmute_duration_ms_197"
const/16 v3, 500
invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I
move-result v0
const/16 v1, 250
if-lt v0, v1, :duration_fallback
const/16 v1, 750
if-gt v0, v1, :duration_fallback
return v0
:duration_fallback
const/16 v0, 500
return v0
.end method

.method public static setStartMuteDurationMs(Landroid/content/Context;I)V
.locals 4
const/16 v0, 250
if-ge p1, v0, :check_max
move p1, v0
:check_max
const/16 v0, 750
if-le p1, v0, :store
move p1, v0
:store
const-string v0, "liveclearmic_state"
const/4 v1, 0
invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
move-result-object v0
const-string v1, "startmute_duration_ms_197"
invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;
invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
return-void
.end method













.method public static setUserClosed(Landroid/content/Context;Z)V
.locals 3
const-string v0, "liveclearmic_state"
const/4 v1, 0
invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
move-result-object v0
const-string v1, "user_closed"
invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
return-void
.end method


.method public static finishAllTasksAndKill(Landroid/content/Context;)V
.locals 4
:try_start
const-string v0, "activity"
invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v0
check-cast v0, Landroid/app/ActivityManager;
invoke-virtual {v0}, Landroid/app/ActivityManager;->getAppTasks()Ljava/util/List;
move-result-object v0
invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
move-result-object v1
:task_loop
invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
move-result v2
if-eqz v2, :try_end
invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
move-result-object v2
check-cast v2, Landroid/app/ActivityManager$AppTask;
invoke-virtual {v2}, Landroid/app/ActivityManager$AppTask;->finishAndRemoveTask()V
goto/16 :task_loop
:try_end
goto/16 :kill
:error
move-exception v0
:kill
invoke-static {}, Landroid/os/Process;->myPid()I
move-result v0
invoke-static {v0}, Landroid/os/Process;->killProcess(I)V
return-void
.catch Ljava/lang/Throwable; {:try_start .. :try_end} :error
.end method

.method public static isUserClosed(Landroid/content/Context;)Z
.locals 3
const-string v0, "liveclearmic_state"
const/4 v1, 0
invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
const-string v2, "user_closed"
invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
move-result v0
return v0
.end method

.method public static note(Ljava/lang/String;)V
.locals 4
sput-object p0, Lapp/liveclearmic/ProbeService;->message:Ljava/lang/String;
sget-object v0, Lapp/liveclearmic/ProbeService;->logText:Ljava/lang/String;
if-eqz v0, :empty
invoke-virtual {v0}, Ljava/lang/String;->length()I
move-result v1
const/16 v2, 30000
if-lt v1, v2, :append
:empty
const-string v0, ""
:append
new-instance v1, Ljava/lang/StringBuilder;
invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v2
invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v0, " ms: "
invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
const-string v0, "\n"
invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v0
sput-object v0, Lapp/liveclearmic/ProbeService;->logText:Ljava/lang/String;
return-void
.end method

.method public static modeName(I)Ljava/lang/String;
.locals 2
if-eqz p0, :normal
const/4 v0, 3
if-eq p0, v0, :comm
const/4 v0, 1
if-eq p0, v0, :ring
const/4 v0, 2
if-eq p0, v0, :call
new-instance v0, Ljava/lang/StringBuilder;
invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
const-string v1, "Android-modus: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
const-string v1, " (status v2.0)"
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v0
return-object v0
:normal
const-string v0, "Android-modus: NORMAL (0)"
return-object v0
:comm
const-string v0, "Android-modus: IN_COMMUNICATION (3)"
return-object v0
:ring
const-string v0, "Android-modus: RINGTONE (1)"
return-object v0
:call
const-string v0, "Android-modus: IN_CALL (2)"
return-object v0
.end method

.method public static deviceText(Landroid/media/AudioDeviceInfo;)Ljava/lang/String;
.locals 4
if-nez p0, :has
const-string v0, "geen"
return-object v0
:has
new-instance v0, Ljava/lang/StringBuilder;
invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
const-string v1, "id="
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {p0}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v1
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
const-string v1, " type="
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {p0}, Landroid/media/AudioDeviceInfo;->getType()I
move-result v1
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
const-string v1, " naam="
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {p0}, Landroid/media/AudioDeviceInfo;->getProductName()Ljava/lang/CharSequence;
move-result-object v1
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public listCommunicationDevices()Ljava/lang/String;
.locals 8
:start
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
invoke-virtual {v0}, Landroid/media/AudioManager;->getAvailableCommunicationDevices()Ljava/util/List;
move-result-object v0
new-instance v1, Ljava/lang/StringBuilder;
invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
const-string v2, "Beschikbare communicatie-apparaten:"
invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
const/4 v2, 0
invoke-interface {v0}, Ljava/util/List;->size()I
move-result v3
:loop
if-ge v2, v3, :done
invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;
move-result-object v4
check-cast v4, Landroid/media/AudioDeviceInfo;
const-string v5, "\n  "
invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-static {v4}, Lapp/liveclearmic/ProbeService;->deviceText(Landroid/media/AudioDeviceInfo;)Ljava/lang/String;
move-result-object v5
invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
add-int/lit8 v2, v2, 1
goto/16 :loop
:done
invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v0
return-object v0
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
const-string v0, "Beschikbare communicatie-apparaten konden niet worden gelezen."
return-object v0
.catch Ljava/lang/Throwable; {:start .. :done} :error
.end method

.method public findBluetoothCommunicationDevice()Landroid/media/AudioDeviceInfo;
.locals 2
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->hasSaved(Landroid/content/Context;)Z
move-result v0
if-eqz v0, :none
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->findSavedConnected(Landroid/content/Context;)Landroid/media/AudioDeviceInfo;
move-result-object v1
return-object v1
:none
const/4 v0, 0
return-object v0
.end method

.method public static hasBudsConnected(Landroid/content/Context;)Z
.locals 2
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->hasSaved(Landroid/content/Context;)Z
move-result v0
if-eqz v0, :no
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->findSavedConnected(Landroid/content/Context;)Landroid/media/AudioDeviceInfo;
move-result-object v1
if-eqz v1, :no
const/4 v0, 1
return v0
:no
const/4 v0, 0
return v0
.end method

.method public static showToast(Landroid/content/Context;Ljava/lang/String;)V
.locals 2
:start
const/4 v0, 1
invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
move-result-object v0
invoke-virtual {v0}, Landroid/widget/Toast;->show()V
:end
return-void
:error
move-exception v0
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public static failure(Ljava/lang/Throwable;)V
.locals 2
new-instance v0, Ljava/lang/StringBuilder;
invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
const-string v1, "Android-fout: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {p0}, Ljava/lang/Throwable;->toString()Ljava/lang/String;
move-result-object v1
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
return-void
.end method

.method public static requestTileUpdate(Landroid/content/Context;)V
.locals 0
return-void
.end method

.method public static statusIcon(Landroid/content/Context;)Landroid/graphics/drawable/Icon;
.locals 4
:start
invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;
move-result-object v0
const-string v1, "liveclearmic_status.png"
invoke-virtual {v0, v1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;
move-result-object v0
invoke-static {v0}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;
move-result-object v1
invoke-virtual {v0}, Ljava/io/InputStream;->close()V
if-eqz v1, :fallback
invoke-static {v1}, Landroid/graphics/drawable/Icon;->createWithBitmap(Landroid/graphics/Bitmap;)Landroid/graphics/drawable/Icon;
move-result-object v0
return-object v0
:fallback
sget v1, Landroid/R$drawable;->ic_btn_speak_now:I
invoke-static {p0, v1}, Landroid/graphics/drawable/Icon;->createWithResource(Landroid/content/Context;I)Landroid/graphics/drawable/Icon;
move-result-object v0
return-object v0
:error
move-exception v0
sget v1, Landroid/R$drawable;->ic_btn_speak_now:I
invoke-static {p0, v1}, Landroid/graphics/drawable/Icon;->createWithResource(Landroid/content/Context;I)Landroid/graphics/drawable/Icon;
move-result-object v0
return-object v0
.catch Ljava/lang/Throwable; {:start .. :fallback} :error
.end method

.method public static notificationsAllowed(Landroid/content/Context;)Z
.locals 2
const-string v0, "android.permission.POST_NOTIFICATIONS"
invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I
move-result v0
if-nez v0, :no
const-string v0, "notification"
invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v0
check-cast v0, Landroid/app/NotificationManager;
invoke-virtual {v0}, Landroid/app/NotificationManager;->areNotificationsEnabled()Z
move-result v0
return v0
:no
const/4 v0, 0
return v0
.end method

.method public static cancelControlNotifications(Landroid/content/Context;)V
.locals 3
:start
const-string v0, "notification"
invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v0
check-cast v0, Landroid/app/NotificationManager;
const/4 v1, 1
invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V
const/4 v1, 2
invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V
:end
goto/16 :done
:error
move-exception v0
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public static postControlOff(Landroid/content/Context;)V
.locals 9
:start
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->notificationsAllowed(Landroid/content/Context;)Z
move-result v0
if-eqz v0, :done
const-string v0, "liveclearmic_148"
const-string v1, "LiveClearMic"
const/4 v2, 2
new-instance v3, Landroid/app/NotificationChannel;
invoke-direct {v3, v0, v1, v2}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V
const-string v1, "notification"
invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v1
check-cast v1, Landroid/app/NotificationManager;
invoke-virtual {v1, v3}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V
new-instance v2, Landroid/app/Notification$Builder;
invoke-direct {v2, p0, v0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->statusIcon(Landroid/content/Context;)Landroid/graphics/drawable/Icon;
move-result-object v0
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setSmallIcon(Landroid/graphics/drawable/Icon;)Landroid/app/Notification$Builder;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->notifTitleOff(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->notifOffText(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
const/4 v0, 1
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setOnlyAlertOnce(Z)Landroid/app/Notification$Builder;
const/4 v0, 0
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;
const-string v0, "service"
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;
new-instance v3, Landroid/content/Intent;
const-class v4, Lapp/liveclearmic/MainActivity;
invoke-direct {v3, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const v4, 0x24000000
invoke-virtual {v3, v4}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
const/4 v4, 0
const v5, 0x0c000000
invoke-static {p0, v4, v3, v5}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
move-result-object v3
invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;
new-instance v3, Landroid/content/Intent;
const-class v4, Lapp/liveclearmic/ProbeService;
invoke-direct {v3, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const-string v4, "START"
invoke-virtual {v3, v4}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
const/4 v4, 2
invoke-static {p0, v4, v3, v5}, Landroid/app/PendingIntent;->getForegroundService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
move-result-object v3
const/4 v4, 0
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->turnOn(Landroid/content/Context;)Ljava/lang/String;
move-result-object v5
invoke-virtual {v2, v4, v5, v3}, Landroid/app/Notification$Builder;->addAction(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;
invoke-virtual {v2}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;
move-result-object v2
const/4 v3, 1
invoke-virtual {v1, v3, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public static postNoBuds(Landroid/content/Context;)V
.locals 7
:start
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->notificationsAllowed(Landroid/content/Context;)Z
move-result v0
if-eqz v0, :done
const-string v0, "liveclearmic_148"
const-string v1, "notification"
invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v1
check-cast v1, Landroid/app/NotificationManager;
new-instance v2, Landroid/app/Notification$Builder;
invoke-direct {v2, p0, v0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->statusIcon(Landroid/content/Context;)Landroid/graphics/drawable/Icon;
move-result-object v0
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setSmallIcon(Landroid/graphics/drawable/Icon;)Landroid/app/Notification$Builder;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->noSelectedTitle(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->noSelectedText(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
const/4 v0, 1
invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;
invoke-virtual {v2}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;
move-result-object v2
const/4 v3, 2
invoke-virtual {v1, v3, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public onCreate()V
.locals 6
invoke-super {p0}, Landroid/app/Service;->onCreate()V
const-string v0, "audio"
invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v0
check-cast v0, Landroid/media/AudioManager;
iput-object v0, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
new-instance v1, Landroid/os/Handler;
invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
move-result-object v2
invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->handler:Landroid/os/Handler;
:start
new-instance v2, Lapp/liveclearmic/RecordingWatcher;
invoke-direct {v2, p0}, Lapp/liveclearmic/RecordingWatcher;-><init>(Lapp/liveclearmic/ProbeService;)V
iput-object v2, p0, Lapp/liveclearmic/ProbeService;->recordingWatcher:Lapp/liveclearmic/RecordingWatcher;
invoke-virtual {v0, v2, v1}, Landroid/media/AudioManager;->registerAudioRecordingCallback(Landroid/media/AudioManager$AudioRecordingCallback;Landroid/os/Handler;)V
new-instance v3, Lapp/liveclearmic/CommunicationDeviceWatcher;
invoke-direct {v3, p0}, Lapp/liveclearmic/CommunicationDeviceWatcher;-><init>(Lapp/liveclearmic/ProbeService;)V
iput-object v3, p0, Lapp/liveclearmic/ProbeService;->communicationWatcher:Lapp/liveclearmic/CommunicationDeviceWatcher;
invoke-virtual {p0}, Landroid/content/Context;->getMainExecutor()Ljava/util/concurrent/Executor;
move-result-object v4
invoke-virtual {v0, v4, v3}, Landroid/media/AudioManager;->addOnCommunicationDeviceChangedListener(Ljava/util/concurrent/Executor;Landroid/media/AudioManager$OnCommunicationDeviceChangedListener;)V
new-instance v3, Lapp/liveclearmic/ScoStateReceiver;
invoke-direct {v3, p0}, Lapp/liveclearmic/ScoStateReceiver;-><init>(Lapp/liveclearmic/ProbeService;)V
iput-object v3, p0, Lapp/liveclearmic/ProbeService;->scoReceiver:Lapp/liveclearmic/ScoStateReceiver;
new-instance v4, Landroid/content/IntentFilter;
const-string v5, "android.media.ACTION_SCO_AUDIO_STATE_UPDATED"
invoke-direct {v4, v5}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V
const/4 v5, 2
invoke-virtual {p0, v3, v4, v5}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;I)Landroid/content/Intent;
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public notice()Landroid/app/Notification;
.locals 8
const-string v0, "liveclearmic_148"
const-string v1, "LiveClearMic"
const/4 v2, 2
new-instance v3, Landroid/app/NotificationChannel;
invoke-direct {v3, v0, v1, v2}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V
const-string v1, "notification"
invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v1
check-cast v1, Landroid/app/NotificationManager;
invoke-virtual {v1, v3}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V
new-instance v1, Landroid/app/Notification$Builder;
invoke-direct {v1, p0, v0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->statusIcon(Landroid/content/Context;)Landroid/graphics/drawable/Icon;
move-result-object v0
invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setSmallIcon(Landroid/graphics/drawable/Icon;)Landroid/app/Notification$Builder;
# 1.8.3: a phone/VoIP communication route is presentation-only PAUZE.
# LiveClearMic remains enabled and does not alter the call route.
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->isCallActive(Landroid/content/Context;)Z
move-result v5
if-eqz v5, :notice_title_on
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->notifTitlePaused(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
goto/16 :notice_title_ready
:notice_title_on
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->notifTitleOn(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
:notice_title_ready
invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
if-eqz v5, :notice_normal_state
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->notifCallText(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
goto/16 :text_ready
:notice_normal_state
sget-boolean v0, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-eqz v0, :notice_not_active
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->notifActiveText(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
goto/16 :text_ready
:notice_not_active
sget-boolean v0, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
if-eqz v0, :waiting
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->notifBypassText(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
goto/16 :text_ready
:waiting
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->notifWaitingText(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
:text_ready
invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
const/4 v0, 1
invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;
invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setOnlyAlertOnce(Z)Landroid/app/Notification$Builder;
invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setForegroundServiceBehavior(I)Landroid/app/Notification$Builder;
const/4 v0, 0
invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;
const-string v0, "service"
invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;
new-instance v2, Landroid/content/Intent;
const-class v3, Lapp/liveclearmic/MainActivity;
invoke-direct {v2, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const v3, 0x24000000
invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
const/4 v3, 0
const v4, 0x0c000000
invoke-static {p0, v3, v2, v4}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
move-result-object v2
invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;
# One notification card, one ID. During a recording the action only toggles
# the filter; it never stops/recreates the foreground service. Standby uses CLOSE.
# During a phone/VoIP call 1.8.3 reports PAUZE/Gesprek actief only;
# the call route stays untouched and the notification action remains CLOSE.
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->isCallActive(Landroid/content/Context;)Z
move-result v5
if-nez v5, :standby_close_action
sget-boolean v0, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-eqz v0, :notice_check_bypass_action
new-instance v2, Landroid/content/Intent;
const-class v3, Lapp/liveclearmic/ProbeService;
invoke-direct {v2, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const-string v3, "FILTER_OFF"
invoke-virtual {v2, v3}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
const/4 v3, 4
invoke-static {p0, v3, v2, v4}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
move-result-object v2
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->turnOff(Landroid/content/Context;)Ljava/lang/String;
move-result-object v4
goto/16 :notice_action_ready
:notice_check_bypass_action
sget-boolean v0, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
if-eqz v0, :standby_close_action
new-instance v2, Landroid/content/Intent;
const-class v3, Lapp/liveclearmic/ProbeService;
invoke-direct {v2, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const-string v3, "FILTER_ON"
invoke-virtual {v2, v3}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
const/4 v3, 5
invoke-static {p0, v3, v2, v4}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
move-result-object v2
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->turnOn(Landroid/content/Context;)Ljava/lang/String;
move-result-object v4
goto/16 :notice_action_ready
:standby_close_action
new-instance v2, Landroid/content/Intent;
const-class v3, Lapp/liveclearmic/ProbeService;
invoke-direct {v2, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const-string v3, "EXIT"
invoke-virtual {v2, v3}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
const/4 v3, 3
invoke-static {p0, v3, v2, v4}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
move-result-object v2
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->closeAction(Landroid/content/Context;)Ljava/lang/String;
move-result-object v4
:notice_action_ready
const/4 v3, 0
invoke-virtual {v1, v3, v4, v2}, Landroid/app/Notification$Builder;->addAction(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;
invoke-virtual {v1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;
move-result-object v0
return-object v0
.end method

.method public static diagnose(Landroid/content/Context;)Ljava/lang/String;
.locals 6
new-instance v0, Ljava/lang/StringBuilder;
invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
const-string v1, "LiveClearMic 2.0 - support diagnosis\nModel: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
const-string v1, "\nAndroid: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
const-string v1, " / API "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget v1, Landroid/os/Build$VERSION;->SDK_INT:I
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
const-string v1, "\nAutomatic mode: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-boolean v1, Lapp/liveclearmic/ProbeService;->active:Z
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
const-string v1, "\nHFP filter active: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-boolean v1, Lapp/liveclearmic/ProbeService;->filterActive:Z
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
const-string v1, "\nCall active: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->isCallActive(Landroid/content/Context;)Z
move-result v1
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
const-string v1, "\nStartmute: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->isStartMuteEnabled(Landroid/content/Context;)Z
move-result v1
if-eqz v1, :diag_startmute_off
const-string v1, "ON (SYSTEM, "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->getStartMuteDurationMs(Landroid/content/Context;)I
move-result v1
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
const-string v1, " ms)"
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
goto/16 :diag_startmute_done
:diag_startmute_off
const-string v1, "OFF"
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
:diag_startmute_done
const-string v1, "\nRecording since reconnect: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
const-wide/16 v4, 0
cmp-long v1, v2, v4
if-lez v1, :diag_no_recording
const-string v1, "yes"
goto/16 :diag_recording_ready
:diag_no_recording
const-string v1, "no"
:diag_recording_ready
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
const-string v1, "\nSaved headset(s): "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->displayNames(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
const-string v1, "audio"
invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v4
check-cast v4, Landroid/media/AudioManager;
const-string v1, "\nAndroid audio mode: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v4}, Landroid/media/AudioManager;->getMode()I
move-result v1
invoke-static {v1}, Lapp/liveclearmic/ProbeService;->modeName(I)Ljava/lang/String;
move-result-object v1
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
const-string v1, "\nCommunication device: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v4}, Landroid/media/AudioManager;->getCommunicationDevice()Landroid/media/AudioDeviceInfo;
move-result-object v5
invoke-static {v5}, Lapp/liveclearmic/ProbeService;->deviceText(Landroid/media/AudioDeviceInfo;)Ljava/lang/String;
move-result-object v1
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
const-string v1, "\nBluetooth SCO reported: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v4}, Landroid/media/AudioManager;->isBluetoothScoOn()Z
move-result v1
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
const-string v1, "\nLast recording input: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-object v1, Lapp/liveclearmic/ProbeService;->lastRecordingInputDevice:Ljava/lang/String;
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

const-string v1, "\n\nKey timing from detection:\n  setCommunicationDevice return: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastSetDeviceMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms\n  startBluetoothSco return: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastScoReturnMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms\n  AudioTrack play return: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastTrackPlayMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms\n  HFP start path ready: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastHfpReadyMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms\n  communication-device callback: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastCommDeviceCallbackMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms\n  SCO CONNECTED: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastScoConnectedMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms\n  Bluetooth input active: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastRecordingInputBluetoothMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms"
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

const-string v1, "\n\nStartmute last recording: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-boolean v1, Lapp/liveclearmic/ProbeService;->lastStartMuteEnabled:Z
if-eqz v1, :diag_last_startmute_off
const-string v1, "SYSTEM\n  on: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastSystemMuteOnMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms\n  off: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastSystemMuteOffMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms\n  total: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastMuteDurationMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms\n  delta vs target: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastMuteTargetDeltaMs:J
invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v1, " ms\n  mute set/restore confirmed: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-boolean v1, Lapp/liveclearmic/ProbeService;->lastSystemMuteSetOk:Z
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
const-string v1, "/"
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-boolean v1, Lapp/liveclearmic/ProbeService;->lastSystemMuteRestoreOk:Z
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
const-string v1, "\n  release reason: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-object v1, Lapp/liveclearmic/ProbeService;->lastMuteReleaseReason:Ljava/lang/String;
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
goto/16 :diag_last_startmute_done
:diag_last_startmute_off
const-string v1, "OFF"
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
:diag_last_startmute_done
const-string v1, "\n\nLast status: "
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-object v1, Lapp/liveclearmic/ProbeService;->message:Ljava/lang/String;
if-nez v1, :diag_status_ready
const-string v1, ""
:diag_status_ready
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public saveLog()V
.locals 4
:start
const-string v0, "diagnose"
const/4 v1, 0
invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
move-result-object v0
const-string v1, "laatste_log"
sget-object v2, Lapp/liveclearmic/ProbeService;->logText:Ljava/lang/String;
invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
:end
return-void
:error
move-exception v0
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public startKeepAliveTrack()Z
.locals 8
:start
# Build the static silent AudioTrack only if no prepared instance exists.
iget-object v4, p0, Lapp/liveclearmic/ProbeService;->track:Landroid/media/AudioTrack;
if-nez v4, :play_ready
const/16 v0, 3200
new-array v1, v0, [B
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->silent:[B

new-instance v2, Landroid/media/AudioAttributes$Builder;
invoke-direct {v2}, Landroid/media/AudioAttributes$Builder;-><init>()V
const/4 v3, 0
invoke-virtual {v2, v3}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;
move-result-object v2
invoke-virtual {v2}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;
move-result-object v2

new-instance v3, Landroid/media/AudioFormat$Builder;
invoke-direct {v3}, Landroid/media/AudioFormat$Builder;-><init>()V
const/4 v4, 2
invoke-virtual {v3, v4}, Landroid/media/AudioFormat$Builder;->setEncoding(I)Landroid/media/AudioFormat$Builder;
move-result-object v3
const/16 v4, 16000
invoke-virtual {v3, v4}, Landroid/media/AudioFormat$Builder;->setSampleRate(I)Landroid/media/AudioFormat$Builder;
move-result-object v3
const/4 v4, 4
invoke-virtual {v3, v4}, Landroid/media/AudioFormat$Builder;->setChannelMask(I)Landroid/media/AudioFormat$Builder;
move-result-object v3
invoke-virtual {v3}, Landroid/media/AudioFormat$Builder;->build()Landroid/media/AudioFormat;
move-result-object v3

new-instance v4, Landroid/media/AudioTrack$Builder;
invoke-direct {v4}, Landroid/media/AudioTrack$Builder;-><init>()V
invoke-virtual {v4, v2}, Landroid/media/AudioTrack$Builder;->setAudioAttributes(Landroid/media/AudioAttributes;)Landroid/media/AudioTrack$Builder;
move-result-object v4
invoke-virtual {v4, v3}, Landroid/media/AudioTrack$Builder;->setAudioFormat(Landroid/media/AudioFormat;)Landroid/media/AudioTrack$Builder;
move-result-object v4
const/16 v5, 3200
invoke-virtual {v4, v5}, Landroid/media/AudioTrack$Builder;->setBufferSizeInBytes(I)Landroid/media/AudioTrack$Builder;
move-result-object v4
const/4 v5, 0
invoke-virtual {v4, v5}, Landroid/media/AudioTrack$Builder;->setTransferMode(I)Landroid/media/AudioTrack$Builder;
move-result-object v4
invoke-virtual {v4}, Landroid/media/AudioTrack$Builder;->build()Landroid/media/AudioTrack;
move-result-object v4
iput-object v4, p0, Lapp/liveclearmic/ProbeService;->track:Landroid/media/AudioTrack;
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v6
sget-wide v0, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
sub-long v6, v6, v0
sput-wide v6, Lapp/liveclearmic/ProbeService;->lastTrackBuiltMs:J

iget-object v5, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
if-eqz v5, :write
invoke-virtual {v4, v5}, Landroid/media/AudioTrack;->setPreferredDevice(Landroid/media/AudioDeviceInfo;)Z
move-result v5
:write
iget-object v5, p0, Lapp/liveclearmic/ProbeService;->silent:[B
const/4 v6, 0
const/16 v7, 3200
invoke-virtual {v4, v5, v6, v7}, Landroid/media/AudioTrack;->write([BII)I
move-result v5
const/4 v5, 0
const/16 v6, 1600
const/4 v7, -1
invoke-virtual {v4, v5, v6, v7}, Landroid/media/AudioTrack;->setLoopPoints(III)I
move-result v5

:play_ready
# Important for latency: no diagnostic string building occurs before play().
invoke-virtual {v4}, Landroid/media/AudioTrack;->play()V
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v0
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
sub-long v0, v0, v2
sput-wide v0, Lapp/liveclearmic/ProbeService;->lastTrackPlayMs:J
const-string v5, "Stil VOICE_CALL AudioTrack speelt in lus; snelle HFP-startpad actief."
invoke-static {v5}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
const/4 v0, 1
return v0
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->stopKeepAliveTrack()V
const/4 v0, 0
return v0
.catch Ljava/lang/Throwable; {:start .. :play_ready} :error
.catch Ljava/lang/Throwable; {:play_ready .. :error} :error
.end method

.method public stopKeepAliveTrack()V
.locals 2
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->track:Landroid/media/AudioTrack;
if-eqz v0, :done
const/4 v1, 0
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->track:Landroid/media/AudioTrack;
:start
invoke-virtual {v0}, Landroid/media/AudioTrack;->stop()V
invoke-virtual {v0}, Landroid/media/AudioTrack;->release()V
const-string v1, "Stille VOICE_CALL AudioTrack gestopt en vrijgegeven."
invoke-static {v1}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
:end
goto/16 :clear
:error
move-exception v1
invoke-static {v1}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:clear
const/4 v0, 0
iput-object v0, p0, Lapp/liveclearmic/ProbeService;->silent:[B
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method



.method public updateNotice()V
.locals 4
:start
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v0, :done
const-string v0, "notification"
invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v0
check-cast v0, Landroid/app/NotificationManager;
const/4 v1, 1
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->notice()Landroid/app/Notification;
move-result-object v2
invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public isTargetRecordingActive()Z
.locals 6
:start
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
invoke-virtual {v0}, Landroid/media/AudioManager;->getActiveRecordingConfigurations()Ljava/util/List;
move-result-object v0
const/4 v1, 0
invoke-interface {v0}, Ljava/util/List;->size()I
move-result v2
:loop
if-ge v1, v2, :none
invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;
move-result-object v3
check-cast v3, Landroid/media/AudioRecordingConfiguration;
invoke-virtual {v3}, Landroid/media/AudioRecordingConfiguration;->getClientAudioSource()I
move-result v4
const/4 v5, 1
if-eq v4, v5, :yes
const/4 v5, 5
if-eq v4, v5, :yes
const/4 v5, 6
if-eq v4, v5, :yes
const/16 v5, 9
if-eq v4, v5, :yes
const/16 v5, 10
if-eq v4, v5, :yes
add-int/lit8 v1, v1, 1
goto/16 :loop
:yes
const/4 v0, 1
return v0
:none
const/4 v0, 0
return v0
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
const/4 v0, 0
return v0
.catch Ljava/lang/Throwable; {:start .. :none} :error
.end method

.method public pollAdaptiveRoutes()V
.locals 8
:start
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
if-eqz v0, :end
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v1
sget-wide v5, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
sub-long v1, v1, v5

# Poll the real AudioManager communication route every watcher cycle. Besides
# diagnostics this remains the authoritative communication-route signal in 1.8.3.
iget-object v3, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
if-eqz v3, :comm_not_selected
invoke-virtual {v3}, Landroid/media/AudioManager;->getCommunicationDevice()Landroid/media/AudioDeviceInfo;
move-result-object v3
if-eqz v3, :comm_not_selected
invoke-virtual {v3}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v4
invoke-virtual {v0}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v5
if-ne v4, v5, :comm_not_selected

# Remember the first polled selected-route observation for diagnostics.
sget-wide v5, Lapp/liveclearmic/ProbeService;->lastPolledCommRouteMs:J
const-wide/16 v3, 0
cmp-long v7, v5, v3
if-ltz v7, :mark_route_active
sput-wide v1, Lapp/liveclearmic/ProbeService;->lastPolledCommRouteMs:J

:mark_route_active
iget-boolean v4, p0, Lapp/liveclearmic/ProbeService;->selectedCommRouteActive:Z
if-nez v4, :poll_track
const/4 v4, 1
iput-boolean v4, p0, Lapp/liveclearmic/ProbeService;->selectedCommRouteActive:Z
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v5
iput-wide v5, p0, Lapp/liveclearmic/ProbeService;->communicationRouteSelectedAt:J
goto/16 :poll_track

:comm_not_selected
# Stability must be continuous: any non-selected route resets the settle window.
const/4 v4, 0
iput-boolean v4, p0, Lapp/liveclearmic/ProbeService;->selectedCommRouteActive:Z
const-wide/16 v5, -1
iput-wide v5, p0, Lapp/liveclearmic/ProbeService;->communicationRouteSelectedAt:J

:poll_track
# AudioTrack.getRoutedDevice remains diagnostic only. It proved too optimistic
# on the Galaxy S24/OnePlus Buds path and never controls mask release in 1.8.3.
sget-wide v3, Lapp/liveclearmic/ProbeService;->lastTrackRoutedMs:J
const-wide/16 v5, 0
cmp-long v7, v3, v5
if-gez v7, :end
sget-wide v3, Lapp/liveclearmic/ProbeService;->lastTrackPlayMs:J
cmp-long v7, v3, v5
if-ltz v7, :end
iget-object v3, p0, Lapp/liveclearmic/ProbeService;->track:Landroid/media/AudioTrack;
if-eqz v3, :end
invoke-virtual {v3}, Landroid/media/AudioTrack;->getPlayState()I
move-result v4
const/4 v5, 3
if-ne v4, v5, :end
invoke-virtual {v3}, Landroid/media/AudioTrack;->getRoutedDevice()Landroid/media/AudioDeviceInfo;
move-result-object v3
if-eqz v3, :end
invoke-virtual {v3}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v4
invoke-virtual {v0}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v5
if-ne v4, v5, :end
sput-wide v1, Lapp/liveclearmic/ProbeService;->lastTrackRoutedMs:J
:end
return-void
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public watchRouteMeasurement()V
.locals 8
sget-wide v0, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
const-wide/16 v6, 0
cmp-long v2, v0, v6
if-lez v2, :done
:route_measure_loop
sget-wide v3, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
cmp-long v2, v3, v0
if-nez v2, :done
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v3
sub-long v3, v3, v0
const-wide/16 v5, 1800
cmp-long v2, v3, v5
if-gez v2, :finalize
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->pollAdaptiveRoutes()V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->chooseAdaptiveRoute()J
move-result-wide v3
const-wide/16 v3, 5
invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
goto/16 :route_measure_loop
:finalize
# One final poll at the end of the correlation window, then persist the finished values.
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->pollAdaptiveRoutes()V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->chooseAdaptiveRoute()J
move-result-wide v3
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->saveLog()V
:done
return-void
.end method


.method public chooseAdaptiveRoute()J
.locals 8
const-wide/16 v0, -1
const-string v2, "nog niet beschikbaar"
const-wide/16 v5, 0

# One-shot direct confirmation.
sget-wide v3, Lapp/liveclearmic/ProbeService;->lastRouteConfirmMs:J
cmp-long v7, v3, v5
if-ltz v7, :candidate_callback
move-wide v0, v3
const-string v2, "directe routecheck"

:candidate_callback
sget-wide v3, Lapp/liveclearmic/ProbeService;->lastCommDeviceCallbackMs:J
cmp-long v7, v3, v5
if-ltz v7, :candidate_polled
cmp-long v7, v0, v5
if-ltz v7, :use_callback
cmp-long v7, v3, v0
if-gez v7, :candidate_polled
:use_callback
move-wide v0, v3
const-string v2, "communication-device callback"

:candidate_polled
sget-wide v3, Lapp/liveclearmic/ProbeService;->lastPolledCommRouteMs:J
cmp-long v7, v3, v5
if-ltz v7, :candidate_track
cmp-long v7, v0, v5
if-ltz v7, :use_polled
cmp-long v7, v3, v0
if-gez v7, :candidate_track
:use_polled
move-wide v0, v3
const-string v2, "5 ms communication-route polling"

:candidate_track
sget-wide v3, Lapp/liveclearmic/ProbeService;->lastTrackRoutedMs:J
cmp-long v7, v3, v5
if-ltz v7, :chosen
cmp-long v7, v0, v5
if-ltz v7, :use_track
cmp-long v7, v3, v0
if-gez v7, :chosen
:use_track
move-wide v0, v3
const-string v2, "AudioTrack.getRoutedDevice"

:chosen
sput-wide v0, Lapp/liveclearmic/ProbeService;->lastAdaptiveRouteMs:J
sput-object v2, Lapp/liveclearmic/ProbeService;->lastAdaptiveRouteSource:Ljava/lang/String;
return-wide v0
.end method



.method public isSelectedCommunicationRoute()Z
.locals 5
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
if-eqz v0, :no
iget-object v1, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
if-nez v1, :have_selected
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->findBluetoothCommunicationDevice()Landroid/media/AudioDeviceInfo;
move-result-object v1
if-eqz v1, :no
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
:have_selected
invoke-virtual {v0}, Landroid/media/AudioManager;->getCommunicationDevice()Landroid/media/AudioDeviceInfo;
move-result-object v2
if-eqz v2, :no
invoke-virtual {v2}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v3
invoke-virtual {v1}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v4
if-ne v3, v4, :no
const/4 v0, 1
return v0
:no
const/4 v0, 0
return v0
.end method












.method public startAdaptiveMute()V
.locals 8
iget-boolean v0, p0, Lapp/liveclearmic/ProbeService;->mutePending:Z
if-nez v0, :done
:start
# Fail-safe cleanup from a previous interrupted cycle before taking a new mute.
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->releaseSystemMuteForOverlap()V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->isStartMuteEnabled(Landroid/content/Context;)Z
move-result v0
sput-boolean v0, Lapp/liveclearmic/ProbeService;->lastStartMuteEnabled:Z
const-wide/16 v1, -1
sput-wide v1, Lapp/liveclearmic/ProbeService;->lastMuteDurationMs:J
sput-wide v1, Lapp/liveclearmic/ProbeService;->lastSystemMuteOnMs:J
sput-wide v1, Lapp/liveclearmic/ProbeService;->lastSystemMuteOffMs:J
sput-wide v1, Lapp/liveclearmic/ProbeService;->lastMuteTargetDeltaMs:J
const/4 v3, 0
sput-boolean v3, Lapp/liveclearmic/ProbeService;->lastSystemMuteSetOk:Z
sput-boolean v3, Lapp/liveclearmic/ProbeService;->lastSystemMuteRestoreOk:Z
iput-boolean v3, p0, Lapp/liveclearmic/ProbeService;->selectedCommRouteActive:Z
iput-wide v1, p0, Lapp/liveclearmic/ProbeService;->communicationRouteSelectedAt:J
if-nez v0, :mask_on
iput-boolean v3, p0, Lapp/liveclearmic/ProbeService;->mutePending:Z
const-string v4, "n.v.t. - Startmute uitgeschakeld"
sput-object v4, Lapp/liveclearmic/ProbeService;->lastMuteReleaseReason:Ljava/lang/String;
goto/16 :done
:mask_on
const/4 v0, 1
iput-boolean v0, p0, Lapp/liveclearmic/ProbeService;->mutePending:Z
sget-wide v1, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
iput-wide v1, p0, Lapp/liveclearmic/ProbeService;->muteStartedAt:J
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->getStartMuteDurationMs(Landroid/content/Context;)I
move-result v3
iput v3, p0, Lapp/liveclearmic/ProbeService;->muteTargetMs:I
int-to-long v4, v3
add-long v4, v4, v1
iput-wide v4, p0, Lapp/liveclearmic/ProbeService;->muteDeadlineAt:J
# SYSTEM mute remains the only Startmute method in 2.0 and starts immediately at t=0.
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->applySystemMute()V
const-string v4, "SYSTEM actief tot sliderdoel"
sput-object v4, Lapp/liveclearmic/ProbeService;->lastMuteReleaseReason:Ljava/lang/String;
new-instance v4, Lapp/liveclearmic/MuteDeadlineWatcher;
invoke-direct {v4, p0}, Lapp/liveclearmic/MuteDeadlineWatcher;-><init>(Lapp/liveclearmic/ProbeService;)V
new-instance v5, Ljava/lang/Thread;
const-string v6, "LiveClearMic-startmute-deadline"
invoke-direct {v5, v4, v6}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V
invoke-virtual {v5}, Ljava/lang/Thread;->start()V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
const-string v1, "Startmute-startfout"
invoke-virtual {p0, v1}, Lapp/liveclearmic/ProbeService;->releaseAdaptiveMute(Ljava/lang/String;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method


.method public applySystemMute()V
.locals 8
:start
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
if-eqz v0, :done
invoke-virtual {v0}, Landroid/media/AudioManager;->isMicrophoneMute()Z
move-result v1
iput-boolean v1, p0, Lapp/liveclearmic/ProbeService;->mutePrevious:Z
if-nez v1, :already_muted
const/4 v2, 1
invoke-virtual {v0, v2}, Landroid/media/AudioManager;->setMicrophoneMute(Z)V
iput-boolean v2, p0, Lapp/liveclearmic/ProbeService;->systemMuteApplied:Z
goto/16 :check
:already_muted
const/4 v2, 0
iput-boolean v2, p0, Lapp/liveclearmic/ProbeService;->systemMuteApplied:Z
:check
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v3
iget-wide v5, p0, Lapp/liveclearmic/ProbeService;->muteStartedAt:J
sub-long v3, v3, v5
sput-wide v3, Lapp/liveclearmic/ProbeService;->lastSystemMuteOnMs:J
invoke-virtual {v0}, Landroid/media/AudioManager;->isMicrophoneMute()Z
move-result v1
sput-boolean v1, Lapp/liveclearmic/ProbeService;->lastSystemMuteSetOk:Z
new-instance v5, Ljava/lang/StringBuilder;
invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
const-string v6, "MASK: systeemmute AAN na "
invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v5, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v6, " ms; bevestigd="
invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v5
invoke-static {v5}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public releaseSystemMuteForOverlap()V
.locals 8
iget-boolean v0, p0, Lapp/liveclearmic/ProbeService;->systemMuteApplied:Z
if-eqz v0, :done
:start
iget-object v1, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
if-eqz v1, :done
iget-boolean v2, p0, Lapp/liveclearmic/ProbeService;->mutePrevious:Z
if-nez v2, :restore_previous_muted
const/4 v2, 0
invoke-virtual {v1, v2}, Landroid/media/AudioManager;->setMicrophoneMute(Z)V
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v3
iget-wide v5, p0, Lapp/liveclearmic/ProbeService;->muteStartedAt:J
sub-long v3, v3, v5
sput-wide v3, Lapp/liveclearmic/ProbeService;->lastSystemMuteOffMs:J
invoke-virtual {v1}, Landroid/media/AudioManager;->isMicrophoneMute()Z
move-result v2
if-nez v2, :restore_not_confirmed
const/4 v2, 1
sput-boolean v2, Lapp/liveclearmic/ProbeService;->lastSystemMuteRestoreOk:Z
const/4 v2, 0
iput-boolean v2, p0, Lapp/liveclearmic/ProbeService;->systemMuteApplied:Z
goto/16 :log
:restore_not_confirmed
const/4 v2, 0
sput-boolean v2, Lapp/liveclearmic/ProbeService;->lastSystemMuteRestoreOk:Z
# Leave systemMuteApplied=true so a later stop/error path retries the restore.
:log
new-instance v5, Ljava/lang/StringBuilder;
invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
const-string v6, "MASK: systeemmute UIT aangevraagd na "
invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v5, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v6, " ms; bevestigd="
invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-boolean v6, Lapp/liveclearmic/ProbeService;->lastSystemMuteRestoreOk:Z
invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v5
invoke-static {v5}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
goto/16 :done
:restore_previous_muted
# LCM did not create the mute when the microphone was already muted; never undo that state.
const/4 v2, 1
sput-boolean v2, Lapp/liveclearmic/ProbeService;->lastSystemMuteRestoreOk:Z
const/4 v2, 0
iput-boolean v2, p0, Lapp/liveclearmic/ProbeService;->systemMuteApplied:Z
:end
goto/16 :done
:error
move-exception v0
const/4 v1, 0
sput-boolean v1, Lapp/liveclearmic/ProbeService;->lastSystemMuteRestoreOk:Z
# Keep systemMuteApplied=true so the next cleanup path can retry.
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method













.method public deadlineAdaptiveMute()V
.locals 7
iget-boolean v0, p0, Lapp/liveclearmic/ProbeService;->mutePending:Z
if-eqz v0, :done
:start
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v1
iget-wide v3, p0, Lapp/liveclearmic/ProbeService;->muteDeadlineAt:J
sub-long v3, v3, v1
const-wide/16 v5, 0
cmp-long v0, v3, v5
if-lez v0, :deadline_reached
invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
:deadline_reached
iget-boolean v0, p0, Lapp/liveclearmic/ProbeService;->mutePending:Z
if-eqz v0, :done
const-string v0, "SYSTEM sliderdoel bereikt"
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->releaseAdaptiveMute(Ljava/lang/String;)V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
const-string v0, "SYSTEM deadlinefout"
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->releaseAdaptiveMute(Ljava/lang/String;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method





.method public onCommunicationDeviceChanged(Landroid/media/AudioDeviceInfo;)V
.locals 10
:start
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
if-eqz p1, :not_selected
if-eqz v0, :not_selected
invoke-virtual {p1}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v1
invoke-virtual {v0}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v2
if-ne v1, v2, :not_selected

invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v3
# Preserve the earliest point of one continuous selected-route period. A later
# callback for the same route must not restart the settle window.
iget-boolean v9, p0, Lapp/liveclearmic/ProbeService;->selectedCommRouteActive:Z
if-nez v9, :callback_route_already_active
const/4 v1, 1
iput-boolean v1, p0, Lapp/liveclearmic/ProbeService;->selectedCommRouteActive:Z
iput-wide v3, p0, Lapp/liveclearmic/ProbeService;->communicationRouteSelectedAt:J
:callback_route_already_active
# Correlation build: record this callback even when Startmute is OFF.
sget-wide v5, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
const-wide/16 v7, 0
cmp-long v9, v5, v7
if-lez v9, :done
sub-long v5, v3, v5
sput-wide v5, Lapp/liveclearmic/ProbeService;->lastCommDeviceCallbackMs:J
new-instance v1, Ljava/lang/StringBuilder;
invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
const-string v2, "COMM callback: geselecteerde HFP-route actief na "
invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v1, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v2, " ms: "
invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-static {p1}, Lapp/liveclearmic/ProbeService;->deviceText(Landroid/media/AudioDeviceInfo;)Ljava/lang/String;
move-result-object v2
invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v1
invoke-static {v1}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
goto/16 :done

:not_selected
const/4 v1, 0
iput-boolean v1, p0, Lapp/liveclearmic/ProbeService;->selectedCommRouteActive:Z
const-wide/16 v2, -1
iput-wide v2, p0, Lapp/liveclearmic/ProbeService;->communicationRouteSelectedAt:J
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public onScoStateChanged(Landroid/content/Intent;)V
.locals 7
if-eqz p1, :done
:start
const-string v0, "android.media.extra.SCO_AUDIO_STATE"
const/4 v1, -1
invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
move-result v0
const/4 v1, 1
if-ne v0, v1, :not_connected
iput-boolean v1, p0, Lapp/liveclearmic/ProbeService;->scoAudioConnected:Z
sget-wide v2, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
const-wide/16 v4, 0
cmp-long v6, v2, v4
if-lez v6, :log_connected
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v4
sub-long v4, v4, v2
sput-wide v4, Lapp/liveclearmic/ProbeService;->lastScoConnectedMs:J
new-instance v2, Ljava/lang/StringBuilder;
invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
const-string v3, "SCO audio state CONNECTED na "
invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v3, " ms."
invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v2
invoke-static {v2}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
:log_connected
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->maybeReleaseMuteOnSco()V
goto/16 :done
:not_connected
const/4 v1, 0
if-ne v0, v1, :done
iput-boolean v1, p0, Lapp/liveclearmic/ProbeService;->scoAudioConnected:Z
const-string v2, "SCO audio state DISCONNECTED."
invoke-static {v2}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public maybeReleaseMuteOnSco()V
.locals 0
# v1.6 keeps SCO state for diagnostics only. Early unmute is driven by
# the actual recording-input callback or the independent route-stability watcher.
return-void
.end method

.method public releaseAdaptiveMute(Ljava/lang/String;)V
.locals 10
iget-boolean v0, p0, Lapp/liveclearmic/ProbeService;->mutePending:Z
if-nez v0, :release_pending
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->releaseSystemMuteForOverlap()V
return-void
:release_pending
const/4 v0, 0
iput-boolean v0, p0, Lapp/liveclearmic/ProbeService;->mutePending:Z
sput-object p1, Lapp/liveclearmic/ProbeService;->lastMuteReleaseReason:Ljava/lang/String;
:start
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->releaseSystemMuteForOverlap()V
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v2
iget-wide v4, p0, Lapp/liveclearmic/ProbeService;->muteStartedAt:J
sub-long v2, v2, v4
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastMuteDurationMs:J
iget v0, p0, Lapp/liveclearmic/ProbeService;->muteTargetMs:I
int-to-long v6, v0
sub-long v6, v2, v6
sput-wide v6, Lapp/liveclearmic/ProbeService;->lastMuteTargetDeltaMs:J
new-instance v1, Ljava/lang/StringBuilder;
invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
const-string v8, "MASK: SYSTEM Startmute afgerond na "
invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v8, " ms; verschil slider="
invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v1, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v8, " ms; reden="
invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v1
invoke-static {v1}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->saveLog()V
:end
goto/16 :done
:error
move-exception v0
iget-boolean v1, p0, Lapp/liveclearmic/ProbeService;->systemMuteApplied:Z
if-eqz v1, :after_failsafe
iget-boolean v1, p0, Lapp/liveclearmic/ProbeService;->mutePrevious:Z
if-nez v1, :after_failsafe
iget-object v1, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
if-eqz v1, :after_failsafe
const/4 v2, 0
invoke-virtual {v1, v2}, Landroid/media/AudioManager;->setMicrophoneMute(Z)V
iput-boolean v2, p0, Lapp/liveclearmic/ProbeService;->systemMuteApplied:Z
:after_failsafe
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

























.method public acquireWake()V
.locals 4
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->wake:Landroid/os/PowerManager$WakeLock;
if-nez v0, :done
:start
const-string v0, "power"
invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v0
check-cast v0, Landroid/os/PowerManager;
const/4 v1, 1
const-string v2, "LiveClearMic156:auto-hfp"
invoke-virtual {v0, v1, v2}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;
move-result-object v0
iput-object v0, p0, Lapp/liveclearmic/ProbeService;->wake:Landroid/os/PowerManager$WakeLock;
const/4 v1, 0
invoke-virtual {v0, v1}, Landroid/os/PowerManager$WakeLock;->setReferenceCounted(Z)V
invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->acquire()V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public engageFilter()Z
.locals 12
sget-boolean v0, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-eqz v0, :start
const/4 v0, 1
return v0
:start
# Timestamp the earliest point LiveClearMic is asked to react to the detected recording.
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v8
sput-wide v8, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
const-wide/16 v10, -1
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastSetDeviceMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastScoReturnMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastTrackBuiltMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastTrackPlayMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastHfpReadyMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastRouteConfirmMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastRouteActiveMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastCommDeviceCallbackMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastPolledCommRouteMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastTrackRoutedMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastAdaptiveRouteMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastScoConnectedMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastRecordingInputBluetoothMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastMuteDurationMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastSystemMuteOnMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastSystemMuteOffMs:J
const/4 v7, 0
iput-boolean v7, p0, Lapp/liveclearmic/ProbeService;->scoAudioConnected:Z
iput-boolean v7, p0, Lapp/liveclearmic/ProbeService;->systemMuteApplied:Z
sput-boolean v7, Lapp/liveclearmic/ProbeService;->lastSystemMuteSetOk:Z
sput-boolean v7, Lapp/liveclearmic/ProbeService;->lastSystemMuteRestoreOk:Z
sput-boolean v7, Lapp/liveclearmic/ProbeService;->lastRecordingInputMatched:Z
const-string v6, "nog niet waargenomen"
sput-object v6, Lapp/liveclearmic/ProbeService;->lastRecordingInputDevice:Ljava/lang/String;
const/4 v6, 0
iput-object v6, p0, Lapp/liveclearmic/ProbeService;->lastRecordingInput:Ljava/lang/String;
const-string v7, "nog niet uitgevoerd"
sput-object v7, Lapp/liveclearmic/ProbeService;->lastMuteReleaseReason:Ljava/lang/String;
const-string v7, "nog niet beschikbaar"
sput-object v7, Lapp/liveclearmic/ProbeService;->lastAdaptiveRouteSource:Ljava/lang/String;

iget-object v0, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
invoke-virtual {v0}, Landroid/media/AudioManager;->getMode()I
move-result v1
if-eqz v1, :mode_ok
const/4 v0, 0
return v0
:mode_ok
# Use the headset cached while idle; only perform the slower lookup as fallback.
iget-object v1, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
if-nez v1, :have_device
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->findBluetoothCommunicationDevice()Landroid/media/AudioDeviceInfo;
move-result-object v1
if-nez v1, :cache_device
const/4 v0, 0
return v0
:cache_device
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
:have_device
# No reconnect warm-up exists in 1.9.6; every real recording starts its own HFP path.
const/4 v7, 0
iput-boolean v7, p0, Lapp/liveclearmic/ProbeService;->selectedCommRouteActive:Z
const-wide/16 v5, -1
iput-wide v5, p0, Lapp/liveclearmic/ProbeService;->communicationRouteSelectedAt:J
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->startAdaptiveMute()V
# Non-audio 5 ms correlation watcher; safe for Startmute ON and OFF.
new-instance v3, Lapp/liveclearmic/RouteMeasureWatcher;
invoke-direct {v3, p0}, Lapp/liveclearmic/RouteMeasureWatcher;-><init>(Lapp/liveclearmic/ProbeService;)V
new-instance v4, Ljava/lang/Thread;
const-string v5, "LiveClearMic-route-measure"
invoke-direct {v4, v3, v5}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V
invoke-virtual {v4}, Ljava/lang/Thread;->start()V
invoke-virtual {v0, v1}, Landroid/media/AudioManager;->setCommunicationDevice(Landroid/media/AudioDeviceInfo;)Z
move-result v2
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v10
sub-long v10, v10, v8
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastSetDeviceMs:J

const/4 v3, 1
iput-boolean v3, p0, Lapp/liveclearmic/ProbeService;->legacySco:Z
invoke-virtual {v0}, Landroid/media/AudioManager;->startBluetoothSco()V
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v10
sub-long v10, v10, v8
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastScoReturnMs:J
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->startKeepAliveTrack()Z
move-result v3
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v10
sub-long v10, v10, v8
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastHfpReadyMs:J
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->maybeReleaseMuteOnSco()V
if-nez v3, :track_done
const-string v4, "AUTO: stille AudioTrack kon niet starten; SCO blijft als fallback actief."
invoke-static {v4}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
:track_done
# Query the selected communication route immediately instead of waiting for the periodic monitor.
invoke-virtual {v0}, Landroid/media/AudioManager;->getCommunicationDevice()Landroid/media/AudioDeviceInfo;
move-result-object v4
if-eqz v4, :route_timing_done
invoke-virtual {v4}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v5
invoke-virtual {v1}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v6
if-ne v5, v6, :route_timing_done
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v10
sub-long v10, v10, v8
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastRouteConfirmMs:J
sput-wide v10, Lapp/liveclearmic/ProbeService;->lastRouteActiveMs:J
:route_timing_done

# First/cold-start bookkeeping is diagnostic only and intentionally happens
# after the time-critical HFP routing path above.
iget v3, p0, Lapp/liveclearmic/ProbeService;->hfpStarts:I
if-nez v3, :not_first_hfp_start
const/4 v4, 1
goto/16 :first_hfp_start_done
:not_first_hfp_start
const/4 v4, 0
:first_hfp_start_done
sput-boolean v4, Lapp/liveclearmic/ProbeService;->lastWasFirstStart:Z
add-int/lit8 v3, v3, 1
iput v3, p0, Lapp/liveclearmic/ProbeService;->hfpStarts:I

# Build diagnostics only after the time-critical routing calls have completed.
new-instance v4, Ljava/lang/StringBuilder;
invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
const-string v5, "AUTO: microfoonopname gedetecteerd; setCommunicationDevice resultaat: "
invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
const-string v5, "; timing setDevice="
invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v5, Lapp/liveclearmic/ProbeService;->lastSetDeviceMs:J
invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v5, " ms, startSco="
invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v5, Lapp/liveclearmic/ProbeService;->lastScoReturnMs:J
invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v5, " ms, trackBuilt="
invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v5, Lapp/liveclearmic/ProbeService;->lastTrackBuiltMs:J
invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v5, " ms, trackPlay="
invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v5, Lapp/liveclearmic/ProbeService;->lastTrackPlayMs:J
invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v5, " ms, HFP-startpad="
invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v5, Lapp/liveclearmic/ProbeService;->lastHfpReadyMs:J
invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v5, " ms, route-bevestiging="
invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-wide v5, Lapp/liveclearmic/ProbeService;->lastRouteConfirmMs:J
invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v5, " ms, eersteStart="
invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
sget-boolean v5, Lapp/liveclearmic/ProbeService;->lastWasFirstStart:Z
invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v4
invoke-static {v4}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V

const/4 v3, 1
sput-boolean v3, Lapp/liveclearmic/ProbeService;->filterActive:Z
const/4 v3, 0
iput v3, p0, Lapp/liveclearmic/ProbeService;->lostTicks:I
iput v3, p0, Lapp/liveclearmic/ProbeService;->reasserts:I
iput v3, p0, Lapp/liveclearmic/ProbeService;->noRecordingTicks:I
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->acquireWake()V
const-string v3, "AUTO: headset HFP-filter actief voor deze microfoonopname."
invoke-static {v3}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->saveLog()V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->updateNotice()V
const/4 v0, 1
return v0
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
const-string v1, "HFP-startfout"
invoke-virtual {p0, v1}, Lapp/liveclearmic/ProbeService;->releaseAdaptiveMute(Ljava/lang/String;)V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->stopKeepAliveTrack()V
const/4 v0, 0
sput-boolean v0, Lapp/liveclearmic/ProbeService;->filterActive:Z
return v0
.catch Ljava/lang/Throwable; {:start .. :route_timing_done} :error
.end method

.method public disengageFilter(Ljava/lang/String;)V
.locals 4
sget-boolean v0, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-eqz v0, :done
const/4 v0, 0
sput-boolean v0, Lapp/liveclearmic/ProbeService;->filterActive:Z
const-string v0, "opname/route gestopt"
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->releaseAdaptiveMute(Ljava/lang/String;)V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->pollAdaptiveRoutes()V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->chooseAdaptiveRoute()J
move-result-wide v2
# v1.9.6: history is finalized by RouteMeasureWatcher after its full 1800 ms window.
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->stopKeepAliveTrack()V
:start
iget-object v1, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
if-eqz v1, :route_done
invoke-virtual {v1}, Landroid/media/AudioManager;->clearCommunicationDevice()V
iget-boolean v2, p0, Lapp/liveclearmic/ProbeService;->legacySco:Z
if-eqz v2, :route_done
invoke-virtual {v1}, Landroid/media/AudioManager;->stopBluetoothSco()V
const/4 v2, 0
iput-boolean v2, p0, Lapp/liveclearmic/ProbeService;->legacySco:Z
:route_done
:end
goto/16 :after
:error
move-exception v1
invoke-static {v1}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:after
const/4 v0, 0
iput-object v0, p0, Lapp/liveclearmic/ProbeService;->lastDevice:Ljava/lang/String;
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->findBluetoothCommunicationDevice()Landroid/media/AudioDeviceInfo;
move-result-object v1
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
const/4 v0, 0
iput v0, p0, Lapp/liveclearmic/ProbeService;->lostTicks:I
iput v0, p0, Lapp/liveclearmic/ProbeService;->reasserts:I
iput v0, p0, Lapp/liveclearmic/ProbeService;->noRecordingTicks:I
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->releaseWake()V
invoke-static {p1}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->saveLog()V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->updateNotice()V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method


.method public onRecordingConfigsChanged(Ljava/util/List;)V
.locals 12
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->onRecordingStateChanged()V
if-eqz p1, :done
:start
const/4 v0, 0
invoke-interface {p1}, Ljava/util/List;->size()I
move-result v1
:loop
if-ge v0, v1, :done
invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;
move-result-object v2
check-cast v2, Landroid/media/AudioRecordingConfiguration;
invoke-virtual {v2}, Landroid/media/AudioRecordingConfiguration;->getClientAudioSource()I
move-result v3
const/4 v4, 1
if-eq v3, v4, :target
const/4 v4, 5
if-eq v3, v4, :target
const/4 v4, 6
if-eq v3, v4, :target
const/16 v4, 9
if-eq v3, v4, :target
const/16 v4, 10
if-eq v3, v4, :target
goto/16 :next
:target
invoke-virtual {v2}, Landroid/media/AudioRecordingConfiguration;->getAudioDevice()Landroid/media/AudioDeviceInfo;
move-result-object v4
if-eqz v4, :next
invoke-static {v4}, Lapp/liveclearmic/ProbeService;->deviceText(Landroid/media/AudioDeviceInfo;)Ljava/lang/String;
move-result-object v5
sput-object v5, Lapp/liveclearmic/ProbeService;->lastRecordingInputDevice:Ljava/lang/String;
iget-object v6, p0, Lapp/liveclearmic/ProbeService;->lastRecordingInput:Ljava/lang/String;
if-eqz v6, :input_changed
invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v7
if-nez v7, :check_selected
:input_changed
iput-object v5, p0, Lapp/liveclearmic/ProbeService;->lastRecordingInput:Ljava/lang/String;
new-instance v6, Ljava/lang/StringBuilder;
invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V
const-string v7, "AUTO actieve opname-input: "
invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v6
invoke-static {v6}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
:check_selected
iget-object v6, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
if-eqz v6, :next
invoke-virtual {v4}, Landroid/media/AudioDeviceInfo;->getType()I
move-result v7
const/16 v8, 7
if-eq v7, v8, :bt_type
const/16 v8, 26
if-ne v7, v8, :next
:bt_type
sget-wide v6, Lapp/liveclearmic/ProbeService;->lastRecordingInputBluetoothMs:J
const-wide/16 v8, -1
cmp-long v8, v6, v8
if-gez v8, :done
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v9
sget-wide v6, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
sub-long v9, v9, v6
sput-wide v9, Lapp/liveclearmic/ProbeService;->lastRecordingInputBluetoothMs:J
const/4 v6, 1
sput-boolean v6, Lapp/liveclearmic/ProbeService;->lastRecordingInputMatched:Z
new-instance v6, Ljava/lang/StringBuilder;
invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V
const-string v7, "AUTO: actieve opname gebruikt geselecteerde Bluetooth-input na "
invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v6, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v7, " ms: "
invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v6
invoke-static {v6}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
goto/16 :done
:next
add-int/lit8 v0, v0, 1
goto/16 :loop
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public onRecordingStateChanged()V
.locals 4
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v0, :done
:start
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->hasBudsConnected(Landroid/content/Context;)Z
move-result v0
if-eqz v0, :done
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
invoke-virtual {v0}, Landroid/media/AudioManager;->getMode()I
move-result v1
if-eqz v1, :normal
sget-boolean v2, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-eqz v2, :done
const-string v2, "AUTO: gewone telefoon/VoIP-communicatiemodus gedetecteerd; eigen HFP-filter losgelaten."
invoke-virtual {p0, v2}, Lapp/liveclearmic/ProbeService;->disengageFilter(Ljava/lang/String;)V
goto/16 :done
:normal
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->isTargetRecordingActive()Z
move-result v2
if-eqz v2, :done
const/4 v3, 0
iput v3, p0, Lapp/liveclearmic/ProbeService;->noRecordingTicks:I
sget-boolean v3, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
if-nez v3, :done
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->engageFilter()Z
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
.locals 8
const/4 v6, 0
if-eqz p1, :start
invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;
move-result-object v0
const-string v1, "DISCONNECT"
invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v2
if-nez v2, :disconnect_stop
const-string v1, "FILTER_OFF"
invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v2
if-nez v2, :filter_off_action
const-string v1, "FILTER_ON"
invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v2
if-nez v2, :filter_on_action
const-string v1, "STOP"
invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v2
if-nez v2, :manual_stop
const-string v1, "EXIT"
invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v2
if-nez v2, :exit_stop
const-string v1, "REFRESH"
invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v2
if-nez v2, :refresh_notice
const-string v1, "AUTO_CONNECT"
invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v6
goto/16 :start
:refresh_notice
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->updateNotice()V
goto/16 :done
:filter_off_action
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v0, :done
sget-boolean v0, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-eqz v0, :refresh_notice
const/4 v0, 1
sput-boolean v0, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
const-string v0, "Filtering door gebruiker tijdelijk uitgezet voor huidige opname."
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->disengageFilter(Ljava/lang/String;)V
goto/16 :done
:filter_on_action
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v0, :done
const/4 v0, 0
sput-boolean v0, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->isTargetRecordingActive()Z
move-result v0
if-eqz v0, :refresh_notice
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->engageFilter()Z
goto/16 :done
:start
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-nez v0, :done
:try_start
const-string v0, ""
sput-object v0, Lapp/liveclearmic/ProbeService;->logText:Ljava/lang/String;
const/4 v0, 0
iput-boolean v0, p0, Lapp/liveclearmic/ProbeService;->stopped:Z
iput-boolean v0, p0, Lapp/liveclearmic/ProbeService;->legacySco:Z
iput v0, p0, Lapp/liveclearmic/ProbeService;->reasserts:I
iput v0, p0, Lapp/liveclearmic/ProbeService;->lostTicks:I
iput v0, p0, Lapp/liveclearmic/ProbeService;->disconnectTicks:I
iput v0, p0, Lapp/liveclearmic/ProbeService;->noRecordingTicks:I
sput-boolean v0, Lapp/liveclearmic/ProbeService;->filterActive:Z
sput-boolean v0, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
iput-boolean v0, p0, Lapp/liveclearmic/ProbeService;->mutePending:Z
iput-boolean v0, p0, Lapp/liveclearmic/ProbeService;->systemMuteApplied:Z
iput-boolean v0, p0, Lapp/liveclearmic/ProbeService;->scoAudioConnected:Z
sput-boolean v0, Lapp/liveclearmic/ProbeService;->lastRecordingInputMatched:Z
sput-boolean v0, Lapp/liveclearmic/ProbeService;->lastSystemMuteSetOk:Z
sput-boolean v0, Lapp/liveclearmic/ProbeService;->lastSystemMuteRestoreOk:Z
sput-boolean v0, Lapp/liveclearmic/ProbeService;->lastStartMuteEnabled:Z
const-wide/16 v2, -1
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastSetDeviceMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastScoReturnMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastTrackBuiltMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastTrackPlayMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastHfpReadyMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastRouteConfirmMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastRouteActiveMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastCommDeviceCallbackMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastPolledCommRouteMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastTrackRoutedMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastAdaptiveRouteMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastScoConnectedMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastRecordingInputBluetoothMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastMuteDurationMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastSystemMuteOnMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastSystemMuteOffMs:J
sput-wide v2, Lapp/liveclearmic/ProbeService;->lastMuteTargetDeltaMs:J
const-string v3, "nog niet waargenomen"
sput-object v3, Lapp/liveclearmic/ProbeService;->lastRecordingInputDevice:Ljava/lang/String;
const-string v3, "nog niet uitgevoerd"
sput-object v3, Lapp/liveclearmic/ProbeService;->lastMuteReleaseReason:Ljava/lang/String;
const-string v3, "nog niet beschikbaar"
sput-object v3, Lapp/liveclearmic/ProbeService;->lastAdaptiveRouteSource:Ljava/lang/String;
const/4 v1, 0
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->lastRecordingInput:Ljava/lang/String;
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->lastDevice:Ljava/lang/String;
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->track:Landroid/media/AudioTrack;
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->silent:[B
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->hasBudsConnected(Landroid/content/Context;)Z
move-result v2
if-nez v2, :buds_ok
if-eqz v6, :no_buds
const/4 v2, -6
iput v2, p0, Lapp/liveclearmic/ProbeService;->disconnectTicks:I
goto/16 :buds_ok
:no_buds
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->notice()Landroid/app/Notification;
move-result-object v2
const/4 v0, 1
const/16 v3, 16
invoke-virtual {p0, v0, v2, v3}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;I)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->noSelectedLong(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
invoke-static {p0, v2}, Lapp/liveclearmic/ProbeService;->showToast(Landroid/content/Context;Ljava/lang/String;)V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
invoke-virtual {p0, v0}, Landroid/app/Service;->stopForeground(I)V
invoke-virtual {p0}, Landroid/app/Service;->stopSelf()V
goto/16 :done
:buds_ok
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->findBluetoothCommunicationDevice()Landroid/media/AudioDeviceInfo;
move-result-object v1
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
const/4 v0, 1
sput-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->requestTileUpdate(Landroid/content/Context;)V
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v1
iput-wide v1, p0, Lapp/liveclearmic/ProbeService;->started:J
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->notice()Landroid/app/Notification;
move-result-object v2
const/16 v3, 16
invoke-virtual {p0, v0, v2, v3}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;I)V
if-eqz v6, :normal_start_log
const-string v0, "LiveClearMic 2.0 AUTO AAN na Bluetooth reconnect. Startmute wordt uitsluitend per echte opname toegepast."
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
goto/16 :log_done
:normal_start_log
const-string v0, "LiveClearMic 2.0 AUTO AAN. Wacht op microfoongebruik; HFP/SCO staat in rust uit."
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
:log_done
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
invoke-virtual {v0}, Landroid/media/AudioManager;->getMode()I
move-result v1
iput v1, p0, Lapp/liveclearmic/ProbeService;->previousMode:I
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->listCommunicationDevices()Ljava/lang/String;
move-result-object v1
invoke-static {v1}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->saveLog()V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->onRecordingStateChanged()V
iget-object v1, p0, Lapp/liveclearmic/ProbeService;->handler:Landroid/os/Handler;
const-wide/16 v2, 500
invoke-virtual {v1, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
:end_start
goto/16 :done
:start_error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
const-string v0, "Start mislukt; automatische modus wordt opgeruimd."
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->finish(Ljava/lang/String;)V
goto/16 :done
:disconnect_stop
const/4 v1, 1
sput-boolean v1, Lapp/liveclearmic/ProbeService;->suppressControlOff:Z
const/4 v1, 0
sput-boolean v1, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->disconnectedToast(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->finish(Ljava/lang/String;)V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
goto/16 :done
:exit_stop
const/4 v0, 1
sput-boolean v0, Lapp/liveclearmic/ProbeService;->suppressControlOff:Z
invoke-static {p0, v0}, Lapp/liveclearmic/ProbeService;->setUserClosed(Landroid/content/Context;Z)V
const-string v0, "LiveClearMic afgesloten via menu; automatische herstart gepauzeerd."
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->finish(Ljava/lang/String;)V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->finishAllTasksAndKill(Landroid/content/Context;)V
goto/16 :done
:manual_stop
const-string v0, "LiveClearMic automatische modus handmatig UIT gezet."
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->finish(Ljava/lang/String;)V
:done
const/4 v0, 1
return v0
.catch Ljava/lang/Throwable; {:try_start .. :end_start} :start_error
.end method

.method public run()V
.locals 13
iget-boolean v0, p0, Lapp/liveclearmic/ProbeService;->stopped:Z
if-nez v0, :done
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v0, :done
:start
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->hasBudsConnected(Landroid/content/Context;)Z
move-result v0
if-nez v0, :buds_ok
:no_buds_normal
iget v0, p0, Lapp/liveclearmic/ProbeService;->disconnectTicks:I
add-int/lit8 v0, v0, 1
iput v0, p0, Lapp/liveclearmic/ProbeService;->disconnectTicks:I
const/4 v1, 3
if-lt v0, v1, :schedule
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->disconnectedToast(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-static {p0, v0}, Lapp/liveclearmic/ProbeService;->showToast(Landroid/content/Context;Ljava/lang/String;)V
const/4 v1, 1
sput-boolean v1, Lapp/liveclearmic/ProbeService;->suppressControlOff:Z
const/4 v1, 0
sput-boolean v1, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->finish(Ljava/lang/String;)V
goto/16 :done
:buds_ok
const/4 v0, 0
iput v0, p0, Lapp/liveclearmic/ProbeService;->disconnectTicks:I
iget-object v4, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
invoke-virtual {v4}, Landroid/media/AudioManager;->getMode()I
move-result v5
# 1.8.3: reuse the same foreground notification and refresh its text when
# a phone/VoIP call starts or ends. No call-route manipulation is performed.
iget v6, p0, Lapp/liveclearmic/ProbeService;->previousMode:I
if-eq v5, v6, :mode_notice_current
iput v5, p0, Lapp/liveclearmic/ProbeService;->previousMode:I
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->updateNotice()V
:mode_notice_current
if-eqz v5, :normal_mode
sget-boolean v6, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-eqz v6, :schedule
const-string v6, "AUTO: telefoon/VoIP-communicatiemodus nam audio over; eigen HFP-filter tijdelijk uit."
invoke-virtual {p0, v6}, Lapp/liveclearmic/ProbeService;->disengageFilter(Ljava/lang/String;)V
goto/16 :schedule
:normal_mode
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->isTargetRecordingActive()Z
move-result v6
if-eqz v6, :no_recording
const/4 v7, 0
iput v7, p0, Lapp/liveclearmic/ProbeService;->noRecordingTicks:I
sget-boolean v7, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
if-nez v7, :schedule
sget-boolean v7, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-nez v7, :route_check
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->engageFilter()Z
goto/16 :route_check
:no_recording
sget-boolean v7, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-eqz v7, :reset_no_recording
iget v7, p0, Lapp/liveclearmic/ProbeService;->noRecordingTicks:I
add-int/lit8 v7, v7, 1
iput v7, p0, Lapp/liveclearmic/ProbeService;->noRecordingTicks:I
const/4 v8, 2
if-lt v7, v8, :route_check
const-string v7, "AUTO: microfoonopname gestopt; headset HFP-filter terug naar stand-by."
invoke-virtual {p0, v7}, Lapp/liveclearmic/ProbeService;->disengageFilter(Ljava/lang/String;)V
goto/16 :schedule
:reset_no_recording
const/4 v7, 0
iput v7, p0, Lapp/liveclearmic/ProbeService;->noRecordingTicks:I
sget-boolean v8, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
if-eqz v8, :schedule
sput-boolean v7, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->updateNotice()V
goto/16 :schedule

:route_check
sget-boolean v7, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-eqz v7, :schedule
invoke-virtual {v4}, Landroid/media/AudioManager;->getCommunicationDevice()Landroid/media/AudioDeviceInfo;
move-result-object v5
invoke-static {v5}, Lapp/liveclearmic/ProbeService;->deviceText(Landroid/media/AudioDeviceInfo;)Ljava/lang/String;
move-result-object v6
iget-object v7, p0, Lapp/liveclearmic/ProbeService;->lastDevice:Ljava/lang/String;
if-eqz v7, :changed
invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v8
if-nez v8, :state
:changed
iput-object v6, p0, Lapp/liveclearmic/ProbeService;->lastDevice:Ljava/lang/String;
new-instance v7, Ljava/lang/StringBuilder;
invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V
const-string v8, "AUTO actief communicatie-apparaat: "
invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v7
invoke-static {v7}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
:state
const/4 v8, 0
if-eqz v5, :lost
iget-object v7, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
if-eqz v7, :lost
invoke-virtual {v5}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v9
invoke-virtual {v7}, Landroid/media/AudioDeviceInfo;->getId()I
move-result v10
if-ne v9, v10, :lost
sget-wide v9, Lapp/liveclearmic/ProbeService;->lastRouteActiveMs:J
const-wide/16 v11, -1
cmp-long v7, v9, v11
if-nez v7, :actual_route_already_known
invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
move-result-wide v9
sget-wide v11, Lapp/liveclearmic/ProbeService;->lastDetectionAt:J
sub-long v9, v9, v11
sput-wide v9, Lapp/liveclearmic/ProbeService;->lastRouteActiveMs:J
new-instance v7, Ljava/lang/StringBuilder;
invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V
const-string v11, "AUTO: geselecteerde HFP-route voor het eerst waargenomen na "
invoke-virtual {v7, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v7, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
const-string v11, " ms."
invoke-virtual {v7, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v7
invoke-static {v7}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
:actual_route_already_known
const/4 v8, 1
:lost
if-eqz v8, :route_lost
const/4 v7, 0
iput v7, p0, Lapp/liveclearmic/ProbeService;->lostTicks:I
goto/16 :schedule
:route_lost
iget v7, p0, Lapp/liveclearmic/ProbeService;->lostTicks:I
add-int/lit8 v7, v7, 1
iput v7, p0, Lapp/liveclearmic/ProbeService;->lostTicks:I
const/4 v8, 3
if-lt v7, v8, :schedule
iget v7, p0, Lapp/liveclearmic/ProbeService;->reasserts:I
const/4 v8, 2
if-lt v7, v8, :schedule
add-int/lit8 v7, v7, 1
iput v7, p0, Lapp/liveclearmic/ProbeService;->reasserts:I
const/4 v8, 0
iput v8, p0, Lapp/liveclearmic/ProbeService;->lostTicks:I
iget-object v8, p0, Lapp/liveclearmic/ProbeService;->selected:Landroid/media/AudioDeviceInfo;
if-eqz v8, :restart_sco
invoke-virtual {v4, v8}, Landroid/media/AudioManager;->setCommunicationDevice(Landroid/media/AudioDeviceInfo;)Z
move-result v9
new-instance v10, Ljava/lang/StringBuilder;
invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V
const-string v11, "AUTO herstel setCommunicationDevice resultaat: "
invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v10
invoke-static {v10}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
:restart_sco
invoke-virtual {v4}, Landroid/media/AudioManager;->startBluetoothSco()V

:schedule
iget-object v2, p0, Lapp/liveclearmic/ProbeService;->handler:Landroid/os/Handler;
sget-boolean v3, Lapp/liveclearmic/ProbeService;->filterActive:Z
if-eqz v3, :idle_delay
const-wide/16 v3, 500
goto/16 :post
:idle_delay
const-wide/16 v3, 1000
:post
invoke-virtual {v2, p0, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
const-string v0, "Automatische modus uitgezet door Android-fout; zie diagnose."
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->finish(Ljava/lang/String;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public releaseWake()V
.locals 2
:start
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->wake:Landroid/os/PowerManager$WakeLock;
if-eqz v0, :done
const/4 v1, 0
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->wake:Landroid/os/PowerManager$WakeLock;
invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->isHeld()Z
move-result v1
if-eqz v1, :done
invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public finish(Ljava/lang/String;)V
.locals 5
iget-boolean v0, p0, Lapp/liveclearmic/ProbeService;->stopped:Z
if-nez v0, :done
const/4 v0, 1
iput-boolean v0, p0, Lapp/liveclearmic/ProbeService;->stopped:Z
const/4 v0, 0
sput-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
sput-boolean v0, Lapp/liveclearmic/ProbeService;->filterBypassed:Z
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->requestTileUpdate(Landroid/content/Context;)V
iget-object v1, p0, Lapp/liveclearmic/ProbeService;->handler:Landroid/os/Handler;
if-eqz v1, :filter
invoke-virtual {v1, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
:filter
# Always attempt SYSTEM restore before releasing HFP or stopping the service.
const-string v1, "service gestopt"
invoke-virtual {p0, v1}, Lapp/liveclearmic/ProbeService;->releaseAdaptiveMute(Ljava/lang/String;)V
const-string v1, "Automatische HFP-route vrijgegeven."
invoke-virtual {p0, v1}, Lapp/liveclearmic/ProbeService;->disengageFilter(Ljava/lang/String;)V
# A second idempotent restore covers errors during disengageFilter.
const-string v1, "service eindcontrole"
invoke-virtual {p0, v1}, Lapp/liveclearmic/ProbeService;->releaseAdaptiveMute(Ljava/lang/String;)V
invoke-static {p1}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
invoke-virtual {p0}, Lapp/liveclearmic/ProbeService;->saveLog()V
const/4 v0, 1
invoke-virtual {p0, v0}, Landroid/app/Service;->stopForeground(I)V
sget-boolean v0, Lapp/liveclearmic/ProbeService;->suppressControlOff:Z
if-eqz v0, :normal_control
const/4 v0, 0
sput-boolean v0, Lapp/liveclearmic/ProbeService;->suppressControlOff:Z
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
goto/16 :after_control
:normal_control
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->hasBudsConnected(Landroid/content/Context;)Z
move-result v0
if-eqz v0, :remove_control
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->postControlOff(Landroid/content/Context;)V
goto/16 :after_control
:remove_control
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
:after_control
invoke-virtual {p0}, Landroid/app/Service;->stopSelf()V
:done
return-void
.end method

.method public onDestroy()V
.locals 3
:start
iget-object v0, p0, Lapp/liveclearmic/ProbeService;->audio:Landroid/media/AudioManager;
iget-object v1, p0, Lapp/liveclearmic/ProbeService;->recordingWatcher:Lapp/liveclearmic/RecordingWatcher;
if-eqz v0, :after_unregister
if-eqz v1, :after_unregister
invoke-virtual {v0, v1}, Landroid/media/AudioManager;->unregisterAudioRecordingCallback(Landroid/media/AudioManager$AudioRecordingCallback;)V
:after_unregister
iget-object v1, p0, Lapp/liveclearmic/ProbeService;->communicationWatcher:Lapp/liveclearmic/CommunicationDeviceWatcher;
if-eqz v0, :after_comm_unregister
if-eqz v1, :after_comm_unregister
invoke-virtual {v0, v1}, Landroid/media/AudioManager;->removeOnCommunicationDeviceChangedListener(Landroid/media/AudioManager$OnCommunicationDeviceChangedListener;)V
const/4 v1, 0
iput-object v1, p0, Lapp/liveclearmic/ProbeService;->communicationWatcher:Lapp/liveclearmic/CommunicationDeviceWatcher;
:after_comm_unregister
iget-object v2, p0, Lapp/liveclearmic/ProbeService;->scoReceiver:Lapp/liveclearmic/ScoStateReceiver;
if-eqz v2, :after_sco_unregister
invoke-virtual {p0, v2}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
const/4 v2, 0
iput-object v2, p0, Lapp/liveclearmic/ProbeService;->scoReceiver:Lapp/liveclearmic/ScoStateReceiver;
:after_sco_unregister
:end
goto/16 :finish
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
:finish
const-string v0, "Service gestopt; LiveClearMic automatische modus vrijgegeven."
invoke-virtual {p0, v0}, Lapp/liveclearmic/ProbeService;->finish(Ljava/lang/String;)V
invoke-super {p0}, Landroid/app/Service;->onDestroy()V
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public onTaskRemoved(Landroid/content/Intent;)V
.locals 1
const-string v0, "Appvenster gesloten; LiveClearMic blijft actief."
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
return-void
.end method

.method public onTimeout(I)V
.locals 1
const-string v0, "Onverwachte service-timeout gemeld; connectedDevice-service blijft voor zover Android toestaat actief."
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
return-void
.end method

.method public onTimeout(II)V
.locals 1
const-string v0, "Onverwachte service-timeout gemeld; connectedDevice-service blijft voor zover Android toestaat actief."
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->note(Ljava/lang/String;)V
return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
.locals 1
const/4 v0, 0
return-object v0
.end method
