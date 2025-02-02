# tax_calculator

A command-line application that calculates sales tax and prints receipts for shopping baskets.

## Description

This application calculates sales tax for various items based on the following rules:

- Basic sales tax rate of 10% applies to all goods, except books, food, and medical products
- Import duty of 5% applies to all imported goods with no exemptions
- Sales tax is rounded up to the nearest 0.05

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
