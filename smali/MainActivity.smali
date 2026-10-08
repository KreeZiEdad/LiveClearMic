.class public Lapp/liveclearmic/MainActivity;
.super Landroid/app/Activity;
.implements Landroid/view/View$OnClickListener;
.implements Ljava/lang/Runnable;
.implements Landroid/widget/PopupMenu$OnMenuItemClickListener;
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;
.implements Landroid/content/DialogInterface$OnClickListener;

.field private root:Landroid/widget/LinearLayout;
.field private status:Landroid/widget/TextView;
.field private pairedStatus:Landroid/widget/TextView;
.field private toggleButton:Landroid/widget/Button;
.field private handler:Landroid/os/Handler;
.field private pendingStart:I
.field private buildTapCount:I
.field private authorTapCount:I
.field private startMuteDialogSwitch:Landroid/widget/Switch;
.field private startMuteDialogSeek:Landroid/widget/SeekBar;
.field private startMuteDialogValue:Landroid/widget/TextView;
.field private startMuteDialogReset:Landroid/widget/Button;
.field private startMuteDialogEnabled:Z
.field private startMuteDialogDuration:I
.field private startMuteDialogStatusLabel:Landroid/widget/TextView;

.method public constructor <init>()V
.locals 0
invoke-direct {p0}, Landroid/app/Activity;-><init>()V
return-void
.end method

.method public dp(I)I
.locals 2
invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;
move-result-object v0
invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;
move-result-object v0
iget v0, v0, Landroid/util/DisplayMetrics;->density:F
int-to-float v1, p1
mul-float v0, v0, v1
float-to-int v0, v0
return v0
.end method

