using System.ComponentModel.DataAnnotations;

namespace Part1_REST_API.Models;

public class Order
{
    public int Id { get; set; }

    [Required(ErrorMessage = "Product name is required")]
    public string Product { get; set; } = string.Empty; // Renamed from 'Name' to be more specific

    public int Quantity { get; set; } = 1; // Added minimal default

    [Required]
    public string Category { get; set; } = string.Empty;

    // TODO: move this to an Enum later if we have time
    public string Status { get; set; } = "Pending"; 

    public DateTime OrderDate { get; set; } = DateTime.UtcNow;
}
