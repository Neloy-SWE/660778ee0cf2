using System.ComponentModel.DataAnnotations;

namespace system_metrics.Application.Validation
{

    public class TimeStampAttribute : ValidationAttribute
    {
        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            if (value is DateTime dateTime)
            {
                if (dateTime > DateTime.UtcNow)
                {
                    return new ValidationResult(ErrorMessage ?? "Timestamp cannot be in the future.");
                }
            }
            return ValidationResult.Success;
        }
    }
}