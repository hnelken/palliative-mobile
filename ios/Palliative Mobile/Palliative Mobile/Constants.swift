//
//  Constants.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 2/21/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import Foundation

// GLOBAL OBJECTS
let web = WebInterface()
let db = DBInterface()

// PAGE ID CONSTANTS
let kRapidPCPageID = 2
let kCareForFrailPageID = 53
let kDeathResusPageID = 390
let kCommonSymptomsPageID = 169
let kSeattlePageID = 19
let kNewYorkPageID = 20
let kKarnofskyPageID = 79
let kAustrailiaPageID = 29
let kPrognosticPageID = 30
let kPerformancePageID = 31
let kECOGPageID = 36
let kSAAGPageID = 305
let kTrajectoryPageID = 67

let specialPages = [ 19, 20, 79, 29, 30, 31, 36, 67]

// SEGUE IDENTIFIERS
let kSeattleSegueID = "toSeattle"
let kNewYorkSegueID = "toNewYork"
let kKarnofskySegueID = "toKarnofsky"
let kAustraliaSegueID = "toAustralia"
let kPrognosticSegueID = "toPrognostic"
let kPerformanceSegueID = "toPerformance"
let kTrajectorySegueID = "toTrajectory"
let kECOGSegueID = "toECOG"
let kSAAGSegueID = "toSAAG"

let kQuizSegueID = "toQuiz"
let kHomeSegueID = "toHome"
let kWikiSegueID = "toWiki"
let kImageSegueID = "toImage"
let kSurveySegueID = "toSurvey"
let kAboutSegueID = "toAboutTeam"
let kRapidPCSegueID = "toRapidPC"
let kUnstableSegueID = "toUnstable"
let kBookmarkSegueID = "toBookmarks"
let kFirstTimeSegueID = "toFirstTime"
let kSkipSurveySegueID = "skipSurvey"
let kArticleSegueID = "toArticleDisplay"
let kFinishSurveySegueID = "finishSurvey"
let kShowSearchSegueID = "showSearchResults"
let kShowBookmarkSegueID = "displayBookmark"
let kShowSearchResultSegueID = "displaySearchResult"

// CELL IDENTIFIERS
let kHomeCellID = "homeCell"
let kPalliativePerformanceCellID = "palliativePerformanceCell"
let kKarnofskyCellID = "karnofskyCell"
let kPalliativePrognosticIndexCellID = "PalliativePrognosticIndexTableCell"
let kActivityCellID = "activityCell"
let kSelfCareCellID = "selfCareCell"
let kIntakeCellID = "inatkeCell"
let kConsciousCellID = "consciousCell"
let kOpioidCellID = "opioidCalcCell"
let kBookmarkCellID = "bookmarkCell"
let kArticleLinkCellID = "articleLinkCell"
let kSearchCellID = "searchCell"
let kBranchCellID = "branchCell"

// STORYBOARD IDS
let kPageContentControllerID = "PageContentController"
let kPageViewControllerID = "PageViewController"
let kFirstTimePageID = "FirstTimePage"
let kOptOutPageID = "OptOutPage"

// SERVER URL CONSTANTS
let kServerURL = "http://palliative-serv.herokuapp.com/"
let kPushPageUsageRoute = "analytics/retrieve.php"
let kUpdatePagesRoute = "infopages/getchanges.php"

// WEB INTERFACE KEY CONSTANTS
let kCredentialsKey = "credentials"
let kPageHitsKey = "page_hits"
let kVersionParamKey = "v"

// DATABASE CONSTANTS
let kBaseDBVersion = 0
let kDBName = "master_local.db"
let kLinkNameIndex = 0
let kLinkIDIndex = 1
let kContentTitleIndex = 0
let kContentTextIndex = 1
let kContentDetailIndex = 2
let kPageParentIDKey = "parentID"
let kPageContentKey = "content"
let kPageLinksKey = "links"
let kPageBookmarkedKey = "bookmarked"
let kBookmarksTableName = "bookmarks"
let kPagesTableName = "pages"

var dbPath: String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let docsPath = paths[0]
    let dbPath = docsPath.NS.stringByAppendingPathComponent(kDBName)
    return dbPath
}


public extension String {
    var NS: NSString { return (self as NSString) }
}

// Recognizes a special page ID and performs the corresponding segue
func getSpecialPageSegue(dstID: Int) -> String? {
    let segue: String?
    
    switch (dstID) {
    case kSeattlePageID:
        segue = kSeattleSegueID
    case kNewYorkPageID:
        segue = kNewYorkSegueID
    case kKarnofskyPageID:
        segue = kKarnofskySegueID
    case kAustrailiaPageID:
        segue = kAustraliaSegueID
    case kPrognosticPageID:
        segue = kPrognosticSegueID
    case kPerformancePageID:
        segue = kPerformanceSegueID
    case kECOGPageID:
        segue = kECOGSegueID
//    case kSAAGPageID:
//        segue = kSAAGSegueID
    case kTrajectoryPageID:
        segue = kTrajectorySegueID
    default:
        segue = nil
        print("Unidentified special page ID")
    }
    
    return segue
}

