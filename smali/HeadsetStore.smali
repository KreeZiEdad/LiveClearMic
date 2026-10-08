.class public Lapp/liveclearmic/HeadsetStore;
.super Ljava/lang/Object;

.method public constructor <init>()V
.locals 0
invoke-direct {p0}, Ljava/lang/Object;-><init>()V
return-void
.end method

.method public static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
.locals 2
const-string v0, "liveclearmic_148"
const/4 v1, 0
invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
return-object v0
.end method

.method public static clear(Landroid/content/Context;)V
.locals 2
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
move-result-object v0
invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
move-result-object v1
invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;
invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V
return-void
.end method

.method public static names(Landroid/content/Context;)Ljava/lang/String;
.locals 3
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
move-result-object v0
const-string v1, "names"
const-string v2, "\n"
invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public static addresses(Landroid/content/Context;)Ljava/lang/String;
.locals 3
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
move-result-object v0
const-string v1, "addresses"
const-string v2, "\n"
invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public static ids(Landroid/content/Context;)Ljava/lang/String;
.locals 3
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
move-result-object v0
const-string v1, "ids"
const-string v2, "\n"
invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public static hasSaved(Landroid/content/Context;)Z
.locals 2
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->names(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;
move-result-object v0
invoke-virtual {v0}, Ljava/lang/String;->length()I
move-result v1
if-lez v1, :no
const/4 v0, 1
return v0
:no
const/4 v0, 0
return v0
.end method

.method public static token(Ljava/lang/String;)Ljava/lang/String;
.locals 2
new-instance v0, Ljava/lang/StringBuilder;
invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
const-string v1, "\n"
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public static containsToken(Ljava/lang/String;Ljava/lang/String;)Z
.locals 2
if-eqz p1, :no
invoke-virtual {p1}, Ljava/lang/String;->length()I
move-result v0
if-lez v0, :no
invoke-static {p1}, Lapp/liveclearmic/HeadsetStore;->token(Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
move-result v1
return v1
:no
const/4 v0, 0
return v0
.end method

.method public static appendUnique(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
.locals 3
if-eqz p1, :same
invoke-virtual {p1}, Ljava/lang/String;->length()I
move-result v0
if-lez v0, :same
invoke-static {p0, p1}, Lapp/liveclearmic/HeadsetStore;->containsToken(Ljava/lang/String;Ljava/lang/String;)Z
move-result v0
if-nez v0, :same
new-instance v0, Ljava/lang/StringBuilder;
invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
const-string v1, "\n"
invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v0
return-object v0
:same
return-object p0
.end method

.method public static save(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)V
.locals 7
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
move-result-object v0
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->names(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
invoke-static {v1, p1}, Lapp/liveclearmic/HeadsetStore;->appendUnique(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v1
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->addresses(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
invoke-static {v2, p2}, Lapp/liveclearmic/HeadsetStore;->appendUnique(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v2
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->ids(Landroid/content/Context;)Ljava/lang/String;
move-result-object v3
invoke-static {p3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
move-result-object v4
invoke-static {v3, v4}, Lapp/liveclearmic/HeadsetStore;->appendUnique(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v3
invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
move-result-object v5
const-string v6, "names"
invoke-interface {v5, v6, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
const-string v6, "addresses"
invoke-interface {v5, v6, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
const-string v6, "ids"
invoke-interface {v5, v6, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
invoke-interface {v5}, Landroid/content/SharedPreferences$Editor;->apply()V
return-void
.end method

.method public static displayNames(Landroid/content/Context;)Ljava/lang/String;
.locals 3
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->names(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;
move-result-object v0
invoke-virtual {v0}, Ljava/lang/String;->length()I
move-result v1
if-lez v1, :none
const-string v1, "\n"
const-string v2, ", "
invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
move-result-object v0
return-object v0
:none
const-string v0, "geen"
return-object v0
.end method

.method public static isSavedDevice(Landroid/content/Context;Landroid/media/AudioDeviceInfo;)Z
.locals 6
if-eqz p1, :no
invoke-virtual {p1}, Landroid/media/AudioDeviceInfo;->getAddress()Ljava/lang/String;
move-result-object v0
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->addresses(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
invoke-static {v1, v0}, Lapp/liveclearmic/HeadsetStore;->containsToken(Ljava/lang/String;Ljava/lang/String;)Z
move-result v2
if-nez v2, :yes
invoke-virtual {p1}, Landroid/media/AudioDeviceInfo;->getProductName()Ljava/lang/CharSequence;
move-result-object v3
invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
move-result-object v3
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->names(Landroid/content/Context;)Ljava/lang/String;
move-result-object v4
invoke-static {v4, v3}, Lapp/liveclearmic/HeadsetStore;->containsToken(Ljava/lang/String;Ljava/lang/String;)Z
move-result v5
if-nez v5, :yes
:no
const/4 v0, 0
return v0
:yes
const/4 v0, 1
return v0
.end method

.method public static isSavedBluetoothDevice(Landroid/content/Context;Landroid/bluetooth/BluetoothDevice;)Z
.locals 6
if-eqz p1, :no
:start
invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;
move-result-object v0
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->addresses(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
invoke-static {v1, v0}, Lapp/liveclearmic/HeadsetStore;->containsToken(Ljava/lang/String;Ljava/lang/String;)Z
move-result v2
if-nez v2, :yes
invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;
move-result-object v3
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->names(Landroid/content/Context;)Ljava/lang/String;
move-result-object v4
invoke-static {v4, v3}, Lapp/liveclearmic/HeadsetStore;->containsToken(Ljava/lang/String;Ljava/lang/String;)Z
move-result v5
if-nez v5, :yes
:no
const/4 v0, 0
return v0
:yes
const/4 v0, 1
return v0
:error
move-exception v0
const/4 v0, 0
return v0
.catch Ljava/lang/Throwable; {:start .. :yes} :error
.end method

.method public static findAnyConnected(Landroid/content/Context;)Landroid/media/AudioDeviceInfo;
.locals 7
:start
const-string v0, "audio"
invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v0
check-cast v0, Landroid/media/AudioManager;
invoke-virtual {v0}, Landroid/media/AudioManager;->getAvailableCommunicationDevices()Ljava/util/List;
move-result-object v1
const/4 v2, 0
invoke-interface {v1}, Ljava/util/List;->size()I
move-result v3
:loop
if-ge v2, v3, :none
invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;
move-result-object v4
check-cast v4, Landroid/media/AudioDeviceInfo;
invoke-virtual {v4}, Landroid/media/AudioDeviceInfo;->getType()I
move-result v5
const/4 v6, 7
if-eq v5, v6, :found
const/16 v6, 26
if-eq v5, v6, :found
add-int/lit8 v2, v2, 1
goto/16 :loop
:found
return-object v4
:none
const/4 v0, 0
return-object v0
:error
move-exception v0
const/4 v0, 0
return-object v0
.catch Ljava/lang/Throwable; {:start .. :none} :error
.end method

.method public static findSavedConnected(Landroid/content/Context;)Landroid/media/AudioDeviceInfo;
.locals 7
:start
const-string v0, "audio"
invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v0
check-cast v0, Landroid/media/AudioManager;
invoke-virtual {v0}, Landroid/media/AudioManager;->getAvailableCommunicationDevices()Ljava/util/List;
move-result-object v1
const/4 v2, 0
invoke-interface {v1}, Ljava/util/List;->size()I
move-result v3
:loop
if-ge v2, v3, :none
invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;
move-result-object v4
check-cast v4, Landroid/media/AudioDeviceInfo;
invoke-virtual {v4}, Landroid/media/AudioDeviceInfo;->getType()I
move-result v5
const/4 v6, 7
if-eq v5, v6, :check
const/16 v6, 26
if-ne v5, v6, :next
:check
invoke-static {p0, v4}, Lapp/liveclearmic/HeadsetStore;->isSavedDevice(Landroid/content/Context;Landroid/media/AudioDeviceInfo;)Z
move-result v5
if-nez v5, :found
:next
add-int/lit8 v2, v2, 1
goto/16 :loop
:found
return-object v4
:none
const/4 v0, 0
return-object v0
:error
move-exception v0
const/4 v0, 0
return-object v0
.catch Ljava/lang/Throwable; {:start .. :none} :error
.end method

.method public static currentTargetName(Landroid/content/Context;)Ljava/lang/String;
.locals 3
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->findSavedConnected(Landroid/content/Context;)Landroid/media/AudioDeviceInfo;
move-result-object v0
if-eqz v0, :saved_name
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->displayNames(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
return-object v2
:saved_name
invoke-virtual {v0}, Landroid/media/AudioDeviceInfo;->getProductName()Ljava/lang/CharSequence;
move-result-object v1
invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
move-result-object v2
return-object v2
.end method
