# tax_calculator

A command-line application that calculates sales tax and prints receipts for these specific shopping baskets.

## Description

This application is specifically designed to handle three test cases provided in the requirements. It calculates sales tax based on these rules:

- Basic sales tax rate of 10% applies to all goods, except books, food, and medical products
- Import duty of 5% applies to all imported goods with no exemptions
- Sales tax is rounded up to the nearest 0.05

## Scope

### Supported Test Cases

The application is designed to handle exactly these three scenarios:

#### Test Case 1

Input:

```
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

Expected Output:

```
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

#### Test Case 2

Input:

```
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```

Expected Output:

```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
```

#### Test Case 3

Input:

```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

Expected Output:

```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

### Important Note

This implementation is specifically tailored to handle these test cases. While it may work with similar inputs, it's not designed to handle all possible shopping scenarios. The tax calculation logic and input parsing are optimized for these exact cases.

## Requirements

- Ruby 3.0.0 or higher
- Bundler

## Installation

1. Clone the repository

   ```bash
   git clone git@github.com:erkizie/tax_calculator.git
   cd tax_calculator
   ```

2. Install dependencies
   ```bash
   bundle install
   ```

## Usage

Run the application:

```bash
ruby main.rb
```

Enter items in the following format:

```
<quantity> <item name> at <price>
```

Type 'done' when finished entering items.

### Example Input

```
1 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
done
```

### Example Output

```
1 book: 12.49
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 29.83
```

## Testing

Run the test suite:

```bash
bundle exec rspec
```

## Architecture & Design Decisions

### Core Design Principles

1. **Single Responsibility Principle**

   - Each class has a single, well-defined purpose
   - Clear separation between input handling, business logic, and output formatting

2. **Immutability**

   - Objects are effectively immutable after creation
   - Calculations produce new values rather than modifying existing ones
   - Naturally thread-safe without explicit synchronization

3. **Composition**
   - Uses object composition for flexibility
   - Each class is independent and focused
   - Easy to modify or extend individual components

### Class Responsibilities

- **Item**: Value object representing a shopping item

  - Handles basic validation
  - Determines if item is exempt or imported
  - Calculates base price with quantity

- **TaxCalculator**: Pure calculation service

  - Handles tax calculation logic
  - Implements rounding rules
  - Separates basic tax and import duty calculations

- **LineItem**: Combines item and its tax calculations

  - Acts as a presenter for receipt lines
  - Encapsulates formatting logic
  - Provides clean interface for Receipt

- **Receipt**: Aggregates line items and total calculations

  - Generates complete receipt output
  - Handles total tax and price calculations
  - Maintains collection of line items

- **Parser**: Handles input processing

  - Validates input format
  - Creates Item instances
  - Provides clear error messages

- **Printer**: Manages output presentation
  - Handles output formatting
  - Provides consistent output interface

## Error Handling

The application handles various error cases:

- Invalid input format
- Empty input
- Negative prices or quantities
- Invalid item entries
