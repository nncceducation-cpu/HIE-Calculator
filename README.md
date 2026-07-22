# HIE Calculator (iOS) — v1.5

Native iOS app (Swift + UIKit storyboard) that applies therapeutic hypothermia (cooling)
eligibility criteria for neonatal hypoxic-ischemic encephalopathy.

Bundle ID: `com.HIE-Calc` · Version 1.5 · Deployment target iOS 10.3

## Clinical basis

Zanelli SA, Wusthoff CJ, Lucke AM, Kaufman DA; Committee on Fetus and Newborn; Section on
Neurology. *Therapeutic Hypothermia for Neonatal Hypoxic-Ischemic Encephalopathy: Clinical
Report.* Pediatrics. 2026;157(2):e2025073627. doi:10.1542/peds.2025-073627

## What changed in v1.5

- Gestational age threshold raised from **≥ 35** to **≥ 36 weeks**.
- Birth weight criterion (> 1800 g) **removed**.
- New qualifying criterion: **is the baby ≤ 6 hours from birth**.
- Non-qualifying results now state *why* and show the corresponding AAP guidance:
  - Gestational age not met → the < 35 weeks / 35 0/7–35 6/7 weeks statement.
  - More than 6 hours from birth → the 6–24 hour initiation statement.
- **Override** option: when Criteria A *and* B are both met and the only barrier is a gate
  (gestational age or > 6 hours), an Override button reports qualification based on
  Criteria A + B. No override is offered if A or B is not met.
- Traffic-light result banner:
  - **Red** — qualifies for therapeutic hypothermia
  - **Amber** — Criteria A met but not B; does not qualify, serial neurological
    examinations recommended to reassess for evolving encephalopathy
  - **Green** — does not qualify
- Disclaimer rewritten: liability rests with the developer (Alberta Health Services and
  University of Calgary references removed) and now cites the AAP clinical report.

## Eligibility logic

Qualifies = gestational age ≥ 36 weeks **AND** ≤ 6 hours from birth **AND** Criteria A **AND** Criteria B

- **Criteria A** (any one): Apgar ≤ 5 at 10 min · base excess ≤ −16 mmol/L · IPPV ≥ 10 min · pH ≤ 7
- **Criteria B**: seizure **OR** more than two of — decreased consciousness · decreased/no
  spontaneous activity · abnormal posture · decreased tone · weak primitive reflexes ·
  (constricted/variable pupils *or* bradycardia *or* apnea)

## Contents

- `HIE-Calc-v1.5-source.zip` — complete Xcode project. Unzip and open `HIE Calc.xcodeproj`.

Key files inside: `HIE Calc/ViewController.swift` (all criteria logic and result
presentation), `HIE Calc/Base.lproj/Main.storyboard` (UI), `HIE Calc/Info.plist` (version).

## Browser preview

An interactive web replica of this logic — for review only, not for clinical use:
https://nncceducation-cpu.github.io/HIETH/

## Disclaimer

This application does not replace clinical judgement and assessment. It is provided as-is,
with no warranty. The developer is not responsible for any decision made using it.
