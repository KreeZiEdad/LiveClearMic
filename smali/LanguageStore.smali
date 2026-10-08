.class public Lapp/liveclearmic/LanguageStore;
.super Ljava/lang/Object;

.method public constructor <init>()V
.locals 0
invoke-direct {p0}, Ljava/lang/Object;-><init>()V
return-void
.end method

.method public static isEnglish(Landroid/content/Context;)Z
.locals 4
const-string v0, "liveclearmic_state"
const/4 v1, 0
invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
const-string v2, "language_en"
# Respect an explicit NL/EN choice from existing or current users.
invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->contains(Ljava/lang/String;)Z
move-result v3
if-eqz v3, :system_language
invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
move-result v0
return v0
:system_language
# First run / no stored choice: Dutch Android locale -> NL, everything else -> EN.
invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;
move-result-object v0
invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;
move-result-object v0
const-string v2, "nl"
invoke-virtual {v2, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z
move-result v0
if-eqz v0, :system_not_dutch
const/4 v0, 0
return v0
:system_not_dutch
const/4 v0, 1
return v0
.end method

.method public static setEnglish(Landroid/content/Context;Z)V
.locals 3
const-string v0, "liveclearmic_state"
const/4 v1, 0
invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
move-result-object v0
const-string v1, "language_en"
invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
return-void
.end method

.method public static text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
.locals 1
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->isEnglish(Landroid/content/Context;)Z
move-result v0
if-eqz v0, :nl
return-object p2
:nl
return-object p1
.end method
# GENERATED_TEXT_METHODS

.method public static languageDescription(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Taal"
const-string v1, "Language"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static moreOptions(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Meer opties"
const-string v1, "More options"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static bluetoothHeadset(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Bluetooth-headset"
const-string v1, "Bluetooth headset"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static stateOff(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "UIT"
const-string v1, "OFF"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static stateOn(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "AAN"
const-string v1, "ON"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static statePaused(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "PAUZE"
const-string v1, "PAUSED"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static turnOn(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "INSCHAKELEN"
const-string v1, "ENABLE"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static turnOff(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "UITSCHAKELEN"
const-string v1, "DISABLE"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static closeAction(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "SLUITEN"
const-string v1, "CLOSE"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static selectedNone(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Geselecteerde headset: nog geen"
const-string v1, "Selected headset: none"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static selectedPrefix(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Geselecteerde headset: "
const-string v1, "Selected headset: "
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static chooseHeadset(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Headset kiezen"
const-string v1, "Choose headset"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static chooseFirst(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Kies eerst een headset."
const-string v1, "Choose a headset first."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static notConnectedSuffix(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, " is niet verbonden."
const-string v1, " is not connected."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static couldNotStart(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Kon LiveClearMic niet starten."
const-string v1, "Could not start LiveClearMic."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static notificationPermission(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Geef meldingen toestemming om LiveClearMic te bedienen via de meldingsbalk."
const-string v1, "Allow notifications to control LiveClearMic from the notification bar."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static nearbyPermission(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Geef toegang tot Apparaten in de buurt om verbonden Bluetooth-headsets te kunnen kiezen."
const-string v1, "Allow Nearby devices access to choose connected Bluetooth headsets."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static genericError(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Er ging iets mis."
const-string v1, "Something went wrong."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method



.method public static startMuteLabel(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Startmute"
const-string v1, "Start mute"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public static startMuteDurationLabel(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Startmute-duur"
const-string v1, "Start mute duration"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public static customDurationLabel(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Aangepast..."
const-string v1, "Custom..."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public static forgetDevices(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Apparaten wissen"
const-string v1, "Clear devices"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method





.method public static closeAppMenu(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "LiveClearMic afsluiten"
const-string v1, "Close LiveClearMic"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static diagnosticsCopied(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Diagnose gekopieerd"
const-string v1, "Diagnosis copied"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static headsetForgotten(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Apparaten verwijderd"
const-string v1, "Devices removed"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static clearSavedFailed(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Kon opgeslagen headset niet wissen."
const-string v1, "Could not clear the saved headset."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static noBtHeadset(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Geen Bluetooth-headset verbonden."
const-string v1, "No Bluetooth headset connected."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static connectedSuffix(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, " — verbonden"
const-string v1, " — connected"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static chooseBtHeadset(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Kies Bluetooth-headset"
const-string v1, "Choose Bluetooth headset"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static cancelText(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Annuleren"
const-string v1, "Cancel"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static readConnectedFailed(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Verbonden Bluetooth-headsets konden niet worden gelezen."
const-string v1, "Connected Bluetooth headsets could not be read."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static selectedSuffix(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, " geselecteerd."
const-string v1, " selected."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static saveSelectedFailed(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Kon de gekozen headset niet opslaan."
const-string v1, "Could not save the selected headset."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static notifTitleOff(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "LiveClearMic — UIT"
const-string v1, "LiveClearMic — OFF"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static notifOffText(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Geselecteerde headset verbonden. Tik INSCHAKELEN om te starten."
const-string v1, "Selected headset connected. Tap ENABLE to start."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static noSelectedTitle(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Geen geselecteerde headset verbonden"
const-string v1, "No selected headset connected"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static noSelectedText(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Verbind eerst de gekozen Bluetooth-headset. LiveClearMic blijft uit."
const-string v1, "Connect the selected Bluetooth headset first. LiveClearMic stays off."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static notifTitleOn(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "LiveClearMic — AAN"
const-string v1, "LiveClearMic — ON"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static notifTitlePaused(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "LiveClearMic — PAUZE"
const-string v1, "LiveClearMic — PAUSED"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static notifActiveText(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Filtering actief voor deze opname."
const-string v1, "Filtering enabled for this recording."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static notifWaitingText(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Wacht op microfoongebruik."
const-string v1, "Waiting for microphone use."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public static notifCallText(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Gesprek actief"
const-string v1, "Call active"
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method

.method public static notifBypassText(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Filtering uit voor deze opname."
const-string v1, "Filtering disabled for this recording."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static noSelectedLong(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Geen geselecteerde headset verbonden. Verbind eerst de gekozen Bluetooth-headset."
const-string v1, "No selected headset connected. Connect the selected Bluetooth headset first."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method


.method public static disconnectedToast(Landroid/content/Context;)Ljava/lang/String;
.locals 2
const-string v0, "Geselecteerde headset ontkoppeld. LiveClearMic is automatisch uitgezet."
const-string v1, "Selected headset disconnected. LiveClearMic was turned off automatically."
invoke-static {p0, v0, v1}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
return-object v0
.end method

