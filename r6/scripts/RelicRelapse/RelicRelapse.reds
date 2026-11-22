// Relic Relapse
//
// Far Cry 2's malaria, for the Relic. After Playing for Time the Relic relapses on an in-game
// clock that tightens as the main story moves on. A relapse starts with a warning (glitching,
// laboured breathing, no sprinting); take a dose of pseudoendotrizine during it and it passes.
// Miss it and the attack hits: heavy distortion, max health cut, slowed, cyberware offline.
// Pills are scarce: Vik sells a few a week from his ripperdoc screen, and finished gigs
// sometimes come with a dose. Everything is tunable on the Mod Settings page.
module RelicRelapse

import Codeware.UI.*

// --- Settings --------------------------------------------------------------------------------

public class RRSettings extends ScriptableSystem {
    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "General")
    @runtimeProperty("ModSettings.category.order", "1")
    @runtimeProperty("ModSettings.displayName", "Enable")
    @runtimeProperty("ModSettings.description", "Relic relapses after Playing for Time.")
    public let enabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Timing")
    @runtimeProperty("ModSettings.category.order", "2")
    @runtimeProperty("ModSettings.displayName", "Hours between relapses, early story")
    @runtimeProperty("ModSettings.description", "In-game hours between relapses right after Playing for Time. Randomised by 30% either way.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "4")
    @runtimeProperty("ModSettings.max", "168")
    public let earlyHours: Int32 = 40;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Timing")
    @runtimeProperty("ModSettings.displayName", "Hours between relapses, late story")
    @runtimeProperty("ModSettings.description", "In-game hours between relapses near the end of the main story. The interval shrinks from the early value to this one as main quests are completed.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "2")
    @runtimeProperty("ModSettings.max", "168")
    public let lateHours: Int32 = 10;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Timing")
    @runtimeProperty("ModSettings.displayName", "Warning (seconds)")
    @runtimeProperty("ModSettings.description", "Real seconds you get to take a dose before the attack hits.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "3")
    @runtimeProperty("ModSettings.max", "60")
    public let warningSeconds: Int32 = 12;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Timing")
    @runtimeProperty("ModSettings.displayName", "Attack (seconds)")
    @runtimeProperty("ModSettings.description", "Real seconds an attack lasts. A dose ends it early.")
    @runtimeProperty("ModSettings.step", "5")
    @runtimeProperty("ModSettings.min", "5")
    @runtimeProperty("ModSettings.max", "180")
    public let attackSeconds: Int32 = 35;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Attack")
    @runtimeProperty("ModSettings.category.order", "3")
    @runtimeProperty("ModSettings.displayName", "Max health lost during an attack (%)")
    @runtimeProperty("ModSettings.step", "5")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "80")
    public let healthPenalty: Int32 = 30;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Attack")
    @runtimeProperty("ModSettings.displayName", "Cyberware offline during an attack")
    @runtimeProperty("ModSettings.description", "Sandevistan, Berserk, Kerenzikov and other active cyberware can't be used while the Relic is acting up.")
    public let cyberwareOffline: Bool = true;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Pills")
    @runtimeProperty("ModSettings.category.order", "4")
    @runtimeProperty("ModSettings.displayName", "Protection from a dose taken early (hours)")
    @runtimeProperty("ModSettings.description", "In-game hours a dose taken outside a relapse keeps the Relic quiet. 0 is pure Far Cry 2: pills only help during a relapse, so one taken early is wasted.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "48")
    public let earlyDoseHours: Int32 = 4;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Pills")
    @runtimeProperty("ModSettings.displayName", "Vik's stock per week")
    @runtimeProperty("ModSettings.description", "Doses Vik can sell you every 7 in-game days.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "20")
    public let vikStock: Int32 = 3;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Pills")
    @runtimeProperty("ModSettings.displayName", "Vik's price per dose")
    @runtimeProperty("ModSettings.step", "250")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "20000")
    public let vikPrice: Int32 = 1500;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Pills")
    @runtimeProperty("ModSettings.displayName", "Chance of a dose after a gig (%)")
    @runtimeProperty("ModSettings.description", "When you finish a fixer's gig, the chance the payment comes with a dose.")
    @runtimeProperty("ModSettings.step", "5")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "100")
    public let gigDoseChance: Int32 = 35;

    @runtimeProperty("ModSettings.mod", "Relic Relapse")
    @runtimeProperty("ModSettings.category", "Pills")
    @runtimeProperty("ModSettings.displayName", "Doses Vik gives you to start")
    @runtimeProperty("ModSettings.description", "Given once, after Playing for Time.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "10")
    public let starterDoses: Int32 = 2;

    private func OnAttach() -> Void {
        ModSettings.RegisterListenerToClass(this);
    }

    private func OnDetach() -> Void {
        ModSettings.UnregisterListenerToClass(this);
    }

    public static func Get(game: GameInstance) -> ref<RRSettings> {
        return GameInstance.GetScriptableSystemsContainer(game).Get(n"RelicRelapse.RRSettings") as RRSettings;
    }
}

// --- Main system -------------------------------------------------------------------------------

public class RRTick extends DelayCallback {
    public let system: wref<RRSystem>;
    public func Call() -> Void {
        if IsDefined(this.system) {
            this.system.Tick();
        }
    }
}

public class RREpisodeStep extends DelayCallback {
    public let system: wref<RRSystem>;
    public let episode: Int32;
    public func Call() -> Void {
        if IsDefined(this.system) {
            this.system.EpisodeStep(this.episode);
        }
    }
}

public class RRSystem extends ScriptableSystem {
    private persistent let m_nextRelapse: Float;     // game timestamp (s); 0 = not scheduled
    private persistent let m_protectedUntil: Float;  // game timestamp (s)
    private persistent let m_vikStockLeft: Int32;
    private persistent let m_vikRestockAt: Float;
    private persistent let m_starterGiven: Bool;

    private let m_player: wref<PlayerPuppet>;
    private let m_state: Int32;  // 0 idle, 1 warning, 2 attack
    private let m_episode: Int32;  // bumped per relapse so stale delayed steps do nothing
    private let m_healthMod: ref<gameStatModifierData>;
    private let m_tickInterval: Float = 15.0;

    public static func Get(game: GameInstance) -> ref<RRSystem> {
        return GameInstance.GetScriptableSystemsContainer(game).Get(n"RelicRelapse.RRSystem") as RRSystem;
    }

    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void {
        this.m_player = request.owner as PlayerPuppet;
        if !IsDefined(this.m_player) {
            return;
        }
        // a relapse in progress doesn't survive a load: clear our effects
        this.m_state = 0;
        this.ClearEffects();
        GameInstance.GetJournalManager(this.GetGameInstance()).RegisterScriptCallback(this, n"OnJournalUpdate", gameJournalListenerType.State);
        this.ScheduleTick();
    }

    private final func OnPlayerDetach(request: ref<PlayerDetachRequest>) -> Void {
        GameInstance.GetJournalManager(this.GetGameInstance()).UnregisterScriptCallback(this, n"OnJournalUpdate");
        this.m_player = null;
    }

    private func Settings() -> ref<RRSettings> {
        return RRSettings.Get(this.GetGameInstance());
    }

    private func Now() -> Float {
        return GameInstance.GetTimeSystem(this.GetGameInstance()).GetGameTimeStamp();
    }

    private func ScheduleTick() -> Void {
        let cb = new RRTick();
        cb.system = this;
        GameInstance.GetDelaySystem(this.GetGameInstance()).DelayCallback(cb, this.m_tickInterval, false);
    }

    private func Active() -> Bool {
        let s = this.Settings();
        let enabled = !IsDefined(s) || s.enabled;
        return enabled && IsDefined(this.m_player)
            && GameInstance.GetQuestsSystem(this.GetGameInstance()).GetFact(n"q101_done") > 0;
    }

    // --- schedule ---------------------------------------------------------------------------

    public func Tick() -> Void {
        this.ScheduleTick();
        if !this.Active() || this.m_state != 0 {
            return;
        }
        this.GiveStarterDoses();
        let now = this.Now();
        if this.m_nextRelapse <= 0.0 {
            this.ScheduleRelapse(now);
            return;
        }
        if now < this.m_nextRelapse {
            return;
        }
        if now < this.m_protectedUntil {
            this.ScheduleRelapse(this.m_protectedUntil);
            return;
        }
        if this.CanRelapseNow() {
            this.StartWarning();
        }
        // otherwise it is overdue and hits at the next safe moment
    }

    private func ScheduleRelapse(from: Float) -> Void {
        let s = this.Settings();
        let early = IsDefined(s) ? Cast<Float>(s.earlyHours) : 40.0;
        let late = IsDefined(s) ? Cast<Float>(s.lateHours) : 10.0;
        let progress = ClampF(Cast<Float>(this.MainQuestsDone()) / 20.0, 0.0, 1.0);
        let hours = LerpF(progress, early, late) * RandRangeF(0.7, 1.3);
        this.m_nextRelapse = from + hours * 3600.0;
    }

    private func MainQuestsDone() -> Int32 {
        let journal = GameInstance.GetJournalManager(this.GetGameInstance());
        let context: JournalRequestContext;
        context.stateFilter.succeeded = true;
        let quests: array<wref<JournalEntry>>;
        journal.GetQuests(context, quests);
        let count = 0;
        for entry in quests {
            if Equals(journal.GetQuestType(entry), gameJournalQuestType.MainQuest) {
                count += 1;
            }
        }
        return count;
    }

    // No relapses in cutscenes, dialogue, vehicles, braindances, as Johnny, or while dying.
    private func CanRelapseNow() -> Bool {
        let p = this.m_player;
        if !IsDefined(p) || p.IsDead() || p.IsReplacer() || IsDefined(p.GetMountedVehicle()) {
            return false;
        }
        let psm = p.GetPlayerStateMachineBlackboard();
        if psm.GetInt(GetAllBlackboardDefs().PlayerStateMachine.SceneTier) > 2 {
            return false;
        }
        if StatusEffectSystem.ObjectHasStatusEffect(p, t"GameplayRestriction.PhoneCall") {
            return false;
        }
        return true;
    }

    // --- relapse ------------------------------------------------------------------------------

    private func StartWarning() -> Void {
        this.m_state = 1;
        this.m_episode += 1;
        StatusEffectHelper.ApplyStatusEffect(this.m_player, t"RelicRelapse.WarningFX");
        StatusEffectHelper.ApplyStatusEffect(this.m_player, t"RelicRelapse.Warning");
        let doses = this.DosesHeld();
        let text = doses > 0
            ? GetLocalizedTextByKey(n"RelicRelapse-Msg-Warning")
            : GetLocalizedTextByKey(n"RelicRelapse-Msg-WarningNoPills");
        this.Message(text);
        let s = this.Settings();
        this.Step(IsDefined(s) ? Cast<Float>(s.warningSeconds) : 12.0);
    }

    private func StartAttack() -> Void {
        this.m_state = 2;
        StatusEffectHelper.RemoveStatusEffect(this.m_player, t"RelicRelapse.WarningFX");
        StatusEffectHelper.RemoveStatusEffect(this.m_player, t"RelicRelapse.Warning");
        StatusEffectHelper.ApplyStatusEffect(this.m_player, t"RelicRelapse.AttackFX");
        StatusEffectHelper.ApplyStatusEffect(this.m_player, t"RelicRelapse.Attack");
        let s = this.Settings();
        if !IsDefined(s) || s.cyberwareOffline {
            StatusEffectHelper.ApplyStatusEffect(this.m_player, t"RelicRelapse.NoCyberware");
        }
        let penalty = IsDefined(s) ? s.healthPenalty : 30;
        if penalty > 0 {
            this.m_healthMod = RPGManager.CreateStatModifier(gamedataStatType.Health, gameStatModifierType.Multiplier, 1.0 - Cast<Float>(penalty) / 100.0);
            GameInstance.GetStatsSystem(this.GetGameInstance()).AddModifier(Cast<StatsObjectID>(this.m_player.GetEntityID()), this.m_healthMod);
        }
        this.Message(GetLocalizedTextByKey(n"RelicRelapse-Msg-Attack"));
        this.Step(IsDefined(s) ? Cast<Float>(s.attackSeconds) : 35.0);
    }

    private func Step(seconds: Float) -> Void {
        let cb = new RREpisodeStep();
        cb.system = this;
        cb.episode = this.m_episode;
        GameInstance.GetDelaySystem(this.GetGameInstance()).DelayCallback(cb, seconds, false);
    }

    public func EpisodeStep(episode: Int32) -> Void {
        if episode != this.m_episode {
            return;
        }
        if this.m_state == 1 {
            this.StartAttack();
        } else if this.m_state == 2 {
            this.EndRelapse(false);
        }
    }

    private func EndRelapse(dosed: Bool) -> Void {
        this.m_state = 0;
        this.m_episode += 1;
        this.ClearEffects();
        this.ScheduleRelapse(this.Now());
        this.Message(GetLocalizedTextByKey(dosed ? n"RelicRelapse-Msg-Dosed" : n"RelicRelapse-Msg-Passed"));
    }

    private func ClearEffects() -> Void {
        let p = this.m_player;
        if !IsDefined(p) {
            return;
        }
        StatusEffectHelper.RemoveStatusEffect(p, t"RelicRelapse.WarningFX");
        StatusEffectHelper.RemoveStatusEffect(p, t"RelicRelapse.Warning");
        StatusEffectHelper.RemoveStatusEffect(p, t"RelicRelapse.AttackFX");
        StatusEffectHelper.RemoveStatusEffect(p, t"RelicRelapse.Attack");
        StatusEffectHelper.RemoveStatusEffect(p, t"RelicRelapse.NoCyberware");
        if IsDefined(this.m_healthMod) {
            GameInstance.GetStatsSystem(this.GetGameInstance()).RemoveModifier(Cast<StatsObjectID>(p.GetEntityID()), this.m_healthMod);
            this.m_healthMod = null;
        }
        if this.Now() >= this.m_protectedUntil {
            StatusEffectHelper.RemoveStatusEffect(p, t"RelicRelapse.Protected");
        }
    }

    // --- pills ---------------------------------------------------------------------------------

    public func OnDoseTaken() -> Void {
        if this.m_state != 0 {
            this.EndRelapse(true);
            return;
        }
        let s = this.Settings();
        let hours = IsDefined(s) ? s.earlyDoseHours : 4;
        if hours <= 0 {
            this.Message(GetLocalizedTextByKey(n"RelicRelapse-Msg-Wasted"));
            return;
        }
        this.m_protectedUntil = MaxF(this.m_protectedUntil, this.Now()) + Cast<Float>(hours) * 3600.0;
        StatusEffectHelper.ApplyStatusEffect(this.m_player, t"RelicRelapse.Protected");
        this.Message(GetLocalizedTextByKey(n"RelicRelapse-Msg-Protected"));
    }

    public func DosesHeld() -> Int32 {
        if !IsDefined(this.m_player) {
            return 0;
        }
        return GameInstance.GetTransactionSystem(this.GetGameInstance()).GetItemQuantity(this.m_player, ItemID.FromTDBID(t"RelicRelapse.Pseudoendotrizine"));
    }

    private func GiveDoses(n: Int32) -> Void {
        if n > 0 && IsDefined(this.m_player) {
            GameInstance.GetTransactionSystem(this.GetGameInstance()).GiveItemByTDBID(this.m_player, t"RelicRelapse.Pseudoendotrizine", n);
        }
    }

    private func GiveStarterDoses() -> Void {
        if this.m_starterGiven {
            return;
        }
        this.m_starterGiven = true;
        let s = this.Settings();
        let n = IsDefined(s) ? s.starterDoses : 2;
        if n > 0 {
            this.GiveDoses(n);
            this.Message(GetLocalizedTextByKey(n"RelicRelapse-Msg-Starter"));
        }
    }

    protected cb func OnJournalUpdate(hash: Uint32, className: CName, notifyOption: JournalNotifyOption, changeType: JournalChangeType) -> Bool {
        if !Equals(className, n"gameJournalQuest") || !this.Active() {
            return false;
        }
        let journal = GameInstance.GetJournalManager(this.GetGameInstance());
        let entry = journal.GetEntry(hash);
        if !IsDefined(entry) || NotEquals(journal.GetEntryState(entry), gameJournalEntryState.Succeeded) {
            return false;
        }
        if Equals(journal.GetQuestType(entry), gameJournalQuestType.Contract) {
            let s = this.Settings();
            let chance = IsDefined(s) ? s.gigDoseChance : 35;
            if RandRange(0, 100) < chance {
                this.GiveDoses(1);
                this.Message(GetLocalizedTextByKey(n"RelicRelapse-Msg-GigDose"));
            }
        }
        return true;
    }

    // --- Vik ------------------------------------------------------------------------------------

    public func VikStockLeft() -> Int32 {
        let now = this.Now();
        if now >= this.m_vikRestockAt {
            let s = this.Settings();
            this.m_vikStockLeft = IsDefined(s) ? s.vikStock : 3;
            this.m_vikRestockAt = now + 7.0 * 24.0 * 3600.0;
        }
        return this.m_vikStockLeft;
    }

    public func VikPrice() -> Int32 {
        let s = this.Settings();
        return IsDefined(s) ? s.vikPrice : 1500;
    }

    public func BuyFromVik() -> Bool {
        if this.VikStockLeft() <= 0 {
            return false;
        }
        let ts = GameInstance.GetTransactionSystem(this.GetGameInstance());
        let price = this.VikPrice();
        if ts.GetItemQuantity(this.m_player, MarketSystem.Money()) < price {
            return false;
        }
        ts.RemoveItem(this.m_player, MarketSystem.Money(), price);
        this.m_vikStockLeft -= 1;
        this.GiveDoses(1);
        return true;
    }

    // --- messages ---------------------------------------------------------------------------------

    private func Message(text: String) -> Void {
        let msg: SimpleScreenMessage;
        msg.isShown = true;
        msg.duration = 5.0;
        msg.message = text;
        msg.type = SimpleMessageType.Relic;
        let def = GetAllBlackboardDefs().UI_Notifications;
        GameInstance.GetBlackboardSystem(this.GetGameInstance()).Get(def).SetVariant(def.WarningMessage, ToVariant(msg), true);
    }
}

// --- Taking a dose (same hook Dark Future uses for consumables) -----------------------------

public func RRCheckDose(gi: GameInstance, itemData: wref<gameItemData>, actionID: TweakDBID) -> Void {
    if !IsDefined(itemData) {
        return;
    }
    let action = TweakDBInterface.GetObjectActionRecord(actionID);
    if !IsDefined(action) || NotEquals(action.ActionName(), n"Consume") {
        return;
    }
    if itemData.HasTag(n"RelicRelapseDose") {
        RRSystem.Get(gi).OnDoseTaken();
    }
}

@wrapMethod(ItemActionsHelper)
public final static func ProcessItemAction(gi: GameInstance, executor: wref<GameObject>, itemData: wref<gameItemData>, actionID: TweakDBID, fromInventory: Bool) -> Bool {
    let used = wrappedMethod(gi, executor, itemData, actionID, fromInventory);
    if used {
        RRCheckDose(gi, itemData, actionID);
    }
    return used;
}

@wrapMethod(ItemActionsHelper)
public final static func ProcessItemAction(gi: GameInstance, executor: wref<GameObject>, itemData: wref<gameItemData>, actionID: TweakDBID, fromInventory: Bool, quantity: Int32) -> Bool {
    let used = wrappedMethod(gi, executor, itemData, actionID, fromInventory, quantity);
    if used {
        RRCheckDose(gi, itemData, actionID);
    }
    return used;
}

// --- Vik's ripperdoc screen: buy doses ------------------------------------------------------

public class RRVikPanel {
    private let m_owner: wref<RipperDocGameController>;
    private let m_button: ref<SimpleButton>;

    public static func Create(owner: ref<RipperDocGameController>) -> ref<RRVikPanel> {
        let self = new RRVikPanel();
        self.m_owner = owner;
        let button = SimpleButton.Create();
        button.SetWidth(640.0);
        let root = button.GetRootWidget();
        root.SetAnchor(inkEAnchor.BottomRight);
        root.SetAnchorPoint(Vector2(1.0, 1.0));
        root.SetMargin(inkMargin(0.0, 0.0, 560.0, 290.0));
        button.Reparent(owner.GetRootCompoundWidget());
        button.RegisterToCallback(n"OnBtnClick", self, n"OnBuyClick");
        self.m_button = button;
        self.Refresh();
        return self;
    }

    private func System() -> ref<RRSystem> {
        return RRSystem.Get(this.m_owner.GetPlayerControlledObject().GetGame());
    }

    public func Refresh() -> Void {
        let sys = this.System();
        let left = sys.VikStockLeft();
        this.m_button.SetText(s"PSEUDOENDOTRIZINE  €$\(sys.VikPrice())  (\(left) LEFT THIS WEEK, \(sys.DosesHeld()) HELD)");
        this.m_button.SetDisabled(left <= 0);
    }

    protected cb func OnBuyClick(widget: wref<inkWidget>) -> Bool {
        if !this.System().BuyFromVik() {
            let notification = new UIMenuNotificationEvent();
            notification.m_notificationType = UIMenuNotificationType.VNotEnoughMoney;
            this.m_owner.QueueEvent(notification);
            return false;
        }
        this.m_owner.RRUpdateMoney();
        this.Refresh();
        return true;
    }
}

@addField(RipperDocGameController)
private let m_rrVikPanel: ref<RRVikPanel>;

@wrapMethod(RipperDocGameController)
protected cb func OnInitialize() -> Bool {
    let result = wrappedMethod();
    let game = this.GetPlayerControlledObject().GetGame();
    let settings = RRSettings.Get(game);
    let enabled = !IsDefined(settings) || settings.enabled;
    if enabled && Equals(this.m_screen, CyberwareScreenType.Ripperdoc)
        && this.m_VendorDataManager.GetVendorID() == t"Vendors.wat_lch_ripperdoc_01"
        && GameInstance.GetQuestsSystem(game).GetFact(n"q101_done") > 0 {
        this.m_rrVikPanel = RRVikPanel.Create(this);
    }
    return result;
}

@addMethod(RipperDocGameController)
public func RRUpdateMoney() -> Void {
    let def = GetAllBlackboardDefs().UI_Vendor;
    let bb = GameInstance.GetBlackboardSystem(this.GetPlayerControlledObject().GetGame()).Get(def);
    bb.SignalVariant(def.VendorData);
}
