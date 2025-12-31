using System.ComponentModel.DataAnnotations;

namespace Part1_REST_API.Models;

public class Order
{
    public int Id { get; set; }

    [Required(ErrorMessage = "Product name is required")]
    public string Product { get; set; } = string.Empty; 

    public int Quantity { get; set; } = 1; 

    [Required]
    public string Category { get; set; } = string.Empty;

    
    public string Status { get; set; } = "Pending"; 

    public DateTime OrderDate { get; set; } = DateTime.UtcNow;
}
