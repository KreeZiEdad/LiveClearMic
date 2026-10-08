.class public Lapp/liveclearmic/HeadsetChoiceListener;
.super Ljava/lang/Object;
.implements Landroid/content/DialogInterface$OnClickListener;

.field private activity:Lapp/liveclearmic/MainActivity;
.field private devices:[Landroid/media/AudioDeviceInfo;

.method public constructor <init>(Lapp/liveclearmic/MainActivity;[Landroid/media/AudioDeviceInfo;)V
.locals 0
invoke-direct {p0}, Ljava/lang/Object;-><init>()V
iput-object p1, p0, Lapp/liveclearmic/HeadsetChoiceListener;->activity:Lapp/liveclearmic/MainActivity;
iput-object p2, p0, Lapp/liveclearmic/HeadsetChoiceListener;->devices:[Landroid/media/AudioDeviceInfo;
return-void
.end method

.method public onClick(Landroid/content/DialogInterface;I)V
.locals 2
iget-object v0, p0, Lapp/liveclearmic/HeadsetChoiceListener;->devices:[Landroid/media/AudioDeviceInfo;
aget-object v0, v0, p2
iget-object v1, p0, Lapp/liveclearmic/HeadsetChoiceListener;->activity:Lapp/liveclearmic/MainActivity;
invoke-virtual {v1, v0}, Lapp/liveclearmic/MainActivity;->associateSelectedHeadset(Landroid/media/AudioDeviceInfo;)V
invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
return-void
.end method
