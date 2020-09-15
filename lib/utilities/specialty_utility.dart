import '../models/specialty.dart';


class SpecialtyUtility {
   static Specialty stringToSpecialty(String value) {
    switch (value) {
      case 'Anesthesiology':
        return Specialty.Anesthesiology;
        break;
      case 'Allergy and Immunology':
        return Specialty.AllergyAndImmunology;
        break;
      case 'Radiology':
        return Specialty.Radiology;
        break;
      case 'Pathology':
        return Specialty.Pathology;
        break;
      case 'Pediatrics':
        return Specialty.Pediatrics;
        break;
      case 'Cardiology':
        return Specialty.Cardiology;
        break;
      case 'Genetics':
        return Specialty.Genetics;
        break;
      case 'Electrophysiology':
        return Specialty.Electrophysiology;
        break;
      case 'Psychiatry':
        return Specialty.Psychiatry;
        break;
      case 'Neurology':
        return Specialty.Neurology;
        break;
      case 'Dermatology':
        return Specialty.Dermatology;
        break;
      case 'Emergency':
        return Specialty.Emergency;
        break;
      case 'Endocrinology':
        return Specialty.Endocrinology;
        break;
      case 'Diabetes and Metabolism':
        return Specialty.DiabetesAndMetabolism;
        break;
      case 'Gastroenterology':
        return Specialty.Gastroenterology;
        break;
      case 'Geriatric Medicine':
        return Specialty.GeriatricMedicine;
        break;
      case 'Oncology':
        return Specialty.Oncology;
        break;
      case 'Toxicology':
        return Specialty.Toxicology;
        break;
      case 'Neonatal or Perinatal':
        return Specialty.NeonatalPerinatal;
        break;
      case 'Nephrology':
        return Specialty.Nephrology;
        break;
      case 'Otolaryngology':
        return Specialty.Otolaryngology;
        break;
      case 'Obstetrics and Gynecology':
        return Specialty.ObstetricsAndGynecology;
        break;
      case 'Pulmonology':
        return Specialty.Pulmonology;
        break;
      case 'Rheumatology':
        return Specialty.Rheumatology;
        break;
      case 'Hepatology':
        return Specialty.Hepatology;
        break;
      case 'Urology':
        return Specialty.Urology;
        break;
      default:
        return Specialty.InvalidSpecialty;
        break;
    }
  }

  static String specialtyToString(Specialty specialty) {
    switch (specialty) {
      case Specialty.Anesthesiology:
        return 'Anesthesiology';
        break;
      case Specialty.AllergyAndImmunology:
        return 'Allergy and Immunology';
        break;
      case Specialty.Radiology:
        return 'Radiology';
        break;
      case Specialty.Pathology:
        return 'Pathology';
        break;
      case Specialty.Pediatrics:
        return 'Pediatrics';
        break;
      case Specialty.Cardiology:
        return 'Cardiology';
        break;
      case Specialty.Genetics:
        return 'Genetics';
        break;
      case Specialty.Electrophysiology:
        return 'Electrophysiology';
        break;
      case Specialty.Psychiatry:
        return 'Psychiatry';
        break;
      case Specialty.Neurology:
        return 'Neurology';
        break;
      case Specialty.Dermatology:
        return 'Dermatology';
        break;
      case Specialty.Emergency:
        return 'Emergency';
        break;
      case Specialty.Endocrinology:
        return 'Endocrinology';
        break;
      case Specialty.DiabetesAndMetabolism:
        return 'Diabetes and Metabolism';
        break;
      case Specialty.Gastroenterology:
        return 'Gastroenterology';
        break;
      case Specialty.GeriatricMedicine:
        return 'Geriatric Medicine';
        break;
      case Specialty.Oncology:
        return 'Oncology';
        break;
      case Specialty.Toxicology:
        return 'Toxicology';
        break;
      case Specialty.NeonatalPerinatal:
        return 'Neonatal or Perinatal';
        break;
      case Specialty.Nephrology:
        return 'Nephrology';
        break;
      case Specialty.Otolaryngology:
        return 'Otolaryngology';
        break;
      case Specialty.ObstetricsAndGynecology:
        return 'Obstetrics and Gynecology';
        break;
      case Specialty.Pulmonology:
        return 'Pulmonology';
        break;
      case Specialty.Rheumatology:
        return 'Rheumatology';
        break;
      case Specialty.Hepatology:
        return 'Hepatology';
        break;
      case Specialty.Urology:
        return 'Urology';
        break;
      default:
        return 'Invalid specialty';
        break;
    }
  }
}
