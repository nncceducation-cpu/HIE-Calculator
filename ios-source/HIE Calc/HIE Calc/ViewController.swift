//
//  ViewController.swift
//  HIE Calc
//
//  Created by Rohini Vivek on 2017-07-02.
//  Copyright © 2017 Rohini Vivek. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    private var webView: WKWebView!

    private var languageCode: String {
        let code = Locale.preferredLanguages.first?.lowercased() ?? "en"
        if code.hasPrefix("es") { return "es" }
        if code.hasPrefix("fr") { return "fr" }
        if code.hasPrefix("pt") { return "pt" }
        return "en"
    }

    private func t(_ en: String, _ es: String, _ fr: String, _ pt: String) -> String {
        switch languageCode {
        case "es": return es
        case "fr": return fr
        case "pt": return pt
        default: return en
        }
    }

   
    @IBOutlet var sixHoursInd: UISwitch!
    @IBOutlet var ApgarInd: UISwitch!
    @IBOutlet var BaseExcessInd: UISwitch!
    @IBOutlet var IPPVInd: UISwitch!
    @IBOutlet var CordPHInd: UISwitch!
    @IBOutlet var ConsciousnessInd: UISwitch!
    @IBOutlet var SpontaneousActivityInd: UISwitch!
    @IBOutlet var PostureInd: UISwitch!
    @IBOutlet var ToneInd: UISwitch!
    @IBOutlet var ReflexInd: UISwitch!
    
    @IBOutlet var PupilInd: UISwitch!
    @IBOutlet var BradyCardiaInd: UISwitch!
    @IBOutlet var ApneaInd: UISwitch!
    
    @IBOutlet var SeizureInd: UISwitch!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // The legacy storyboard is retained only so its existing outlet
        // connections continue to decode safely. The current calculator is
        // the shared, maintained web interface used by Android and the web.
        view.subviews.forEach { $0.removeFromSuperview() }

        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .default()
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let url = URL(string: "https://nncceducation-cpu.github.io/HIE-Calculator/?platform=ios&version=2.4")!
        webView.load(URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 30))
    }

    private func localizeInterface(in root: UIView) {
        let spanish: [String: String] = [
            "Is the Gestational age ≥ 36 weeks ": "¿La edad gestacional es ≥ 36 semanas?",
            "Is the baby ≤ 6 hours from birth": "¿El bebé tiene ≤ 6 horas de vida?",
            "  QUALIFYING CRITERIA": "  CRITERIOS DE ELEGIBILIDAD",
            "Apgar ≤ 5 @ 10 minutes ": "Apgar ≤ 5 a los 10 minutos",
            "Cord or first hour arterial gas base excess ≤ -16 mmol/L": "Exceso de base ≤ −16 mmol/L en gasometría arterial del cordón o de la primera hora",
            "   CRITERIA A": "   CRITERIO A",
            "IPPV ≥ 10 minutes": "VPP intermitente ≥ 10 minutos",
            "Cord or first hour arterial gas pH ≤ 7": "pH ≤ 7 en gasometría arterial del cordón o de la primera hora",
            " TO COOL OR NOT TO COOL": " ENFRIAR O NO ENFRIAR",
            "   CRITERIA B": "   CRITERIO B",
            "Decreased level of consciousness": "Disminución del nivel de conciencia",
            "Decreased or no spontaneous activity": "Actividad espontánea disminuida o ausente",
            "Abnormal posture": "Postura anormal",
            "Decreased Tone": "Tono disminuido",
            "Weakness in any primitive reflexes ( Moro or suck )": "Debilidad en cualquier reflejo primitivo (Moro o succión)",
            "Constricted or variable pupils": "Pupilas mióticas o arreactivas",
            "Bradycardia or variable heart rate": "Bradicardia o ritmo cardíaco variable",
            "Shallow breathing or apnea": "Respiración superficial o apnea",
            "Seizure": "Crisis epilépticas"
        ]
        let french: [String: String] = [
            "Is the Gestational age ≥ 36 weeks ": "L’âge gestationnel est-il ≥ 36 semaines?",
            "Is the baby ≤ 6 hours from birth": "Le nouveau-né a-t-il ≤ 6 heures de vie?",
            "  QUALIFYING CRITERIA": "  CRITÈRES D’ADMISSIBILITÉ",
            "Apgar ≤ 5 @ 10 minutes ": "Score d’Apgar ≤ 5 à 10 minutes",
            "Cord or first hour arterial gas base excess ≤ -16 mmol/L": "Déficit de bases ≥ 16 mmol/L au gaz du sang ombilical ou de la première heure",
            "   CRITERIA A": "   CRITÈRE A",
            "IPPV ≥ 10 minutes": "Ventilation assistée pendant ≥ 10 minutes",
            "Cord or first hour arterial gas pH ≤ 7": "pH ≤ 7,0 au gaz du sang ombilical ou de la première heure",
            " TO COOL OR NOT TO COOL": " REFROIDIR OU NE PAS REFROIDIR",
            "   CRITERIA B": "   CRITÈRE B",
            "Decreased level of consciousness": "Diminution du niveau de conscience",
            "Decreased or no spontaneous activity": "Activité spontanée diminuée ou absente",
            "Abnormal posture": "Posture anormale", "Decreased Tone": "Diminution du tonus",
            "Weakness in any primitive reflexes ( Moro or suck )": "Réflexes primitifs faibles (Moro ou succion)",
            "Constricted or variable pupils": "Pupilles contractées ou non réactives",
            "Bradycardia or variable heart rate": "Bradycardie ou fréquence cardiaque variable",
            "Shallow breathing or apnea": "Respiration superficielle ou apnée", "Seizure": "Convulsions"
        ]
        let portuguese: [String: String] = [
            "Is the Gestational age ≥ 36 weeks ": "A idade gestacional é ≥ 36 semanas?",
            "Is the baby ≤ 6 hours from birth": "O recém-nascido tem ≤ 6 horas de vida?",
            "  QUALIFYING CRITERIA": "  CRITÉRIOS DE TRIAGEM",
            "Apgar ≤ 5 @ 10 minutes ": "Apgar ≤ 5 aos 10 minutos",
            "Cord or first hour arterial gas base excess ≤ -16 mmol/L": "Déficit de bases ≥ 16 mmol/L na gasometria arterial do cordão ou da primeira hora",
            "   CRITERIA A": "   CRITÉRIO A", "IPPV ≥ 10 minutes": "Ventilação assistida por ≥ 10 minutos",
            "Cord or first hour arterial gas pH ≤ 7": "pH ≤ 7 na gasometria arterial do cordão ou da primeira hora",
            " TO COOL OR NOT TO COOL": " RESFRIAR OU NÃO RESFRIAR", "   CRITERIA B": "   CRITÉRIO B",
            "Decreased level of consciousness": "Nível de consciência diminuído",
            "Decreased or no spontaneous activity": "Atividade espontânea diminuída ou ausente",
            "Abnormal posture": "Postura anormal", "Decreased Tone": "Tônus diminuído",
            "Weakness in any primitive reflexes ( Moro or suck )": "Fraqueza em qualquer reflexo primitivo (Moro ou sucção)",
            "Constricted or variable pupils": "Pupilas mióticas ou arreativas",
            "Bradycardia or variable heart rate": "Bradicardia ou frequência cardíaca variável",
            "Shallow breathing or apnea": "Respiração superficial ou apneia", "Seizure": "Crises epilépticas"
        ]
        let translations = languageCode == "es" ? spanish : (languageCode == "fr" ? french : portuguese)
        if let label = root as? UILabel, let text = label.text, let translated = translations[text] {
            label.text = translated
        }
        if let button = root as? UIButton, button.title(for: .normal) == "Submit" {
            button.setTitle(t("Submit", "Calcular", "Calculer", "Calcular"), for: .normal)
        }
        for child in root.subviews { localizeInterface(in: child) }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mouseTouchDown(_ sender: Any) {
        if isYes(){
            displayYesMessage()
        }else{
            displayNoMessage()
        }
    }
    
    @IBAction func gestAge(_ sender: Any) {
        
    }
    
    // MARK: - Result colours (traffic light). Custom RGB for iOS 10.3 compatibility.
    let qualifyColor   = UIColor(red: 0.80, green: 0.0,  blue: 0.0,  alpha: 1.0) // red   = qualifies
    let borderlineColor = UIColor(red: 0.85, green: 0.55, blue: 0.0, alpha: 1.0) // amber = A met, not B
    let noQualifyColor = UIColor(red: 0.0,  green: 0.55, blue: 0.15, alpha: 1.0) // green = does not qualify

    // MARK: - Guidance statements

    var gaStatement: String { return t(
        "Therapeutic hypothermia is not recommended in infants born less than 35 weeks\u{2019} gestational age. There is limited evidence regarding the safety and effectiveness of therapeutic hypothermia for neonates born at 35 0/7 to 35 6/7 weeks\u{2019} gestation; it may be considered in discussion of potential risks and benefits with families.",
        "No se recomienda la hipotermia terapéutica en bebés nacidos con menos de 35 semanas de edad gestacional. La evidencia sobre su seguridad y eficacia en recién nacidos de 35 0/7 a 35 6/7 semanas de gestación es limitada; puede considerarse después de hablar con las familias sobre los posibles riesgos y beneficios.",
        "L’hypothermie thérapeutique n’est pas recommandée chez les nouveau-nés de moins de 35 semaines d’âge gestationnel. Les données entre 35 0/7 et 35 6/7 semaines sont limitées; elle peut être envisagée après discussion des risques et bénéfices avec la famille.",
        "A hipotermia terapêutica não é recomendada para recém-nascidos com menos de 35 semanas de idade gestacional. As evidências entre 35 0/7 e 35 6/7 semanas são limitadas; ela pode ser considerada após discussão dos riscos e benefícios com a família.") }

    var ageStatement: String { return t(
        "Initiation of hypothermia between 6 and 24 hours after birth, in infants who did not initially meet criteria or were unable to have therapeutic hypothermia initiated in the first 6 hours after birth, may be considered after discussion with the parent or guardian of possible benefit and associated risk.",
        "En bebés que inicialmente no cumplían los criterios o en quienes no fue posible iniciar la hipotermia terapéutica durante las primeras 6 horas de vida, puede considerarse iniciarla entre las 6 y las 24 horas después del nacimiento tras hablar con el padre, la madre o el tutor sobre los posibles beneficios y riesgos asociados.",
        "Chez les nouveau-nés qui ne satisfaisaient pas initialement aux critères ou chez qui l’hypothermie n’a pas pu être amorcée dans les 6 premières heures, un début entre 6 et 24 heures peut être envisagé après discussion des bénéfices et risques avec le parent ou tuteur.",
        "Em recém-nascidos que inicialmente não atendiam aos critérios ou nos quais não foi possível iniciar a hipotermia nas primeiras 6 horas, o início entre 6 e 24 horas pode ser considerado após discussão dos benefícios e riscos com os pais ou responsáveis.") }

    // MARK: - Criteria evaluation

    // Criteria A: at least one metabolic / resuscitation marker
    func metabolicMet() -> Bool {
        return ApgarInd.isOn || BaseExcessInd.isOn || IPPVInd.isOn || CordPHInd.isOn
    }

    // Criteria B: seizure, or more than two encephalopathy signs
    func encephalopathyMet() -> Bool {
        var i = 0
        if ConsciousnessInd.isOn {i += 1}
        if SpontaneousActivityInd.isOn {i += 1}
        if PostureInd.isOn {i += 1}
        if ToneInd.isOn {i += 1}
        if ReflexInd.isOn {i += 1}
        if PupilInd.isOn || BradyCardiaInd.isOn || ApneaInd.isOn {i += 1}
        return SeizureInd.isOn || i > 2
    }

    // Everything except the gestational-age and 6-hour gates
    func meetsCoreCriteria() -> Bool {
        return metabolicMet() && encephalopathyMet()
    }

    func  isYes() -> Bool{
        return gestAgeInd.isOn && sixHoursInd.isOn && meetsCoreCriteria()
    }

    
    @IBOutlet var gestAgeInd: UISwitch!
    
    func displayDisclaimer(){
        
        /*let txt = "Does not satisfy criteria for therapeutic hypothermia \n Hi "
        
        let alertController = UIAlertController(title: "Disclaimer", message:
            txt, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Agree", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)*/
 
        let txt = t(
            "Please read the following disclaimer before proceeding with use of the HIE calculator Mobile Application.\n\nThe purpose of this Application is to make cooling criteria more accessible and easy to use. It DOES NOT replace clinical judgement and assessment.\n\nThis calculator is based on the American Academy of Pediatrics (AAP) clinical report cited in the app.\n\nThe developer is not responsible for any decision made using this application. The Application is provided as-is with no representations or warranties of any kind.\n\nI agree to the above Terms of Use.",
            "Lea el siguiente aviso legal antes de utilizar la aplicación móvil Calculadora de EHI.\n\nEsta aplicación facilita el uso de los criterios de hipotermia terapéutica. NO sustituye el juicio ni la evaluación clínica.\n\nLa calculadora se basa en el informe clínico de la AAP citado en la aplicación.\n\nEl desarrollador no se responsabiliza de ninguna decisión tomada mediante esta aplicación. La aplicación se proporciona tal cual, sin garantías de ningún tipo.\n\nAcepto las condiciones de uso anteriores.",
            "Veuillez lire l’avis suivant avant d’utiliser l’application mobile Calculateur d’EHI.\n\nCette application facilite l’utilisation des critères d’hypothermie thérapeutique. Elle NE remplace PAS le jugement ni l’évaluation clinique.\n\nLe calculateur repose sur le rapport clinique de l’AAP cité dans l’application.\n\nLe développeur n’est responsable d’aucune décision prise à l’aide de cette application. L’application est fournie telle quelle, sans garantie.\n\nJ’accepte les conditions d’utilisation ci-dessus.",
            "Leia o aviso a seguir antes de utilizar o aplicativo móvel Calculadora de EHI.\n\nEste aplicativo facilita o uso dos critérios de hipotermia terapêutica. Ele NÃO substitui o julgamento nem a avaliação clínica.\n\nA calculadora baseia-se no relatório clínico da AAP citado no aplicativo.\n\nO desenvolvedor não se responsabiliza por decisões tomadas com este aplicativo. O aplicativo é fornecido no estado em que se encontra, sem garantias.\n\nAceito os termos de uso acima.")
        
        
        let alertController = UIAlertController(title: t("Disclaimer", "Aviso legal", "Avis de non-responsabilité", "Aviso legal"), message: txt, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: t("Agree", "Acepto", "J’accepte", "Aceito"), style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        let messageText = NSMutableAttributedString(
            string: txt,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)
            ]
        )
        
        alertController.setValue(messageText, forKey: "attributedMessage")
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    
    
    func displayNoMessage(){

        let gaOff = !gestAgeInd.isOn
        let ageOff = !sixHoursInd.isOn
        let aMet = metabolicMet()
        let bMet = encephalopathyMet()

        // Amber: Criteria A met but not Criteria B -> does not qualify, recommend serial exams.
        let borderline = aMet && !bMet

        var verdict: String
        var verdictColor: UIColor
        var txt = t("Does not satisfy criteria for therapeutic hypothermia.", "No cumple los criterios para recibir hipotermia terapéutica.", "Ne satisfait pas aux critères d’hypothermie thérapeutique.", "Não atende aos critérios para hipotermia terapêutica.")

        if borderline {
            verdict = t("  DOES NOT QUALIFY — REASSESS  ", "  NO CUMPLE LOS CRITERIOS — REEVALUAR  ", "  NON ADMISSIBLE — RÉÉVALUER  ", "  NÃO ATENDE AOS CRITÉRIOS — REAVALIAR  ")
            verdictColor = borderlineColor
            txt += t("\n\nCriteria A is met but Criteria B is not. Serial neurological examinations are recommended.", "\n\nSe cumple el criterio A, pero no el criterio B. Se recomiendan evaluaciones neurológicas seriadas.", "\n\nLe critère A est satisfait, mais pas le critère B. Des examens neurologiques sériés sont recommandés.", "\n\nO critério A foi atendido, mas o critério B não. Recomenda-se realizar avaliações neurológicas seriadas.")
        } else {
            verdict = t("  DOES NOT QUALIFY  ", "  NO CUMPLE LOS CRITERIOS  ", "  NON ADMISSIBLE  ", "  NÃO ATENDE AOS CRITÉRIOS  ")
            verdictColor = noQualifyColor
        }

        if gaOff {
            txt += t("\n\nThe infant does not meet the gestational age criterion (≥ 36 weeks).\n\n", "\n\nEl bebé no cumple el criterio de edad gestacional (≥ 36 semanas).\n\n", "\n\nLe nouveau-né ne satisfait pas au critère d’âge gestationnel (≥ 36 semaines).\n\n", "\n\nO recém-nascido não atende ao critério de idade gestacional (≥ 36 semanas).\n\n") + gaStatement
        }

        if ageOff {
            txt += t("\n\nThe infant is more than 6 hours from birth.\n\n", "\n\nEl bebé tiene más de 6 horas de vida.\n\n", "\n\nLe nouveau-né a plus de 6 heures de vie.\n\n", "\n\nO recém-nascido tem mais de 6 horas de vida.\n\n") + ageStatement
        }

        // Offer an override only when a gate (GA or > 6 hours) is the sole barrier,
        // i.e. Criteria A and B are both met. If A or B is not met, no override.
        presentResult(title: t("Result", "Resultado", "Résultat", "Resultado"), verdict: verdict, color: verdictColor,
                      message: txt, allowOverride: (gaOff || ageOff) && aMet && bMet)
    }

    func displayOverrideResult(){

        let gaOff = !gestAgeInd.isOn
        let ageOff = !sixHoursInd.isOn

        var reasons: [String] = []
        if gaOff { reasons.append(t("gestational age (< 36 weeks)", "edad gestacional (< 36 semanas)", "âge gestationnel (< 36 semaines)", "idade gestacional (< 36 semanas)")) }
        if ageOff { reasons.append(t("age (> 6 hours from birth)", "edad (> 6 horas de vida)", "âge (> 6 heures de vie)", "idade (> 6 horas de vida)")) }
        let reasonText = reasons.joined(separator: t(" and ", " y ", " et ", " e "))

        let aMet = metabolicMet()
        let bMet = encephalopathyMet()

        var verdict: String
        var verdictColor: UIColor
        var txt: String

        if aMet && bMet {
            verdict = t("  QUALIFIES (CRITERIA A + B)  ", "  CUMPLE LOS CRITERIOS (A + B)  ", "  ADMISSIBLE (CRITÈRES A + B)  ", "  ATENDE AOS CRITÉRIOS (A + B)  ")
            verdictColor = qualifyColor
            txt = t("Based on Criteria A + B, the infant satisfies the criteria for therapeutic hypothermia.", "Según los criterios A + B, el bebé cumple los criterios para recibir hipotermia terapéutica.", "Selon les critères A + B, le nouveau-né est admissible à l’hypothermie thérapeutique.", "Com base nos critérios A + B, o recém-nascido atende aos critérios para hipotermia terapêutica.")
        } else if aMet && !bMet {
            verdict = t("  DOES NOT QUALIFY — REASSESS  ", "  NO CUMPLE LOS CRITERIOS — REEVALUAR  ", "  NON ADMISSIBLE — RÉÉVALUER  ", "  NÃO ATENDE AOS CRITÉRIOS — REAVALIAR  ")
            verdictColor = borderlineColor
            txt = t("Criteria A is met but Criteria B is not; serial neurological examinations are recommended.", "Se cumple el criterio A, pero no el B; se recomiendan evaluaciones neurológicas seriadas.", "Le critère A est satisfait, mais pas le critère B; des examens neurologiques sériés sont recommandés.", "O critério A foi atendido, mas o critério B não; recomenda-se realizar avaliações neurológicas seriadas.")
        } else {
            verdict = t("  DOES NOT QUALIFY (CRITERIA A + B)  ", "  NO CUMPLE LOS CRITERIOS (A + B)  ", "  NON ADMISSIBLE (CRITÈRES A + B)  ", "  NÃO ATENDE AOS CRITÉRIOS (A + B)  ")
            verdictColor = noQualifyColor
            txt = t("Based on Criteria A + B, the infant does not satisfy the criteria for therapeutic hypothermia.", "Según los criterios A + B, el bebé no cumple los criterios para recibir hipotermia terapéutica.", "Selon les critères A + B, le nouveau-né n’est pas admissible à l’hypothermie thérapeutique.", "Com base nos critérios A + B, o recém-nascido não atende aos critérios para hipotermia terapêutica.")
        }

        txt += "\n\n" + t("Criteria A (metabolic / resuscitation): ", "Criterio A (metabólico/reanimación): ", "Critère A (métabolique/réanimation) : ", "Critério A (metabólico/ressuscitação): ")
            + (aMet ? t("met", "cumplido", "satisfait", "atendido") : t("not met", "no cumplido", "non satisfait", "não atendido"))
        txt += "\n" + t("Criteria B (encephalopathy): ", "Criterio B (encefalopatía): ", "Critère B (encéphalopathie) : ", "Critério B (encefalopatia): ")
            + (bMet ? t("met", "cumplido", "satisfait", "atendido") : t("not met", "no cumplido", "non satisfait", "não atendido"))

        txt += "\n\n" + t(
            "This override sets aside the \(reasonText) criterion. Use clinical judgement together with the guidance below:",
            "Esta anulación deja de lado el criterio de \(reasonText). Utilice el juicio clínico junto con la siguiente orientación:",
            "Cette dérogation écarte le critère \(reasonText). Utilisez votre jugement clinique avec les recommandations ci-dessous :",
            "Esta exceção desconsidera o critério de \(reasonText). Use o julgamento clínico em conjunto com as orientações abaixo:"
        )
        if gaOff { txt += "\n\n" + gaStatement }
        if ageOff { txt += "\n\n" + ageStatement }

        presentResult(title: t("Override", "Anulación de criterio", "Dérogation", "Critério desconsiderado"), verdict: verdict, color: verdictColor,
                      message: txt, allowOverride: false)
    }

    func displayYesMessage(){
        presentResult(title: t("Result", "Resultado", "Résultat", "Resultado"),
                      verdict: t("  QUALIFIES FOR THERAPEUTIC HYPOTHERMIA  ", "  CUMPLE LOS CRITERIOS PARA HIPOTERMIA TERAPÉUTICA  ", "  ADMISSIBLE À L’HYPOTHERMIE THÉRAPEUTIQUE  ", "  ATENDE AOS CRITÉRIOS PARA HIPOTERMIA TERAPÊUTICA  "),
                      color: qualifyColor,
                      message: t("Satisfies criteria for therapeutic hypothermia. Criteria A and B are met.", "Cumple los criterios para recibir hipotermia terapéutica. Se cumplen los criterios A y B.", "Satisfait aux critères d’hypothermie thérapeutique. Les critères A et B sont satisfaits.", "Atende aos critérios para hipotermia terapêutica. Os critérios A e B foram atendidos."),
                      allowOverride: false)
    }

    // Shared alert presenter. The verdict is shown as a centred, colour-filled
    // banner above the detail text, so the result stands out at a glance.
    func presentResult(title: String, verdict: String, color: UIColor, message txt: String, allowOverride: Bool){

        let full = verdict + "\n\n" + txt

        let alertController = UIAlertController(title: title, message:
            full, preferredStyle: UIAlertController.Style.alert)

        if allowOverride {
            alertController.addAction(UIAlertAction(title: t("Override", "Anular criterio", "Dérogation", "Desconsiderar critério"), style: UIAlertAction.Style.default) { (action) in
                self.displayOverrideResult()
            })
        }

        alertController.addAction(UIAlertAction(title: t("Dismiss", "Cerrar", "Fermer", "Fechar"), style: UIAlertAction.Style.cancel, handler: nil))

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left

        let messageText = NSMutableAttributedString(
            string: full,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)
            ]
        )

        // Highlight the verdict: white bold text on a solid red / amber / green band.
        let bannerStyle = NSMutableParagraphStyle()
        bannerStyle.alignment = NSTextAlignment.center
        bannerStyle.lineSpacing = 4.0

        let verdictRange = NSRange(location: 0, length: (verdict as NSString).length)
        messageText.addAttributes(
            [
                NSAttributedString.Key.backgroundColor: color,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0),
                NSAttributedString.Key.paragraphStyle: bannerStyle
            ],
            range: verdictRange
        )

        alertController.setValue(messageText, forKey: "attributedMessage")
        self.present(alertController, animated: true, completion: nil)
    }


}
