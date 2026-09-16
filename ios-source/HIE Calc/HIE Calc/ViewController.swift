//
//  ViewController.swift
//  HIE Calc
//
//  Created by Rohini Vivek on 2017-07-02.
//  Copyright © 2017 Rohini Vivek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var isSpanish: Bool {
        return Locale.preferredLanguages.first?.lowercased().hasPrefix("es") == true
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
        displayDisclaimer()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isSpanish { localizeInterface(in: view) }
    }

    private func localizeInterface(in root: UIView) {
        let translations: [String: String] = [
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
            "Decreased Tone": "Tono muscular disminuido",
            "Weakness in any primitive reflexes ( Moro or suck )": "Debilidad de algún reflejo primitivo (Moro o succión)",
            "Constricted or variable pupils": "Pupilas contraídas o variables",
            "Bradycardia or variable heart rate": "Bradicardia o frecuencia cardíaca variable",
            "Shallow breathing or apnea": "Respiración superficial o apnea",
            "Seizure": "Convulsiones"
        ]
        if let label = root as? UILabel, let text = label.text, let translated = translations[text] {
            label.text = translated
        }
        if let button = root as? UIButton, button.title(for: .normal) == "Submit" {
            button.setTitle("Calcular", for: .normal)
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

    var gaStatement: String { return isSpanish
        ? "No se recomienda la hipotermia terapéutica en bebés nacidos con menos de 35 semanas de edad gestacional. La evidencia sobre su seguridad y eficacia en recién nacidos de 35 0/7 a 35 6/7 semanas de gestación es limitada; puede considerarse después de hablar con las familias sobre los posibles riesgos y beneficios."
        : "Therapeutic hypothermia is not recommended in infants born less than 35 weeks\u{2019} gestational age. There is limited evidence regarding the safety and effectiveness of therapeutic hypothermia for neonates born at 35 0/7 to 35 6/7 weeks\u{2019} gestation; it may be considered in discussion of potential risks and benefits with families." }

    var ageStatement: String { return isSpanish
        ? "En bebés que inicialmente no cumplían los criterios o en quienes no fue posible iniciar la hipotermia terapéutica durante las primeras 6 horas de vida, puede considerarse iniciarla entre las 6 y las 24 horas después del nacimiento tras hablar con el padre, la madre o el tutor sobre los posibles beneficios y riesgos asociados."
        : "Initiation of hypothermia between 6 and 24 hours after birth, in infants who did not initially meet criteria or were unable to have therapeutic hypothermia initiated in the first 6 hours after birth, may be considered after discussion with the parent or guardian of possible benefit and associated risk." }

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
 
        let txt = isSpanish
            ? "Lea el siguiente aviso legal antes de utilizar la aplicación móvil Calculadora de EHI.\n\nEl propósito de esta aplicación es hacer que los criterios de enfriamiento sean más accesibles y fáciles de usar. NO sustituye el juicio ni la evaluación clínica.\n\nEsta calculadora se basa en el informe clínico de la Academia Estadounidense de Pediatría (AAP): Zanelli SA, Wusthoff CJ, Lucke AM, Kaufman DA; Committee on Fetus and Newborn; Section on Neurology. Therapeutic Hypothermia for Neonatal Hypoxic-Ischemic Encephalopathy: Clinical Report. Pediatrics. 2026;157(2):e2025073627.\n\nAl utilizar esta aplicación, usted renuncia a cualquier reclamación, causa de acción o demanda contra el desarrollador relacionada con el uso de la aplicación y la información obtenida de ella.\n\nEl desarrollador no se responsabiliza de ninguna decisión tomada mediante esta aplicación.\n\nLa aplicación se proporciona tal cual, sin declaraciones ni garantías de ningún tipo. El desarrollador no garantiza que esté disponible en todo momento, que sea segura o esté libre de errores, ni que esté libre de componentes potencialmente dañinos.\n\nAcepto las condiciones de uso anteriores de la aplicación Calculadora de EHI para enfriamiento."
            : "Please read the following disclaimer before proceeding with use of the HIE calculator Mobile Application. \n\nThe purpose of this Application is to make cooling criteria more accessible and easy to use. It DOES NOT replace clinical judgement and assessment.\n\nThis calculator is based on the American Academy of Pediatrics (AAP) clinical report: Zanelli SA, Wusthoff CJ, Lucke AM, Kaufman DA; Committee on Fetus and Newborn; Section on Neurology. Therapeutic Hypothermia for Neonatal Hypoxic-Ischemic Encephalopathy: Clinical Report. Pediatrics. 2026;157(2):e2025073627.\n\nBy using this Application you hereby waive any claims, causes of action and demands, whether in tort or contract, against the developer (including its employees, directors and agents) in any way related to use of the Application and the information derived from it.\n\nThe developer is not responsible for any decision made using this application. \n\nThe Application is provided as-is with no representations or warranties of any kind. The developer does not warrant that all aspects of the Application will be available at any time, will be secure or error-free, or that the Application is free of potentially harmful components.\n\nI agree to the above Terms of Use for the HIE cooling calculator Application."
        
        
        let alertController = UIAlertController(title: isSpanish ? "Aviso legal" : "Disclaimer", message: txt, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: isSpanish ? "Acepto" : "Agree", style: .cancel) { (action) in
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
        var txt = isSpanish ? "No cumple los criterios para recibir hipotermia terapéutica." : "Does not satisfy criteria for therapeutic hypothermia."

        if borderline {
            verdict = isSpanish ? "  NO CUMPLE LOS CRITERIOS — REEVALUAR  " : "  DOES NOT QUALIFY \u{2014} REASSESS  "
            verdictColor = borderlineColor
            txt += isSpanish ? "\n\nSe cumple el criterio A, pero no el criterio B. Actualmente, el bebé no cumple los criterios para recibir hipotermia terapéutica. Se recomiendan evaluaciones neurológicas seriadas." : "\n\nCriteria A is met but Criteria B is not. The infant does not currently qualify for therapeutic hypothermia. Serial neurological examinations are recommended to reassess for evolving encephalopathy."
        } else {
            verdict = isSpanish ? "  NO CUMPLE LOS CRITERIOS  " : "  DOES NOT QUALIFY  "
            verdictColor = noQualifyColor
        }

        if gaOff {
            txt += (isSpanish ? "\n\nEl bebé no cumple el criterio de edad gestacional (≥ 36 semanas).\n\n" : "\n\nThe infant does not meet the gestational age criterion (\u{2265} 36 weeks).\n\n") + gaStatement
        }

        if ageOff {
            txt += (isSpanish ? "\n\nEl bebé tiene más de 6 horas de vida.\n\n" : "\n\nThe infant is more than 6 hours from birth.\n\n") + ageStatement
        }

        // Offer an override only when a gate (GA or > 6 hours) is the sole barrier,
        // i.e. Criteria A and B are both met. If A or B is not met, no override.
        presentResult(title: isSpanish ? "Resultado" : "Result", verdict: verdict, color: verdictColor,
                      message: txt, allowOverride: (gaOff || ageOff) && aMet && bMet)
    }

    func displayOverrideResult(){

        let gaOff = !gestAgeInd.isOn
        let ageOff = !sixHoursInd.isOn

        var reasons: [String] = []
        if gaOff { reasons.append(isSpanish ? "edad gestacional (< 36 semanas)" : "gestational age (< 36 weeks)") }
        if ageOff { reasons.append(isSpanish ? "edad (> 6 horas de vida)" : "age (> 6 hours from birth)") }
        let reasonText = reasons.joined(separator: isSpanish ? " y " : " and ")

        let aMet = metabolicMet()
        let bMet = encephalopathyMet()

        var verdict: String
        var verdictColor: UIColor
        var txt: String

        if aMet && bMet {
            verdict = isSpanish ? "  CUMPLE LOS CRITERIOS (A + B)  " : "  QUALIFIES (CRITERIA A + B)  "
            verdictColor = qualifyColor
            txt = isSpanish ? "Según los criterios A + B, el bebé CUMPLE los criterios para recibir hipotermia terapéutica." : "Based on Criteria A + B, the infant SATISFIES the criteria for therapeutic hypothermia."
        } else if aMet && !bMet {
            verdict = isSpanish ? "  NO CUMPLE LOS CRITERIOS — REEVALUAR  " : "  DOES NOT QUALIFY \u{2014} REASSESS  "
            verdictColor = borderlineColor
            txt = isSpanish ? "Según los criterios A + B, el bebé no cumple actualmente los criterios. Se cumple el criterio A, pero no el B; se recomiendan evaluaciones neurológicas seriadas." : "Based on Criteria A + B, the infant does not currently satisfy the criteria. Criteria A is met but Criteria B is not; serial neurological examinations are recommended to reassess for evolving encephalopathy."
        } else {
            verdict = isSpanish ? "  NO CUMPLE LOS CRITERIOS (A + B)  " : "  DOES NOT QUALIFY (CRITERIA A + B)  "
            verdictColor = noQualifyColor
            txt = isSpanish ? "Según los criterios A + B, el bebé NO cumple los criterios para recibir hipotermia terapéutica." : "Based on Criteria A + B, the infant DOES NOT satisfy the criteria for therapeutic hypothermia."
        }

        txt += isSpanish ? "\n\nCriterio A (metabólico/reanimación): " + (aMet ? "cumplido" : "no cumplido") : "\n\nCriteria A (metabolic / resuscitation): " + (aMet ? "met" : "not met")
        txt += isSpanish ? "\nCriterio B (encefalopatía): " + (bMet ? "cumplido" : "no cumplido") : "\nCriteria B (encephalopathy): " + (bMet ? "met" : "not met")

        txt += isSpanish ? "\n\nEsta anulación deja de lado el criterio de \(reasonText). Utilice el juicio clínico junto con la siguiente orientación:" : "\n\nThis override sets aside the \(reasonText) criterion. Use clinical judgement together with the guidance below:"
        if gaOff { txt += "\n\n" + gaStatement }
        if ageOff { txt += "\n\n" + ageStatement }

        presentResult(title: isSpanish ? "Anulación de criterio" : "Override", verdict: verdict, color: verdictColor,
                      message: txt, allowOverride: false)
    }

    func displayYesMessage(){
        presentResult(title: isSpanish ? "Resultado" : "Result",
                      verdict: isSpanish ? "  CUMPLE LOS CRITERIOS PARA HIPOTERMIA TERAPÉUTICA  " : "  QUALIFIES FOR THERAPEUTIC HYPOTHERMIA  ",
                      color: qualifyColor,
                      message: isSpanish ? "Cumple los criterios para recibir hipotermia terapéutica. Se cumplen los criterios de elegibilidad A y B." : "Satisfies criteria for therapeutic hypothermia. The qualifying criteria, Criteria A and Criteria B are all met.",
                      allowOverride: false)
    }

    // Shared alert presenter. The verdict is shown as a centred, colour-filled
    // banner above the detail text, so the result stands out at a glance.
    func presentResult(title: String, verdict: String, color: UIColor, message txt: String, allowOverride: Bool){

        let full = verdict + "\n\n" + txt

        let alertController = UIAlertController(title: title, message:
            full, preferredStyle: UIAlertController.Style.alert)

        if allowOverride {
            alertController.addAction(UIAlertAction(title: isSpanish ? "Anular criterio" : "Override", style: UIAlertAction.Style.default) { (action) in
                self.displayOverrideResult()
            })
        }

        alertController.addAction(UIAlertAction(title: isSpanish ? "Cerrar" : "Dismiss", style: UIAlertAction.Style.cancel, handler: nil))

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