// SURVEY CHOICES
let settings = [
"Community hospital with academic affiliation",
"Large academic center",
"Rural community hospital",
"Stroke center",
"Cardiac center",
"Trauma center",
"Pediatric emergency center",
"Geriatric emergency center"
]

let specialties = [
"Allergy and Immunology",
"Anesthesiology",
"Anesthesiology -\n  Critical Care Medicine",
"Anesthesiology -\n  Hospice and Palliative Medicine",
"Anesthesiology -\n  Pain Medicine",
"Anesthesiology -\n  Pediatric Anesthesiology",
"Anesthesiology -\n  Sleep Medicine",
"Colon and Rectal Surgery",
"Dermatology",
"Dermatology -\n  Dermatopathology",
"Dermatology -\n  Pediatric Dermatology",
"Emergency Medicine",
"Emergency Medicine -\n  Anesthesiology",
"Emergency Medicine -\n  Critical Care Medicine",
"Emergency Medicine -\n  Emergency Medical Services",
"Emergency Medicine -\n  Hospice and Palliative Medicine",
"Emergency Medicine -\n  Internal Medicine-Critical Care Medicine",
"Emergency Medicine -\n  Medical Toxicology",
"Emergency Medicine -\n  Pain Medicine",
"Emergency Medicine -\n  Pediatric Emergency Medicine",
"Emergency Medicine -\n  Sports Medicine",
"Emergency Medicine -\n  Undersea and Hyperbaric Medicine",
"Family Medicine",
"Family Medicine -\n  Adolescent Medicine",
"Family Medicine -\n  Geriatric Medicine",
"Family Medicine -\n  Hospice and Palliative Medicine",
"Family Medicine -\n  Pain Medicine",
"Family Medicine -\n  Sleep Medicine",
"Family Medicine -\n  Sports Medicine",
"Internal Medicine",
"Internal Medicine -\n  Adolescent Medicine",
"Internal Medicine -\n  Adult Congenital Heart Disease",
"Internal Medicine -\n  Advanced Heart Failure and Transplant Cardiology",
"Internal Medicine -\n  Cardiovascular Disease",
"Internal Medicine -\n  Clinical Cardiac Electrophysiology",
"Internal Medicine -\n  Critical Care Medicine",
"Internal Medicine -\n  Endocrinology, Diabetes and Metabolism",
"Internal Medicine -\n  Gastroenterology",
"Internal Medicine -\n  Geriatric Medicine",
"Internal Medicine -\n  Hematology",
"Internal Medicine -\n  Hospice and Palliative Medicine",
"Internal Medicine -\n  Infectious Disease",
"Internal Medicine -\n  Interventional Cardiology",
"Internal Medicine -\n  Medical Oncology",
"Internal Medicine -\n  Nephrology",
"Internal Medicine -\n  Pulmonary Disease",
"Internal Medicine -\n  Rheumatology",
"Internal Medicine -\n  Sleep Medicine",
"Internal Medicine -\n  Sports Medicine",
"Internal Medicine -\n  Transplant Hepatology",
"Medical Genetics and Genomics",
"Medical Genetics and Genomics -\n  Medical Biochemical Genetics",
"Medical Genetics and Genomics -\n  Molecular Genetic Pathology",
"Neurological Surgery",
"Neurology",
"Nuclear Medicine",
"Obstetrics and Gynecology",
"Obstetrics and Gynecology -\n  Critical Care Medicine",
"Obstetrics and Gynecology -\n  Female Pelvic Medicine and",
"Obstetrics and Gynecology -\n  Reconstructive Surgery",
"Obstetrics and Gynecology -\n  Gynecologic Oncology",
"Obstetrics and Gynecology -\n  Hospice and Palliative Medicine",
"Obstetrics and Gynecology -\n  Maternal and Fetal Medicine",
"Obstetrics and Gynecology -\n  Reproductive Endocrinology/Infertility",
"Ophthalmology",
"Orthopaedic Surgery",
"Orthopaedic Surgery -\n  Orthopaedic Sports Medicine",
"Orthopaedic Surgery -\n  Surgery of the Hand",
"Otolaryngology",
"Otolaryngology -\n  Neurotology",
"Otolaryngology -\n  Pediatric Otolaryngology",
"Otolaryngology -\n  Plastic Surgery Within the Head and Neck",
"Otolaryngology -\n  Sleep Medicine",
"Pathology",
"Pathology -\n  Blood Banking/Transfusion Medicine",
"Pathology -\n  Clinical Informatics",
"Pathology -\n  Cytopathology",
"Pathology -\n  Dermatopathology",
"Pathology -\n  Neuropathology",
"Pathology -\n  Chemical",
"Pathology -\n  Forensic",
"Pathology -\n  Hematology",
"Pathology -\n  Medical Microbiology",
"Pathology -\n  Molecular Genetic",
"Pathology -\n  Pediatric",
"Pediatrics",
"Pediatrics -\n  Adolescent Medicine",
"Pediatrics -\n  Child Abuse Pediatrics",
"Pediatrics -\n  Developmental-Behavioral Pediatrics",
"Pediatrics -\n  Hospice and Palliative Medicine",
"Pediatrics -\n  Medical Toxicology",
"Pediatrics -\n  Neonatal-Perinatal Medicine",
"Pediatrics -\n  Pediatric Cardiology",
"Pediatrics -\n  Pediatric Critical Care Medicine",
"Pediatrics -\n  Pediatric Emergency Medicine",
"Pediatrics -\n  Pediatric Endocrinology",
"Pediatrics -\n  Pediatric Gastroenterology",
"Pediatrics -\n  Pediatric Hematology-Oncology",
"Pediatrics -\n  Pediatric Infectious Diseases",
"Pediatrics -\n  Pediatric Nephrology",
"Pediatrics -\n  Pediatric Pulmonology",
"Pediatrics -\n  Pediatric Rheumatology",
"Pediatrics -\n  Pediatric Transplant Hepatology",
"Pediatrics -\n  Sleep Medicine",
"Pediatrics -\n  Sports Medicine",
"Physical Medicine and Rehabilitation",
"Physical Medicine and Rehabilitation -\n  Brain Injury Medicine",
"Physical Medicine and Rehabilitation -\n  Hospice and Palliative Medicine",
"Physical Medicine and Rehabilitation -\n  Neuromuscular Medicine",
"Physical Medicine and Rehabilitation -\n  Pain Medicine",
"Physical Medicine and Rehabilitation -\n  Pediatric Rehabilitation Medicine",
"Physical Medicine and Rehabilitation -\n  Spinal Cord Injury Medicine",
"Physical Medicine and Rehabilitation -\n  Sports Medicine",
"Plastic Surgery",
"Plastic Surgery -\n  Plastic Surgery Within the Head and Neck",
"Plastic Surgery -\n  Surgery of the Hand",
"Preventive Medicine",
"Preventive Medicine -\n  Aerospace Medicine",
"Preventive Medicine -\n  Occupational Medicine",
"Preventive Medicine -\n  Public Health and General Preventive Medicine",
"Preventive Medicine -\n  Addiction Medicine",
"Preventive Medicine -\n  Clinical Informatics",
"Preventive Medicine -\n  Medical Toxicology",
"Preventive Medicine -\n  Undersea and Hyperbaric Medicine",
"Psychiatry and Neurology",
"Psychiatry and Neurology -\n  Neurology with Special Qualification in Child Neurology",
"Psychiatry and Neurology -\n  Addiction Psychiatry",
"Psychiatry and Neurology -\n  Brain Injury Medicine",
"Psychiatry and Neurology -\n  Child and Adolescent Psychiatry",
"Psychiatry and Neurology -\n  Clinical Neurophysiology",
"Psychiatry and Neurology -\n  Epilepsy",
"Psychiatry and Neurology -\n  Forensic Psychiatry",
"Psychiatry and Neurology -\n  Geriatric Psychiatry",
"Psychiatry and Neurology -\n  Hospice and Palliative Medicine",
"Psychiatry and Neurology -\n  Neurodevelopmental Disabilities",
"Psychiatry and Neurology -\n  Neuromuscular Medicine",
"Psychiatry and Neurology -\n  Pain Medicine",
"Psychiatry and Neurology -\n  Psychosomatic Medicine",
"Psychiatry and Neurology -\n  Sleep Medicine",
"Psychiatry and Neurology -\n  Vascular Neurology",
"Radiology",
"Radiology -\n  Diagnostic Radiology",
"Radiology -\n  Interventional Radiology and Diagnostic Radiology",
"Radiology -\n  Radiation Oncology",
"Radiology -\n  Medical Physics",
"Radiology -\n  Hospice and Palliative Medicine",
"Radiology -\n  Neuroradiology",
"Radiology -\n  Nuclear Radiology",
"Radiology -\n  Pain Medicine",
"Radiology -\n  Pediatric Radiology",
"Radiology -\n  Vascular and Interventional Radiology",
"Surgery (General Surgery)",
"Surgery (General Surgery) -\n  Vascular Surgery",
"Surgery (General Surgery) -\n  Complex General Surgical Oncology",
"Surgery (General Surgery) -\n  Hospice and Palliative Medicine",
"Surgery (General Surgery) -\n  Pediatric Surgery",
"Surgery (General Surgery) -\n  Surgery of the Hand",
"Surgery (General Surgery) -\n  Surgical Critical Care",
"Thoracic Surgery",
"Thoracic Surgery -\n  Congenital Cardiac Surgery",
"Urology",
"Urology -\n  Female Pelvic Medicine and",
"Urology -\n  Reconstructive Surgery",
"Urology -\n  Pediatric Urology"
]


