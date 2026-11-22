module RelicRelapse.Localization
import Codeware.Localization.*

public class RRLocalizationProvider extends ModLocalizationProvider {
    public func GetPackage(language: CName) -> ref<ModLocalizationPackage> {
        switch language {
            case n"en-us": return new RREnglish();
            default: return null;
        }
    }

    public func GetFallback() -> CName {
        return n"en-us";
    }
}

public class RREnglish extends ModLocalizationPackage {
    protected func DefineTexts() -> Void {
        this.Text("RelicRelapse-Item-Name", "Pseudoendotrizine");
        this.Text("RelicRelapse-Item-Desc", "Vik's blue pills. They won't fix the Relic, but a dose taken when it starts acting up stops the relapse in its tracks.");

        this.Text("RelicRelapse-Effect-Warning", "Relic Relapse");
        this.Text("RelicRelapse-Effect-Warning-Desc", "The Relic is acting up. Take pseudoendotrizine now, or it gets worse.");
        this.Text("RelicRelapse-Effect-Attack", "Relic Malfunction");
        this.Text("RelicRelapse-Effect-Attack-Desc", "Max health reduced, slowed, no sprinting or dodging, cyberware offline. Pseudoendotrizine ends it.");
        this.Text("RelicRelapse-Effect-Protected", "Pseudoendotrizine");
        this.Text("RelicRelapse-Effect-Protected-Desc", "The Relic is quiet for now.");

        this.Text("RelicRelapse-Msg-Warning", "RELIC INSTABILITY. Take pseudoendotrizine.");
        this.Text("RelicRelapse-Msg-WarningNoPills", "RELIC INSTABILITY. No pills left.");
        this.Text("RelicRelapse-Msg-Attack", "RELIC MALFUNCTION");
        this.Text("RelicRelapse-Msg-Dosed", "The pills kick in. The Relic settles.");
        this.Text("RelicRelapse-Msg-Passed", "The episode passes.");
        this.Text("RelicRelapse-Msg-Protected", "Pseudoendotrizine taken. The Relic should stay quiet for a while.");
        this.Text("RelicRelapse-Msg-Wasted", "Pseudoendotrizine taken. Nothing to suppress right now.");
        this.Text("RelicRelapse-Msg-Starter", "Vik slipped some pseudoendotrizine into your pocket.");
        this.Text("RelicRelapse-Msg-GigDose", "The fixer's payment came with a dose of pseudoendotrizine.");
    }
}