.method public paragraph(Ljava/lang/String;I)Landroid/widget/TextView;
.locals 6
new-instance v0, Landroid/widget/TextView;
invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
int-to-float v1, p2
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V
const v1, 0xffe8eef7
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V
const/16 v1, 17
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V
const/4 v1, 0
const/16 v2, 8
invoke-virtual {p0, v2}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v2
invoke-virtual {v0, v1, v2, v1, v2}, Landroid/view/View;->setPadding(IIII)V
new-instance v3, Landroid/widget/LinearLayout$LayoutParams;
const/4 v4, -1
const/4 v5, -2
invoke-direct {v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V
iget-object v4, p0, Lapp/liveclearmic/MainActivity;->root:Landroid/widget/LinearLayout;
invoke-virtual {v4, v0, v3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
return-object v0
.end method

.method public button(Ljava/lang/String;I)Landroid/widget/Button;
.locals 6
new-instance v0, Landroid/widget/Button;
invoke-direct {v0, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
invoke-virtual {v0, p2}, Landroid/view/View;->setId(I)V
const/4 v1, 0
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setAllCaps(Z)V
const v1, 0x41800000
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V
const/16 v1, 60
invoke-virtual {p0, v1}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v1
invoke-virtual {v0, v1}, Landroid/view/View;->setMinimumHeight(I)V
invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
new-instance v1, Landroid/widget/LinearLayout$LayoutParams;
const/4 v2, -1
const/4 v3, -2
invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V
const/16 v2, 8
invoke-virtual {p0, v2}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v2
const/4 v3, 0
invoke-virtual {v1, v3, v2, v3, v2}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V
iget-object v2, p0, Lapp/liveclearmic/MainActivity;->root:Landroid/widget/LinearLayout;
invoke-virtual {v2, v0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
return-object v0
.end method

.method public roundButton(Landroid/widget/Button;II)V
.locals 4
new-instance v0, Landroid/graphics/drawable/GradientDrawable;
invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V
const/4 v1, 0
invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V
invoke-virtual {v0, p2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V
const/16 v1, 24
invoke-virtual {p0, v1}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v1
int-to-float v2, v1
invoke-virtual {v0, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V
const/4 v1, 1
invoke-virtual {p0, v1}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v1
invoke-virtual {v0, v1, p3}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V
check-cast v0, Landroid/graphics/drawable/Drawable;
invoke-virtual {p1, v0}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V
return-void
.end method

.method public updateRoundButton(Landroid/widget/Button;II)V
.locals 2
invoke-virtual {p1}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;
move-result-object v0
check-cast v0, Landroid/graphics/drawable/GradientDrawable;
invoke-virtual {v0, p2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V
const/4 v1, 1
invoke-virtual {p0, v1}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v1
invoke-virtual {v0, v1, p3}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V
return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
.locals 10
sget v0, Landroid/R$style;->Theme_Material_NoActionBar:I
invoke-virtual {p0, v0}, Landroid/view/ContextThemeWrapper;->setTheme(I)V
invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V
const-string v8, "notification"
invoke-virtual {p0, v8}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v8
check-cast v8, Landroid/app/NotificationManager;
const/4 v9, 2
invoke-virtual {v8, v9}, Landroid/app/NotificationManager;->cancel(I)V
invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;
move-result-object v0
const v1, 0xff0b1220
invoke-virtual {v0, v1}, Landroid/view/Window;->setStatusBarColor(I)V
invoke-virtual {v0, v1}, Landroid/view/Window;->setNavigationBarColor(I)V

new-instance v0, Landroid/os/Handler;
invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
move-result-object v2
invoke-direct {v0, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
iput-object v0, p0, Lapp/liveclearmic/MainActivity;->handler:Landroid/os/Handler;

new-instance v0, Landroid/widget/ScrollView;
invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V
invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V
const/4 v2, 1
invoke-virtual {v0, v2}, Landroid/widget/ScrollView;->setFillViewport(Z)V

new-instance v1, Landroid/widget/LinearLayout;
invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V
const/4 v3, 1
invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setGravity(I)V
iput-object v1, p0, Lapp/liveclearmic/MainActivity;->root:Landroid/widget/LinearLayout;
const/16 v3, 28
invoke-virtual {p0, v3}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v3
const/16 v4, 8
invoke-virtual {p0, v4}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v4
const/16 v5, 20
invoke-virtual {p0, v5}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v5
invoke-virtual {v1, v3, v4, v3, v5}, Landroid/view/View;->setPadding(IIII)V
invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V
invoke-virtual {p0, v0}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

# Header: centered logo with overflow menu aligned at its upper-right side.
new-instance v6, Landroid/widget/FrameLayout;
invoke-direct {v6, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
new-instance v7, Landroid/widget/LinearLayout$LayoutParams;
const/4 v8, -1
const/16 v9, 176
invoke-virtual {p0, v9}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v9
invoke-direct {v7, v8, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V
# Header controls may sit a little farther toward the screen edges than the body content.
const/16 v9, -16
invoke-virtual {p0, v9}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v9
const/4 v8, 0
invoke-virtual {v7, v9, v8, v9, v8}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V
iget-object v8, p0, Lapp/liveclearmic/MainActivity;->root:Landroid/widget/LinearLayout;
invoke-virtual {v8, v6, v7}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

new-instance v0, Landroid/widget/ImageView;
invoke-direct {v0, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V
invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;
move-result-object v2
const-string v3, "liveclearmic_logo.png"
invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;
move-result-object v2
invoke-static {v2}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;
move-result-object v3
invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V
invoke-virtual {v2}, Ljava/io/InputStream;->close()V
new-instance v2, Landroid/widget/FrameLayout$LayoutParams;
const/16 v3, 176
invoke-virtual {p0, v3}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v3
invoke-direct {v2, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
const/16 v3, 17
iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->gravity:I
check-cast v0, Landroid/view/View;
check-cast v2, Landroid/view/ViewGroup$LayoutParams;
invoke-virtual {v6, v0, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

# Compact NL/EN switch to the left of the logo. First-run default follows the Android system language.
new-instance v0, Landroid/widget/Switch;
invoke-direct {v0, p0}, Landroid/widget/Switch;-><init>(Landroid/content/Context;)V
const/4 v2, 7
invoke-virtual {v0, v2}, Landroid/view/View;->setId(I)V
const-string v2, "NL"
invoke-virtual {v0, v2}, Landroid/widget/Switch;->setTextOff(Ljava/lang/CharSequence;)V
const-string v2, "EN"
invoke-virtual {v0, v2}, Landroid/widget/Switch;->setTextOn(Ljava/lang/CharSequence;)V
const/4 v2, 1
invoke-virtual {v0, v2}, Landroid/widget/Switch;->setShowText(Z)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->isEnglish(Landroid/content/Context;)Z
move-result v2
invoke-virtual {v0, v2}, Landroid/widget/CompoundButton;->setChecked(Z)V
const v2, 0xfff8fafc
invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->languageDescription(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
invoke-virtual {v0, v2}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
invoke-virtual {v0, p0}, Landroid/widget/CompoundButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V
new-instance v2, Landroid/widget/FrameLayout$LayoutParams;
const/16 v3, 64
invoke-virtual {p0, v3}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v3
const/16 v4, 48
invoke-virtual {p0, v4}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v4
invoke-direct {v2, v3, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
const/16 v3, 51
iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->gravity:I
const/4 v3, 0
const/16 v4, 8
invoke-virtual {p0, v4}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v4
move-object v5, v2
check-cast v5, Landroid/view/ViewGroup$MarginLayoutParams;
invoke-virtual {v5, v3, v4, v3, v3}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V
check-cast v0, Landroid/view/View;
check-cast v2, Landroid/view/ViewGroup$LayoutParams;
invoke-virtual {v6, v0, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

new-instance v0, Landroid/widget/TextView;
invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
const-string v2, "⋮"
invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const/4 v2, 5
invoke-virtual {v0, v2}, Landroid/view/View;->setId(I)V
const v2, 0x41e00000
invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextSize(F)V
const v2, 0xfff8fafc
invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V
const/16 v2, 17
invoke-virtual {v0, v2}, Landroid/widget/TextView;->setGravity(I)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->moreOptions(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
invoke-virtual {v0, v2}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
new-instance v2, Landroid/widget/FrameLayout$LayoutParams;
const/16 v3, 48
invoke-virtual {p0, v3}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v3
invoke-direct {v2, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
const/16 v3, 53
iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->gravity:I
const/4 v3, 0
const/16 v4, 8
invoke-virtual {p0, v4}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v4
move-object v5, v2
check-cast v5, Landroid/view/ViewGroup$MarginLayoutParams;
invoke-virtual {v5, v3, v4, v3, v3}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V
check-cast v0, Landroid/view/View;
check-cast v2, Landroid/view/ViewGroup$LayoutParams;
invoke-virtual {v6, v0, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

const-string v0, "LiveClearMic"
const/16 v1, 30
invoke-virtual {p0, v0, v1}, Lapp/liveclearmic/MainActivity;->paragraph(Ljava/lang/String;I)Landroid/widget/TextView;
move-result-object v0
const v1, 0xfff8fafc
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->bluetoothHeadset(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
const/16 v1, 16
invoke-virtual {p0, v0, v1}, Lapp/liveclearmic/MainActivity;->paragraph(Ljava/lang/String;I)Landroid/widget/TextView;
move-result-object v0
const v1, 0xff94a3b8
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->stateOff(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
const/16 v1, 24
invoke-virtual {p0, v0, v1}, Lapp/liveclearmic/MainActivity;->paragraph(Ljava/lang/String;I)Landroid/widget/TextView;
move-result-object v0
iput-object v0, p0, Lapp/liveclearmic/MainActivity;->status:Landroid/widget/TextView;

invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->turnOn(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
const/4 v1, 1
invoke-virtual {p0, v0, v1}, Lapp/liveclearmic/MainActivity;->button(Ljava/lang/String;I)Landroid/widget/Button;
move-result-object v0
iput-object v0, p0, Lapp/liveclearmic/MainActivity;->toggleButton:Landroid/widget/Button;
const/16 v1, 112
invoke-virtual {p0, v1}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v1
invoke-virtual {v0, v1}, Landroid/view/View;->setMinimumHeight(I)V
const v1, 0x41a00000
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V
const v1, 0xffffffff
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V
const v2, 0xff2dd4bf
const v3, 0xff67e8f9
invoke-virtual {p0, v0, v2, v3}, Lapp/liveclearmic/MainActivity;->roundButton(Landroid/widget/Button;II)V

invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->selectedNone(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
const/16 v1, 14
invoke-virtual {p0, v0, v1}, Lapp/liveclearmic/MainActivity;->paragraph(Ljava/lang/String;I)Landroid/widget/TextView;
move-result-object v0
iput-object v0, p0, Lapp/liveclearmic/MainActivity;->pairedStatus:Landroid/widget/TextView;
const v1, 0xff94a3b8
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V
const/4 v1, 1
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setSingleLine(Z)V
sget-object v1, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->chooseHeadset(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
const/4 v1, 3
invoke-virtual {p0, v0, v1}, Lapp/liveclearmic/MainActivity;->button(Ljava/lang/String;I)Landroid/widget/Button;
move-result-object v0
const v1, 0xfff8fafc
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V
const v2, 0xff123247
const v3, 0xff22d3ee
invoke-virtual {p0, v0, v2, v3}, Lapp/liveclearmic/MainActivity;->roundButton(Landroid/widget/Button;II)V

new-instance v0, Landroid/widget/Space;
invoke-direct {v0, p0}, Landroid/widget/Space;-><init>(Landroid/content/Context;)V
new-instance v1, Landroid/widget/LinearLayout$LayoutParams;
const/4 v2, -1
const/4 v3, 0
const v4, 0x3f800000
invoke-direct {v1, v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
iget-object v2, p0, Lapp/liveclearmic/MainActivity;->root:Landroid/widget/LinearLayout;
check-cast v0, Landroid/view/View;
check-cast v1, Landroid/view/ViewGroup$LayoutParams;
invoke-virtual {v2, v0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

# Subtle one-line footer. Version remains its own click target for the build
# easter egg; Donate/Doneer is a separate link target.
new-instance v6, Landroid/widget/LinearLayout;
invoke-direct {v6, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
const/4 v1, 0
invoke-virtual {v6, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V
const/16 v1, 17
invoke-virtual {v6, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

new-instance v0, Landroid/widget/TextView;
invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
const-string v1, "Gemaakt door KreeZiE · "
const-string v2, "Made by KreeZiE · "
invoke-static {p0, v1, v2}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v1
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const v1, 0x41400000
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V
const v1, 0xff475569
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V
const/4 v1, 1
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setSingleLine(Z)V
# Hidden support action: five taps on Gemaakt door / Made by KreeZiE copies diagnosis.
const/16 v1, 10
invoke-virtual {v0, v1}, Landroid/view/View;->setId(I)V
invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
invoke-virtual {v6, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

new-instance v0, Landroid/widget/TextView;
invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
const-string v1, "v2.0"
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const v1, 0x41400000
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V
const v1, 0xff475569
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V
const/4 v1, 1
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setSingleLine(Z)V
# Easter egg: five taps on the version label shows the official production build count.
const/16 v1, 8
invoke-virtual {v0, v1}, Landroid/view/View;->setId(I)V
invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
invoke-virtual {v6, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

new-instance v0, Landroid/widget/TextView;
invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
const-string v1, " · ☕ Doneer"
const-string v2, " · ☕ Donate"
invoke-static {p0, v1, v2}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v1
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const v1, 0x41400000
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V
const v1, 0xff475569
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V
const/4 v1, 1
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setSingleLine(Z)V
const/16 v1, 9
invoke-virtual {v0, v1}, Landroid/view/View;->setId(I)V
invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
invoke-virtual {v6, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

new-instance v1, Landroid/widget/LinearLayout$LayoutParams;
const/4 v2, -2
const/4 v3, -2
invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V
iget-object v2, p0, Lapp/liveclearmic/MainActivity;->root:Landroid/widget/LinearLayout;
invoke-virtual {v2, v6, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->refreshPaired()V

# 2.0: no microphone permission or diagnostic recording is needed.


invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;
move-result-object v0
const-string v1, "autoStart"
const/4 v2, 0
invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z
move-result v0
if-eqz v0, :created_done
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->startFilter()V
:created_done
return-void
.end method

.method public toast(Ljava/lang/String;)V
.locals 2
const/4 v0, 1
invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
move-result-object v0
invoke-virtual {v0}, Landroid/widget/Toast;->show()V
return-void
.end method

.method public permitted()Z
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



.method public startFilter()V
.locals 5
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-nez v0, :done
:start
const/4 v0, 0
invoke-static {p0, v0}, Lapp/liveclearmic/ProbeService;->setUserClosed(Landroid/content/Context;Z)V
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->permitted()Z
move-result v0
if-nez v0, :permission_ok
const/4 v0, 1
iput v0, p0, Lapp/liveclearmic/MainActivity;->pendingStart:I
new-array v0, v0, [Ljava/lang/String;
const/4 v1, 0
const-string v2, "android.permission.POST_NOTIFICATIONS"
aput-object v2, v0, v1
const/16 v1, 100
invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->requestPermissions([Ljava/lang/String;I)V
return-void
:permission_ok
const/4 v0, 0
iput v0, p0, Lapp/liveclearmic/MainActivity;->pendingStart:I
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->hasBudsConnected(Landroid/content/Context;)Z
move-result v0
if-nez v0, :start_service
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->hasSaved(Landroid/content/Context;)Z
move-result v1
if-nez v1, :saved_but_disconnected
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->chooseFirst(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {p0, v0}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
goto/16 :no_headset_done
:saved_but_disconnected
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->displayNames(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
new-instance v2, Ljava/lang/StringBuilder;
invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->notConnectedSuffix(Landroid/content/Context;)Ljava/lang/String;
move-result-object v3
invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v0
invoke-virtual {p0, v0}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
:no_headset_done
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
goto/16 :done
:start_service
new-instance v0, Landroid/content/Intent;
const-class v1, Lapp/liveclearmic/ProbeService;
invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
invoke-virtual {p0, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->couldNotStart(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {p0, v0}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
.locals 3
invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V
const/16 v0, 100
if-ne p1, v0, :check_bluetooth
iget v0, p0, Lapp/liveclearmic/MainActivity;->pendingStart:I
const/4 v1, 0
iput v1, p0, Lapp/liveclearmic/MainActivity;->pendingStart:I
if-eqz v0, :done
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->permitted()Z
move-result v0
if-eqz v0, :notify_denied
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->startFilter()V
goto/16 :done
:notify_denied
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->notificationPermission(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {p0, v0}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
goto/16 :done
:check_bluetooth
const/16 v0, 101
if-ne p1, v0, :done
const-string v0, "android.permission.BLUETOOTH_CONNECT"
invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I
move-result v1
if-nez v1, :bt_denied
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->pairCurrentHeadset()V
goto/16 :done
:bt_denied
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->nearbyPermission(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
invoke-virtual {p0, v2}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
:done
return-void
.end method

.method public stopFilter()V
.locals 3
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v0, :done
new-instance v0, Landroid/content/Intent;
const-class v1, Lapp/liveclearmic/ProbeService;
invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const-string v1, "STOP"
invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
invoke-virtual {p0, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
:done
return-void
.end method

.method public onClick(Landroid/view/View;)V
.locals 4
:start
invoke-virtual {p1}, Landroid/view/View;->getId()I
move-result v0
# Startmute dialog: reset duration to default 500 ms.
const/16 v1, 71
if-ne v0, v1, :main_toggle
const/16 v1, 500
iput v1, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogDuration:I
iget-object v2, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogSeek:Landroid/widget/SeekBar;
if-eqz v2, :reset_value_only
const/16 v3, 10
invoke-virtual {v2, v3}, Landroid/widget/SeekBar;->setProgress(I)V
:reset_value_only
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->updateStartMuteDialogValue()V
goto/16 :done
:main_toggle
const/4 v1, 1
if-ne v0, v1, :headset
sget-boolean v1, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v1, :turn_on
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->stopFilter()V
goto/16 :done
:turn_on
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->startFilter()V
goto/16 :done
:headset
const/4 v1, 3
if-ne v0, v1, :overflow
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->pairCurrentHeadset()V
goto/16 :done
:overflow
const/4 v1, 5
if-ne v0, v1, :author_tap
invoke-virtual {p0, p1}, Lapp/liveclearmic/MainActivity;->showOverflowMenu(Landroid/view/View;)V
goto/16 :done
:author_tap
const/16 v1, 10
if-ne v0, v1, :version_tap
iget v1, p0, Lapp/liveclearmic/MainActivity;->authorTapCount:I
add-int/lit8 v1, v1, 1
iput v1, p0, Lapp/liveclearmic/MainActivity;->authorTapCount:I
const/4 v2, 5
if-lt v1, v2, :done
const/4 v1, 0
iput v1, p0, Lapp/liveclearmic/MainActivity;->authorTapCount:I
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->copyDiagnose()V
goto/16 :done
:version_tap
const/16 v1, 8
if-ne v0, v1, :donate
iget v1, p0, Lapp/liveclearmic/MainActivity;->buildTapCount:I
add-int/lit8 v1, v1, 1
iput v1, p0, Lapp/liveclearmic/MainActivity;->buildTapCount:I
const/4 v2, 5
if-lt v1, v2, :done
const/4 v1, 0
iput v1, p0, Lapp/liveclearmic/MainActivity;->buildTapCount:I
const-string v1, "80 builds later…"
invoke-virtual {p0, v1}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
goto/16 :done
:donate
const/16 v1, 9
if-ne v0, v1, :forget
new-instance v1, Landroid/content/Intent;
const-string v2, "android.intent.action.VIEW"
invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
const-string v2, "https://donolink.nl/u/kreezie"
invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
move-result-object v2
invoke-virtual {v1, v2}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;
invoke-virtual {p0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
goto/16 :done
:forget
const/4 v1, 4
if-ne v0, v1, :done
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->forgetHeadsets()V
goto/16 :done
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->genericError(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {p0, v0}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
.locals 4
invoke-virtual {p1}, Landroid/view/View;->getId()I
move-result v0
const/16 v1, 70
if-ne v0, v1, :language_switch
# Startmute dialog switch changes temporary state until Save is pressed.
iput-boolean p2, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogEnabled:Z
if-eqz p2, :dialog_label_disabled
const-string v1, "Ingeschakeld"
const-string v2, "Enabled"
goto/16 :dialog_label_ready
:dialog_label_disabled
const-string v1, "Uitgeschakeld"
const-string v2, "Disabled"
:dialog_label_ready
invoke-static {p0, v1, v2}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v1
iget-object v2, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogStatusLabel:Landroid/widget/TextView;
if-eqz v2, :dialog_seek_enable
invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
:dialog_seek_enable
iget-object v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogSeek:Landroid/widget/SeekBar;
if-eqz v0, :dialog_reset_enable
invoke-virtual {v0, p2}, Landroid/widget/SeekBar;->setEnabled(Z)V
:dialog_reset_enable
iget-object v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogReset:Landroid/widget/Button;
if-eqz v0, :dialog_value_enable
invoke-virtual {v0, p2}, Landroid/widget/Button;->setEnabled(Z)V
:dialog_value_enable
iget-object v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogValue:Landroid/widget/TextView;
if-eqz v0, :dialog_update_value
invoke-virtual {v0, p2}, Landroid/widget/TextView;->setEnabled(Z)V
:dialog_update_value
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->updateStartMuteDialogValue()V
return-void
:language_switch
invoke-static {p0, p2}, Lapp/liveclearmic/LanguageStore;->setEnglish(Landroid/content/Context;Z)V
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v0, :refresh_inactive
new-instance v1, Landroid/content/Intent;
const-class v2, Lapp/liveclearmic/ProbeService;
invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const-string v2, "REFRESH"
invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
invoke-virtual {p0, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
goto/16 :recreate
:refresh_inactive
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->hasBudsConnected(Landroid/content/Context;)Z
move-result v0
if-eqz v0, :clear_inactive
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->postControlOff(Landroid/content/Context;)V
goto/16 :recreate
:clear_inactive
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
:recreate
invoke-virtual {p0}, Landroid/app/Activity;->recreate()V
return-void
.end method

.method public showOverflowMenu(Landroid/view/View;)V
.locals 7
new-instance v0, Landroid/widget/PopupMenu;
invoke-direct {v0, p0, p1}, Landroid/widget/PopupMenu;-><init>(Landroid/content/Context;Landroid/view/View;)V
invoke-virtual {v0}, Landroid/widget/PopupMenu;->getMenu()Landroid/view/Menu;
move-result-object v1
const/4 v2, 0

# 1. Single Startmute settings entry, with current status visible in the menu.
const/16 v3, 9
const/4 v4, 0
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->isStartMuteEnabled(Landroid/content/Context;)Z
move-result v6
if-eqz v6, :overflow_startmute_off
const-string v5, "Startmute: AAN"
const-string v6, "Startmute: ON"
goto/16 :overflow_startmute_label_ready
:overflow_startmute_off
const-string v5, "Startmute: UIT"
const-string v6, "Startmute: OFF"
:overflow_startmute_label_ready
invoke-static {p0, v5, v6}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v5
invoke-interface {v1, v2, v3, v4, v5}, Landroid/view/Menu;->add(IIILjava/lang/CharSequence;)Landroid/view/MenuItem;

# 2. Apparaten wissen / Clear devices
const/4 v3, 4
const/4 v4, 1
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->forgetDevices(Landroid/content/Context;)Ljava/lang/String;
move-result-object v5
invoke-interface {v1, v2, v3, v4, v5}, Landroid/view/Menu;->add(IIILjava/lang/CharSequence;)Landroid/view/MenuItem;

# 3. LiveClearMic afsluiten / Close LiveClearMic
const/4 v3, 6
const/4 v4, 2
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->closeAppMenu(Landroid/content/Context;)Ljava/lang/String;
move-result-object v5
invoke-interface {v1, v2, v3, v4, v5}, Landroid/view/Menu;->add(IIILjava/lang/CharSequence;)Landroid/view/MenuItem;

invoke-virtual {v0, p0}, Landroid/widget/PopupMenu;->setOnMenuItemClickListener(Landroid/widget/PopupMenu$OnMenuItemClickListener;)V
invoke-virtual {v0}, Landroid/widget/PopupMenu;->show()V
return-void
.end method

.method public onMenuItemClick(Landroid/view/MenuItem;)Z
.locals 3
invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I
move-result v0
const/16 v1, 9
if-ne v0, v1, :forget
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->showStartMuteSettingsDialog()V
const/4 v0, 1
return v0
:forget
const/4 v1, 4
if-ne v0, v1, :exit_app
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->forgetHeadsets()V
const/4 v0, 1
return v0
:exit_app
const/4 v1, 6
if-ne v0, v1, :no
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->closeApp()V
const/4 v0, 1
return v0
:no
const/4 v0, 0
return v0
.end method

.method public showStartMuteSettingsDialog()V
.locals 12
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->isStartMuteEnabled(Landroid/content/Context;)Z
move-result v0
iput-boolean v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogEnabled:Z
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->getStartMuteDurationMs(Landroid/content/Context;)I
move-result v1
iput v1, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogDuration:I

new-instance v2, Landroid/app/AlertDialog$Builder;
invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->startMuteLabel(Landroid/content/Context;)Ljava/lang/String;
move-result-object v3
invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

new-instance v3, Landroid/widget/LinearLayout;
invoke-direct {v3, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
const/4 v4, 1
invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V
const/16 v4, 20
invoke-virtual {p0, v4}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v4
const/16 v5, 12
invoke-virtual {p0, v5}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v5
invoke-virtual {v3, v4, v5, v4, v5}, Landroid/view/View;->setPadding(IIII)V

new-instance v6, Landroid/widget/TextView;
invoke-direct {v6, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
const-string v7, "Dempt kort het begin van een opname terwijl de Bluetooth-verbinding tot stand wordt gebracht."
const-string v8, "Briefly mutes the start of a recording while the Bluetooth connection is being established."
invoke-static {p0, v7, v8}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v7
invoke-virtual {v6, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const v7, 0x41600000
invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextSize(F)V
const v7, 0xffb8c2d6
invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextColor(I)V
const/4 v7, 0
const/16 v8, 12
invoke-virtual {p0, v8}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v8
invoke-virtual {v6, v7, v7, v7, v8}, Landroid/view/View;->setPadding(IIII)V
check-cast v6, Landroid/view/View;
invoke-virtual {v3, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

# Startmute state row; no hidden test trigger in 2.0.
new-instance v6, Landroid/widget/LinearLayout;
invoke-direct {v6, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
const/4 v7, 0
invoke-virtual {v6, v7}, Landroid/widget/LinearLayout;->setOrientation(I)V
const/16 v7, 16
invoke-virtual {v6, v7}, Landroid/widget/LinearLayout;->setGravity(I)V
new-instance v8, Landroid/widget/TextView;
invoke-direct {v8, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
iget-boolean v7, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogEnabled:Z
if-eqz v7, :startmute_switch_label_off
const-string v9, "Ingeschakeld"
const-string v10, "Enabled"
goto/16 :startmute_switch_label_ready
:startmute_switch_label_off
const-string v9, "Uitgeschakeld"
const-string v10, "Disabled"
:startmute_switch_label_ready
invoke-static {p0, v9, v10}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v9
invoke-virtual {v8, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const v9, 0x41900000
invoke-virtual {v8, v9}, Landroid/widget/TextView;->setTextSize(F)V
const v9, 0xffe8eef7
invoke-virtual {v8, v9}, Landroid/widget/TextView;->setTextColor(I)V
iput-object v8, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogStatusLabel:Landroid/widget/TextView;
new-instance v9, Landroid/widget/LinearLayout$LayoutParams;
const/4 v10, 0
const/4 v11, -2
const v4, 0x3f800000
invoke-direct {v9, v10, v11, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
invoke-virtual {v6, v8, v9}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
new-instance v8, Landroid/widget/Switch;
invoke-direct {v8, p0}, Landroid/widget/Switch;-><init>(Landroid/content/Context;)V
const/16 v9, 70
invoke-virtual {v8, v9}, Landroid/view/View;->setId(I)V
invoke-virtual {v8, v7}, Landroid/widget/CompoundButton;->setChecked(Z)V
iput-object v8, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogSwitch:Landroid/widget/Switch;
invoke-virtual {v6, v8}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V
check-cast v6, Landroid/view/View;
invoke-virtual {v3, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

new-instance v6, Landroid/widget/TextView;
invoke-direct {v6, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
const v7, 0x41f00000
invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextSize(F)V
const v7, 0xffe8eef7
invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextColor(I)V
const/16 v7, 17
invoke-virtual {v6, v7}, Landroid/widget/TextView;->setGravity(I)V
const/4 v7, 0
const/16 v8, 18
invoke-virtual {p0, v8}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v8
const/16 v9, 6
invoke-virtual {p0, v9}, Lapp/liveclearmic/MainActivity;->dp(I)I
move-result v9
invoke-virtual {v6, v7, v8, v7, v9}, Landroid/view/View;->setPadding(IIII)V
iput-object v6, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogValue:Landroid/widget/TextView;
check-cast v6, Landroid/view/View;
invoke-virtual {v3, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

# Slider: 21 values, 250..750 ms in 25 ms steps.
new-instance v6, Landroid/widget/SeekBar;
invoke-direct {v6, p0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V
const/16 v7, 20
invoke-virtual {v6, v7}, Landroid/widget/SeekBar;->setMax(I)V
iget v8, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogDuration:I
const/4 v7, 0
const/16 v9, 250
:seek_progress_loop
if-ge v9, v8, :seek_progress_done
const/16 v10, 20
if-ge v7, v10, :seek_progress_done
add-int/lit8 v9, v9, 25
add-int/lit8 v7, v7, 1
goto/16 :seek_progress_loop
:seek_progress_done
invoke-virtual {v6, v7}, Landroid/widget/SeekBar;->setProgress(I)V
iput-object v6, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogSeek:Landroid/widget/SeekBar;
check-cast v6, Landroid/view/View;
invoke-virtual {v3, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

new-instance v6, Landroid/widget/LinearLayout;
invoke-direct {v6, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
const/4 v7, 0
invoke-virtual {v6, v7}, Landroid/widget/LinearLayout;->setOrientation(I)V
new-instance v8, Landroid/widget/TextView;
invoke-direct {v8, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
const-string v9, "250 ms"
invoke-virtual {v8, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const v9, 0xff94a3b8
invoke-virtual {v8, v9}, Landroid/widget/TextView;->setTextColor(I)V
new-instance v10, Landroid/widget/LinearLayout$LayoutParams;
const/4 v11, 0
const/4 v7, -2
const v4, 0x3f800000
invoke-direct {v10, v11, v7, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
invoke-virtual {v6, v8, v10}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
new-instance v8, Landroid/widget/TextView;
invoke-direct {v8, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
const-string v10, "750 ms"
invoke-virtual {v8, v10}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
invoke-virtual {v8, v9}, Landroid/widget/TextView;->setTextColor(I)V
const/4 v10, 5
invoke-virtual {v8, v10}, Landroid/widget/TextView;->setGravity(I)V
new-instance v10, Landroid/widget/LinearLayout$LayoutParams;
const/4 v11, 0
const/4 v7, -2
const v4, 0x3f800000
invoke-direct {v10, v11, v7, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
invoke-virtual {v6, v8, v10}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
check-cast v6, Landroid/view/View;
invoke-virtual {v3, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

new-instance v6, Landroid/widget/Button;
invoke-direct {v6, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
const/16 v7, 71
invoke-virtual {v6, v7}, Landroid/view/View;->setId(I)V
const-string v7, "Terug naar standaard (500 ms)"
const-string v8, "Reset to default (500 ms)"
invoke-static {p0, v7, v8}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v7
invoke-virtual {v6, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const/4 v7, 0
invoke-virtual {v6, v7}, Landroid/widget/TextView;->setAllCaps(Z)V
invoke-virtual {v6, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
iput-object v6, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogReset:Landroid/widget/Button;
check-cast v6, Landroid/view/View;
invoke-virtual {v3, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

iget-boolean v6, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogEnabled:Z
iget-object v7, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogSeek:Landroid/widget/SeekBar;
invoke-virtual {v7, v6}, Landroid/widget/SeekBar;->setEnabled(Z)V
iget-object v7, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogReset:Landroid/widget/Button;
invoke-virtual {v7, v6}, Landroid/widget/Button;->setEnabled(Z)V
iget-object v7, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogValue:Landroid/widget/TextView;
invoke-virtual {v7, v6}, Landroid/widget/TextView;->setEnabled(Z)V
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->updateStartMuteDialogValue()V
iget-object v6, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogSwitch:Landroid/widget/Switch;
invoke-virtual {v6, p0}, Landroid/widget/CompoundButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V
iget-object v6, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogSeek:Landroid/widget/SeekBar;
invoke-virtual {v6, p0}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V
move-object v6, v3
check-cast v6, Landroid/view/View;
invoke-virtual {v2, v6}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;
const-string v6, "Opslaan"
const-string v7, "Save"
invoke-static {p0, v6, v7}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v6
move-object v7, p0
check-cast v7, Landroid/content/DialogInterface$OnClickListener;
invoke-virtual {v2, v6, v7}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
const-string v6, "Annuleren"
const-string v7, "Cancel"
invoke-static {p0, v6, v7}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v6
const/4 v7, 0
invoke-virtual {v2, v6, v7}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
invoke-virtual {v2}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
return-void
.end method












.method public updateStartMuteDialogValue()V
.locals 5
iget-object v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogValue:Landroid/widget/TextView;
if-eqz v0, :done
# When Startmute is off, leave the large duration area empty. The disabled slider remains visible.
iget-boolean v1, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogEnabled:Z
if-nez v1, :show_duration
const-string v1, ""
invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
goto/16 :done
:show_duration
new-instance v1, Ljava/lang/StringBuilder;
invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
iget v2, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogDuration:I
invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
const-string v3, " ms"
invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v4
invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
:done
return-void
.end method

.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
.locals 3
const/16 v0, 250
const/4 v1, 0
:progress_to_ms
if-ge v1, p2, :progress_done
add-int/lit8 v0, v0, 25
add-int/lit8 v1, v1, 1
goto/16 :progress_to_ms
:progress_done
iput v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogDuration:I
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->updateStartMuteDialogValue()V
return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
.locals 0
return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
.locals 0
return-void
.end method

.method public onClick(Landroid/content/DialogInterface;I)V
.locals 6
const/4 v0, -1
if-ne p2, v0, :dialog_cleanup
iget-boolean v1, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogEnabled:Z
invoke-static {p0, v1}, Lapp/liveclearmic/ProbeService;->setStartMuteEnabled(Landroid/content/Context;Z)V
iget v2, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogDuration:I
invoke-static {p0, v2}, Lapp/liveclearmic/ProbeService;->setStartMuteDurationMs(Landroid/content/Context;I)V
if-eqz v1, :toast_off
new-instance v3, Ljava/lang/StringBuilder;
invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
const-string v4, "Ingesteld op "
const-string v5, "Set to "
invoke-static {p0, v4, v5}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v4
invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
const-string v4, " ms"
invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v3
invoke-virtual {p0, v3}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
goto/16 :dialog_cleanup
:toast_off
const-string v3, "Startmute uitgeschakeld"
const-string v4, "Start mute disabled"
invoke-static {p0, v3, v4}, Lapp/liveclearmic/LanguageStore;->text(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v3
invoke-virtual {p0, v3}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
:dialog_cleanup
const/4 v0, 0
iput-object v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogSwitch:Landroid/widget/Switch;
iput-object v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogSeek:Landroid/widget/SeekBar;
iput-object v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogValue:Landroid/widget/TextView;
iput-object v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogReset:Landroid/widget/Button;
iput-object v0, p0, Lapp/liveclearmic/MainActivity;->startMuteDialogStatusLabel:Landroid/widget/TextView;
return-void
.end method

.method public closeApp()V
.locals 4
:start
const/4 v0, 1
invoke-static {p0, v0}, Lapp/liveclearmic/ProbeService;->setUserClosed(Landroid/content/Context;Z)V
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v0, :no_service
new-instance v0, Landroid/content/Intent;
const-class v1, Lapp/liveclearmic/ProbeService;
invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
const-string v1, "EXIT"
invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
invoke-virtual {p0, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
goto/16 :finish_ui
:no_service
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
:finish_ui
invoke-virtual {p0}, Landroid/app/Activity;->finishAndRemoveTask()V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
invoke-virtual {p0}, Landroid/app/Activity;->finishAndRemoveTask()V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public copyDiagnose()V
.locals 3
:start
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->diagnose(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
const-string v1, "LiveClearMic 2.0 diagnosis"
invoke-static {v1, v0}, Landroid/content/ClipData;->newPlainText(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/content/ClipData;
move-result-object v0
const-string v1, "clipboard"
invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v1
check-cast v1, Landroid/content/ClipboardManager;
invoke-virtual {v1, v0}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->diagnosticsCopied(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {p0, v0}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
:end
return-void
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->genericError(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
invoke-virtual {p0, v1}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public refresh()V
.locals 5
sget-boolean v0, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v0, :off
iget-object v1, p0, Lapp/liveclearmic/MainActivity;->status:Landroid/widget/TextView;
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->isCallActive(Landroid/content/Context;)Z
move-result v2
if-eqz v2, :active_status_on
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->statePaused(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
goto/16 :active_status_ready
:active_status_on
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->stateOn(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
:active_status_ready
invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const v2, 0xff2dd4bf
invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V
iget-object v1, p0, Lapp/liveclearmic/MainActivity;->toggleButton:Landroid/widget/Button;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->turnOff(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const v2, 0xff334155
const v3, 0xff22d3ee
invoke-virtual {p0, v1, v2, v3}, Lapp/liveclearmic/MainActivity;->updateRoundButton(Landroid/widget/Button;II)V
const v2, 0xfff8fafc
invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V
goto/16 :done
:off
iget-object v1, p0, Lapp/liveclearmic/MainActivity;->status:Landroid/widget/TextView;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->stateOff(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const v2, 0xff94a3b8
invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V
iget-object v1, p0, Lapp/liveclearmic/MainActivity;->toggleButton:Landroid/widget/Button;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->turnOn(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
const v2, 0xff2dd4bf
const v3, 0xff67e8f9
invoke-virtual {p0, v1, v2, v3}, Lapp/liveclearmic/MainActivity;->updateRoundButton(Landroid/widget/Button;II)V
const v2, 0xff06121a
invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V
:done
return-void
.end method

.method public run()V
.locals 3
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->refresh()V
iget-object v0, p0, Lapp/liveclearmic/MainActivity;->handler:Landroid/os/Handler;
const-wide/16 v1, 500
invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
return-void
.end method





.method protected onResume()V
.locals 2
invoke-super {p0}, Landroid/app/Activity;->onResume()V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->isUserClosed(Landroid/content/Context;)Z
move-result v0
if-eqz v0, :resume_refresh
const/4 v0, 0
invoke-static {p0, v0}, Lapp/liveclearmic/ProbeService;->setUserClosed(Landroid/content/Context;Z)V
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->hasSaved(Landroid/content/Context;)Z
move-result v1
if-eqz v1, :resume_refresh
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->startFilter()V
:resume_refresh
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->refreshPaired()V
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->run()V
return-void
.end method


.method public refreshPaired()V
.locals 5
iget-object v0, p0, Lapp/liveclearmic/MainActivity;->pairedStatus:Landroid/widget/TextView;
if-eqz v0, :done
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->hasSaved(Landroid/content/Context;)Z
move-result v1
if-nez v1, :saved
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->selectedNone(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
goto/16 :done
:saved
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->displayNames(Landroid/content/Context;)Ljava/lang/String;
move-result-object v2
new-instance v3, Ljava/lang/StringBuilder;
invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->selectedPrefix(Landroid/content/Context;)Ljava/lang/String;
move-result-object v4
invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v2
invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
:done
return-void
.end method

.method public forgetHeadsets()V
.locals 2
:start
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->stopFilter()V
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->clear(Landroid/content/Context;)V
invoke-static {p0}, Lapp/liveclearmic/ProbeService;->cancelControlNotifications(Landroid/content/Context;)V
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->refreshPaired()V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->headsetForgotten(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {p0, v0}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->clearSavedFailed(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
invoke-virtual {p0, v1}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public pairCurrentHeadset()V
.locals 12
:start
const-string v0, "android.permission.BLUETOOTH_CONNECT"
invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I
move-result v1
if-eqz v1, :permission_ok
const/4 v1, 1
new-array v1, v1, [Ljava/lang/String;
const/4 v2, 0
aput-object v0, v1, v2
const/16 v2, 101
invoke-virtual {p0, v1, v2}, Landroid/app/Activity;->requestPermissions([Ljava/lang/String;I)V
return-void
:permission_ok
const-string v0, "audio"
invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
move-result-object v0
check-cast v0, Landroid/media/AudioManager;
invoke-virtual {v0}, Landroid/media/AudioManager;->getAvailableCommunicationDevices()Ljava/util/List;
move-result-object v1
const/4 v2, 0
const/4 v3, 0
invoke-interface {v1}, Ljava/util/List;->size()I
move-result v4
:count_loop
if-ge v2, v4, :count_done
invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;
move-result-object v5
check-cast v5, Landroid/media/AudioDeviceInfo;
invoke-virtual {v5}, Landroid/media/AudioDeviceInfo;->getType()I
move-result v6
const/4 v7, 7
if-eq v6, v7, :count_add
const/16 v7, 26
if-ne v6, v7, :count_next
:count_add
add-int/lit8 v3, v3, 1
:count_next
add-int/lit8 v2, v2, 1
goto/16 :count_loop
:count_done
if-nez v3, :make_arrays
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->noBtHeadset(Landroid/content/Context;)Ljava/lang/String;
move-result-object v0
invoke-virtual {p0, v0}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
goto/16 :done
:make_arrays
new-array v8, v3, [Ljava/lang/CharSequence;
new-array v9, v3, [Landroid/media/AudioDeviceInfo;
const/4 v2, 0
const/4 v10, 0
:fill_loop
if-ge v2, v4, :show_dialog
invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;
move-result-object v5
check-cast v5, Landroid/media/AudioDeviceInfo;
invoke-virtual {v5}, Landroid/media/AudioDeviceInfo;->getType()I
move-result v6
const/4 v7, 7
if-eq v6, v7, :fill_add
const/16 v7, 26
if-ne v6, v7, :fill_next
:fill_add
aput-object v5, v9, v10
invoke-virtual {v5}, Landroid/media/AudioDeviceInfo;->getProductName()Ljava/lang/CharSequence;
move-result-object v6
invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
move-result-object v6
new-instance v7, Ljava/lang/StringBuilder;
invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V
invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->connectedSuffix(Landroid/content/Context;)Ljava/lang/String;
move-result-object v11
invoke-virtual {v7, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v7
aput-object v7, v8, v10
add-int/lit8 v10, v10, 1
:fill_next
add-int/lit8 v2, v2, 1
goto/16 :fill_loop
:show_dialog
new-instance v0, Landroid/app/AlertDialog$Builder;
invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->chooseBtHeadset(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
new-instance v1, Lapp/liveclearmic/HeadsetChoiceListener;
invoke-direct {v1, p0, v9}, Lapp/liveclearmic/HeadsetChoiceListener;-><init>(Lapp/liveclearmic/MainActivity;[Landroid/media/AudioDeviceInfo;)V
invoke-virtual {v0, v8, v1}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->cancelText(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
const/4 v2, 0
invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->readConnectedFailed(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
invoke-virtual {p0, v1}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method public associateSelectedHeadset(Landroid/media/AudioDeviceInfo;)V
.locals 8
:start
if-eqz p1, :done
invoke-virtual {p1}, Landroid/media/AudioDeviceInfo;->getProductName()Ljava/lang/CharSequence;
move-result-object v0
invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
move-result-object v1
invoke-virtual {p1}, Landroid/media/AudioDeviceInfo;->getAddress()Ljava/lang/String;
move-result-object v2
sget-boolean v3, Lapp/liveclearmic/ProbeService;->active:Z
if-eqz v3, :store
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->stopFilter()V
:store
invoke-static {p0}, Lapp/liveclearmic/HeadsetStore;->clear(Landroid/content/Context;)V
const/4 v4, -1
invoke-static {p0, v1, v2, v4}, Lapp/liveclearmic/HeadsetStore;->save(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)V
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->refreshPaired()V
new-instance v5, Ljava/lang/StringBuilder;
invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->selectedSuffix(Landroid/content/Context;)Ljava/lang/String;
move-result-object v6
invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
move-result-object v5
invoke-virtual {p0, v5}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
if-eqz v3, :start_now
new-instance v5, Lapp/liveclearmic/AutoStartRunnable;
invoke-direct {v5, p0}, Lapp/liveclearmic/AutoStartRunnable;-><init>(Landroid/content/Context;)V
iget-object v6, p0, Lapp/liveclearmic/MainActivity;->handler:Landroid/os/Handler;
const-wide/16 v0, 500
invoke-virtual {v6, v5, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
goto/16 :done
:start_now
invoke-virtual {p0}, Lapp/liveclearmic/MainActivity;->startFilter()V
:end
goto/16 :done
:error
move-exception v0
invoke-static {v0}, Lapp/liveclearmic/ProbeService;->failure(Ljava/lang/Throwable;)V
invoke-static {p0}, Lapp/liveclearmic/LanguageStore;->saveSelectedFailed(Landroid/content/Context;)Ljava/lang/String;
move-result-object v1
invoke-virtual {p0, v1}, Lapp/liveclearmic/MainActivity;->toast(Ljava/lang/String;)V
:done
return-void
.catch Ljava/lang/Throwable; {:start .. :end} :error
.end method

.method protected onPause()V
.locals 1
iget-object v0, p0, Lapp/liveclearmic/MainActivity;->handler:Landroid/os/Handler;
invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
invoke-super {p0}, Landroid/app/Activity;->onPause()V
return-void
.end method
